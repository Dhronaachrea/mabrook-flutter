import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/dialogs/filter_sheet.dart';
import 'package:mabrook/dialogs/redeemed_success_sheet.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/status_model.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_bloc.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_event.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_state.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/custom_appBar.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_bloc/widgets/CouponCards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Content>? playerCouponResponse;
  List<Content>? filteredList;

  bool haveMoreData         = true;
  int pageNumber            = 0;
  var scrollController      = ScrollController();
  var currentSelectedStatus = "ALL";

  final List<StatusModel> statusList = [
    StatusModel("ALL", true),
    StatusModel("ACTIVE", false),
    StatusModel("USED", false),
    StatusModel("EXPIRED", false)
  ];


  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    repeatOnce();
    scrollController.addListener(pagination);
    BlocProvider.of<HomeBloc>(context).add(HomeGetPlayerCouponApiCallEvent(pageNumber: pageNumber, status: null));
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<Offset> _offsetSlideLeftAnimation = Tween<Offset>(
    begin: const Offset(-2.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  late final Animation<Offset> _offsetSlideRightAnimation = Tween<Offset>(
    begin: const Offset(2.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  void repeatOnce() async {
    await _controller.forward();
    //await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: context.l10n.vouchers,
        showDrawer: true,
        showElevation: false,
        showAppBar: true,
        isShowAddVoucherBtn: true,
        isShowFilterBtn: true,
        dialogFunction: _showDialog,
      ),
      body: Stack(
        children: [
          Container(
              color: Colors.white,
              child: BlocConsumer<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeGetPlayerCouponSuccessState) {
                    checkForMoreData(state.response.data);
                    state.response.data != null
                        ? pageNumber == 0
                            ? playerCouponResponse =
                                state.response.data?.content
                            : state.response.data?.content != null
                                ? playerCouponResponse
                                    ?.addAll(state.response.data!.content!)
                                : Container()
                        : _noVoucherAvailable();
                    if (playerCouponResponse != null && pageNumber >= 0) {
                      checkFilter(playerCouponResponse!);
                    }
                  } else if (state is HomeGetPlayerCouponErrorState) {
                    return _noVoucherAvailable();
                  }
                  return playerCouponResponse != null
                      ? (filteredList != null && (filteredList?.isEmpty ?? false))
                          ? Center(
                              child: Text(
                                context.l10n.no_voucher_available_for_applied_filter_in_fetched,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ).pSymmetric(h: 10),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: filteredList != null
                                  ? filteredList?.length
                                  : playerCouponResponse?.length,
                              itemBuilder: (context, index) {
                                var playerCouponResponseObjList =
                                    filteredList != null
                                        ? filteredList![index]
                                        : playerCouponResponse?[index];
                                log("playerCouponResponseObjList: $playerCouponResponseObjList");
                                return (index % 2 == 0)
                                    ? SlideTransition(
                                        position: _offsetSlideLeftAnimation,
                                        child: (playerCouponResponseObjList != null)
                                            ? CouponCards(
                                                playerResponseList:
                                                    playerCouponResponseObjList)
                                            : Container())
                                    : SlideTransition(
                                        position: _offsetSlideRightAnimation,
                                        child: (playerCouponResponseObjList !=
                                                null)
                                            ? CouponCards(
                                                playerResponseList:
                                                    playerCouponResponseObjList)
                                            : Container());
                              },
                            )
                      : Container();
                },
                listener: (ctx, state) {
                  if (state is HomeGetPlayerCouponErrorState) {
                    showSnackBar(context, state.errorMessage, Colors.red);
                  } else if (state is HomeBuyTicketApiCallSuccessState) {
                    showModalBottomSheet(
                        context: ctx,
                        builder: (_) {
                          return RedeemedSuccessSheet(
                            logoUrl: state.logoUrl,
                            couponName: state.couponName,
                            couponCode: state.couponCode,
                            response: state.response,
                            onClose: () {
                              state.response?.responseData?.ticketNumber ?? "";
                              state.couponCode;
                              /*setState(() {
                                if (filteredList != null){
                                  for (var i in filteredList!) {
                                    if (i.couponCode == state.couponCode){
                                      i.status = "USED";
                                      i.ticketNumber = state.response?.responseData?.ticketNumber ?? "";

                                    }
                                  }
                                } else {
                                  for (var i in playerCouponResponse!) {
                                    if (i.couponCode == state.couponCode){
                                      i.status = "USED";
                                      i.ticketNumber = state.response?.responseData?.ticketNumber ?? "";

                                    }
                                  }
                                }
                              });*/

                             setState(() {
                               var updateModelIndex = Content(status: "USED", ticketNumber: state.response?.responseData?.ticketNumber, );
                               playerCouponResponse!.forEachIndexed((index, element) {
                                 if (element.couponCode == state.couponCode) {

                                   var model = playerCouponResponse![index];
                                   model.status = "USED";
                                   model.ticketNumber = state.response?.responseData?.ticketNumber;
                                   model.drawDate = state.response?.responseData?.purchaseTime.toString();
                                   playerCouponResponse![index] = model;
                                   // playerCouponResponse![index] = updateModelIndex;

                                 }
                               }
                               );

                               if (playerCouponResponse != null &&
                                   pageNumber >= 0) {
                                 checkFilter(playerCouponResponse!);
                               }
                             });


                              //BlocProvider.of<HomeBloc>(context).add(HomeGetPlayerCouponApiCallEvent(pageNumber: pageNumber, status: currentSelectedStatus));
                            },
                          );
                        },
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ));
                  } else if (state is HomeGetPlayerCouponErrorState) {
                    showSnackBar(context, state.errorMessage, Colors.red);
                  } else if (state is HomeBuyTicketApiCallErrorState) {
                    showSnackBar(context, state.errorMessage, Colors.red);
                  }
                },
              )),
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeGetPlayerCouponLoadingState ||
                state is HomeBuyTicketApiCallLoadingState) {
              log("loading . . .");
              return Container(
                color: MabrookColor.lightTransparentGrey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: Colors.black),
                      Text(context.l10n.please_wait,
                              style: const TextStyle(
                                  color: MabrookColor.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold))
                          .pOnly(top: 22)
                    ],
                  ),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }

  void _showDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterSheet(
          statusList,
          (selectedStatus) {
            onFilter(selectedStatus);
          },
        );
      },
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
    );
  }

  void pagination() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && haveMoreData) {
      pageNumber++;
      BlocProvider.of<HomeBloc>(context).add(HomeGetPlayerCouponApiCallEvent(pageNumber: pageNumber, status: currentSelectedStatus));

    }
  }

  void onFilter(List<String> selectedStatus) {

    for (var i in statusList) {
      if (i.value == true) {
        currentSelectedStatus = i.name;
        pageNumber            = 0;
        scrollController.jumpTo(scrollController.position.minScrollExtent);
        BlocProvider.of<HomeBloc>(context).add(HomeGetPlayerCouponApiCallEvent(pageNumber: pageNumber, status: i.name));
      }
    }
  }

  void checkForMoreData(Data? data) {
    haveMoreData = (data != null && (data.totalPages == pageNumber + 1)) ? false : true;
  }

  void checkFilter(List<Content> playerCouponResponse) {
    List<String> selectedList = [];
    filteredList = null;
    for (var element in statusList) {
      if (element.value == true) {
        if (element.name == "ALL") {
          filteredList = null;
          return;
        }
        selectedList.add(element.name);
      }
    }
    for (var element in playerCouponResponse) {
      for (var selectedElement in selectedList) {
        if (element.status == selectedElement) {
          filteredList == null
              ? filteredList = [element]
              : filteredList?.add(element);
        }
      }
      if (selectedList.isNotEmpty && filteredList == null) filteredList = [];
    }
  }

  _noVoucherAvailable() {
    return Center(
        child: Text(
          context.l10n.no_vouchers_available,
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ));
  }

}
