import 'package:flutter/material.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class UsedTicketSheet extends StatefulWidget {
  final String? _ticketNo;

  const UsedTicketSheet(this._ticketNo, {Key? key}) : super(key: key);

  @override
  State<UsedTicketSheet> createState() => _UsedTicketSheetState();
}

class _UsedTicketSheetState extends State<UsedTicketSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.ticket_number,
            style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
           Text(
            context.l10n.selected_ticket_number_will_not_be_changed_in_future,
            style: const TextStyle(color: MabrookColor.warmGrey, fontSize: 20),
          ).pOnly(top: 8),
          Center(
            child: Text(
              widget._ticketNo.toString(),
              style: const TextStyle(color: MabrookColor.black, fontSize: 24, fontWeight: FontWeight.bold),
            ).pOnly(top: 16),
          ),
        ],
      ),
    ).p(20);
  }
}
