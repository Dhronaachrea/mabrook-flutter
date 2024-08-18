part of 'ticket_widget.dart';

class TicketCard extends StatefulWidget {
  final TicketList ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {

  @override
  Widget build(BuildContext context) {
    TicketDetails? ticketDetails = widget.ticket.ticketDetails;
    DrawDetails? drawDetails = widget.ticket.drawDetails;
    var transactionTime = formatDate(
      date: (ticketDetails?.txnTime ?? DateTime.now()).toString(),
      inputFormat: Format.apiDateFormat2,
      outputFormat: Format.drawDateFormatTxn,
    );
    var drawDate = formatDate(
      date: (drawDetails?.drawDateTime ?? DateTime.now()).toString(),
      inputFormat: Format.apiDateFormat2,
      outputFormat: Format.drawDateFormat,
    );
    return ShadowCard(
      disableShadow: true,
      onTap: () {},
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      backgroundColor: widget.ticket.ticketDetails?.winstatus == "WIN" ? MabrookColor.lightGreen : MabrookColor.lightTransparentGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 14, bottom: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drawDetails?.drawName.toString() ?? "",
                              style: const TextStyle(
                                color: MabrookColor.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              drawDate,
                              // (widget.ticket.drawDetails?.drawDateTime ?? "")
                              //     .toString(),
                              //"27 May 2022, 2:00 pm",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: MabrookColor.darkBlue,
                              ),
                            ),
                          ],
                        ),
                        const HeightBox(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.ticket_no,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(widget.ticket.ticketNumber ?? "", style: const TextStyle(color: Colors.black)),

                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                        'assets/images/ticket_raffle.png',
                        fit: BoxFit.cover,
                        width: 110,
                        height: 70,
                      ).pOnly(right: 10)
                  ],
                ).pOnly(left: 14),

                const MySeparator(height: 2, color: Colors.grey).pOnly(top: 6,bottom: 6),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex:6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.voucher_no,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                              widget.ticket.voucherNumber ?? "",
                              style: const TextStyle(color: Colors.black)
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.txn_time,
                          style: const TextStyle(
                            color: MabrookColor.grey,
                          ),
                        ),
                        Text(
                          transactionTime.toString().replaceAll("-", "\n"),
                          // (widget.ticket.drawDetails?.drawDateTime ?? "")
                          //     .toString(),
                          //"27 May 2022, 2:00 pm",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: MabrookColor.darkBlue,
                          ),
                        ),
                      ],
                    ).pOnly(left: 15,right: 11),

                    Expanded(child: Container(
                      width: 1,
                    )),

                    (((ticketDetails?.winstatus ?? "") == "WIN") && ((widget.ticket.ticketDetails?.winningAmount.toString().split(".")[0] ?? "0") != "0"))
                        ?
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                   width: 120,
                                   height: 80,
                                   decoration: BoxDecoration(
                                     color: Colors.green,
                                       border: Border.all(
                                         color: Colors.green,
                                       ),
                                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(60), bottomLeft: Radius.circular(60))
                                   ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "You have won",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                      Text(
                                          "Rs. ${widget.ticket.ticketDetails?.winningAmount.toString().split(".")[0] ?? "0"}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        :
                            Container()

                  ],
                ).pOnly(left: 14)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
