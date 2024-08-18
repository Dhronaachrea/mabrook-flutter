import 'package:flutter/material.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/response/buy_ticket_response.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class RedeemedSuccessSheet extends StatefulWidget {
  final BuyTicketResponse? response;
  final String? logoUrl;
  final String? couponName;
  final String? couponCode;
  final VoidCallback? onClose;

  const RedeemedSuccessSheet(
      {Key? key,
      required this.response,
      required this.logoUrl,
      required this.couponName,
      required this.couponCode,
      required this.onClose})
      : super(key: key);

  @override
  State<RedeemedSuccessSheet> createState() => _RedeemedSuccessSheetState();
}

class _RedeemedSuccessSheetState extends State<RedeemedSuccessSheet> {
  @override
  Widget build(BuildContext context) {
    var onClose = widget.onClose;
    return Container(
      decoration: const BoxDecoration(
          color: MabrookColor.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Wrap(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.cancel_outlined,
                      size: 40, color: MabrookColor.black),
                  onPressed: onClose != null ? () {
                    onClose();
                    Navigator.pop(context);
                  } : () {
                    Navigator.pop(context);
                  },
                ).pOnly(right: 10, top: 10),
              ),
              const Icon(Icons.check_circle_outline,
                  size: 100, color: MabrookColor.lawnGreen).pOnly(top:20),

              Text(context.l10n.successfully_redeemed,
                  style: const TextStyle(
                      color: MabrookColor.lawnGreen,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)
              ),
              Image.network(widget.logoUrl.toString(), width: 100, height: 100)
                  .pOnly(top: 30),

              Text(widget.couponName.toString(),
                  style:
                  const TextStyle(color: MabrookColor.black, fontSize: 20))
                  .pOnly(bottom: 30),

              Text(context.l10n.ticket_no,
                  style: const TextStyle(color: Colors.grey, fontSize: 20))
                  .pOnly(bottom: 5),

              Text(widget.response?.responseData?.ticketNumber.toString() ?? "-",
                  style:
                  const TextStyle(color: MabrookColor.black, fontSize: 16))
                  .pOnly(bottom: 50),
              /*ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(300, 60),
                ),
                onPressed: () {},
                child:Text(
                  context.l10n.add_more,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ).pOnly(left: 30)*/
            ],
          ).pOnly(bottom: 40)
        ],
      ),
    );
  }
}
