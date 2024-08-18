import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/response/ticket_details_response.dart';
import 'package:mabrook/ui/ticket/widget/ticket_widget.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/custom_appBar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'bloc/ticket_bloc.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  List<TicketList> ticketList = [];
  int pageNumber              = 0;
  var scrollController        = ScrollController();
  var isValidToCallApi        = true;

  @override
  void initState() {
    context.read<TicketBloc>().add(GetTicketDetailsEvent(0));
    super.initState();
    scrollController.addListener(pagination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: context.l10n.my_tickets,
        showDrawer: false,
        showElevation: true,
        showAppBar: true,
        showAction: false,
        backButton: true,
        dialogFunction: () {},
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        builder: (context, state) {
          return Stack(
            children: [
              (ticketList.isNotEmpty)
               ?
                  Column(
                    children: [
                      // const CupertinoSearchTextField()
                      //     .pSymmetric(h: 15, v: 10),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: ticketList.length,
                          itemBuilder: (context, index) {
                            return TicketCard(
                              ticket: ticketList[index],
                            );
                          },
                        ),
                      )
                    ],
                  )
               :
                  (state is! TicketLoadingState)
                      ?
                          Center(
                  child: Text(
                    context.l10n.no_tickets_available,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                      )
                  )
                      :
                          Container(),

              (state is TicketLoadingState)
                  ?
                      Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    Text(
                      context.l10n.please_wait,
                      style: const TextStyle(
                        color: MabrookColor.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ).pOnly(top: 22)
                  ],
                ),
              )
                  :
                      Container()
            ]
          );
        },

        listener: (context, state) {

          if (state is TicketSuccessState) {
            if (state.ticketDetailsResponse?.responseData?.isNotEmpty ?? false) {
              var responseData = state.ticketDetailsResponse?.responseData ?? [];
              isValidToCallApi = true;
              for( var ticketListsData in responseData) {
                for( var data in ticketListsData.ticketList!) {
                  ticketList.add(data);
                }
              }

            } else {
              isValidToCallApi = false;
            }
          }

        },
      ),
    );
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent) && isValidToCallApi) {
      pageNumber++;
      context.read<TicketBloc>().add(GetTicketDetailsEvent(pageNumber));
    }
  }
}
