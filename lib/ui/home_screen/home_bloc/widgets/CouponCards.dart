import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/response/get_player_coupon_response.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_bloc.dart';
import 'package:mabrook/ui/home_screen/home_bloc/home_event.dart';
import 'package:mabrook/ui/home_screen/home_bloc/widgets/MySeparator.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class CouponCards extends StatefulWidget {
  final Content playerResponseList;

  const CouponCards({Key? key, required this.playerResponseList})
      : super(key: key);

  @override
  State<CouponCards> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              2.0,
              2.0,
            ),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: widget.playerResponseList.status == "ACTIVE"
          ? _activeCard() // for active status
          : widget.playerResponseList.status == "USED"
              ? _usedCard() // for used status
              : _expiredCard() // for expired status
      ,
    ).pOnly(left:5);
  }

  _activeCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: MabrookColor.lightGreen,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                    widget.playerResponseList.logoUrl.toString(),
                    fit: BoxFit.cover),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.playerResponseList.couponName.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start)
                        .pOnly(bottom: 8),
                    Text(
                        "Redeem till : ${getFormattedValidTillDate(widget.playerResponseList.validTillDate).replaceAll("-", "\n")}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12))
                  ],
                ).pOnly(left: 10),
              ),
              ElevatedButton (
                  style: ElevatedButton.styleFrom(
                    primary: MabrookColor.lawnGreen,
                    onPrimary: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    minimumSize: const Size(40, 40),
                  ),
                  onPressed: () {
                    log(widget.playerResponseList.couponCode.toString());
                    BlocProvider.of<HomeBloc>(context).add(HomeBuyTicketApiCallEvent(widget.playerResponseList.logoUrl, widget.playerResponseList.couponName, widget.playerResponseList.couponCode));
                  },
                  child: Text(context.l10n.redeem_now,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                      .pOnly(top: 18, bottom: 18, left: 8, right: 8))
            ],
          ),
        ).pOnly(bottom: .5) ,
       const MySeparator(height: 2, color: Colors.grey),
        Container(
          child: Row(
            children: [
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.voucher_no,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      widget.playerResponseList.couponCode.toString(),
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ).pOnly(left: 10),
              ),
              Expanded(child: Container(),),
              widget.playerResponseList.drawNumber != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.ticket_no,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    widget.playerResponseList.drawNumber.toString(),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )
                ],
              ).p(8)
                  : Container()
            ],
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ).pOnly(top:18, bottom: 18)
      ],
    );
  }

  _usedCard() {
    return GestureDetector(
      onTap: () {
        /*showModalBottomSheet(
          context: context,
          builder: (context) {
            return UsedTicketSheet(widget.playerResponseList.drawNumber.toString());
          },
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
        );*/
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: MabrookColor.lightBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                          widget.playerResponseList.logoUrl.toString(),
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Text(widget.playerResponseList.couponName.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start)
                          .pOnly(left: 8),
                    ),
                    widget.playerResponseList.drawDate != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Draw on",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                               Text(
                                 getFormattedOnlyDate(widget.playerResponseList.drawDate.toString()),
                                //getDateFromTimeStamp(int.parse(widget.playerResponseList.drawDate.toString())),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                getFormattedOnlyTime(widget.playerResponseList.drawDate.toString()),
                                //getTimeFromTimeStamp(int.parse(widget.playerResponseList.drawDate.toString())),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ).pOnly(right: 8, top: 36, bottom: 8)
                        : Container()
                  ],
                ).p(6),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    decoration: const BoxDecoration(
                      color: MabrookColor.mediumDarkBlue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      context.l10n.redeemed,

                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ).pOnly(bottom: .5),
          const MySeparator(height: 2, color: Colors.grey),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  context.l10n.voucher_no,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.playerResponseList.couponCode.toString(),
                  style: const TextStyle(color: Colors.black),
                ).pOnly(top: 2, bottom: 8),

                widget.playerResponseList.ticketNumber != null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.ticket_no,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      widget.playerResponseList.ticketNumber.toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ).pOnly(top: 2)
                  ],
                )
                    : Container()
              ],
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ).p(8)
        ],
      ),
    );
  }

  _expiredCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: MabrookColor.tomatoRed,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                        widget.playerResponseList.logoUrl.toString(),
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Text(widget.playerResponseList.couponName.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start)
                        .pOnly(left: 8),
                  ),
                  /*widget.playerResponseList.drawDate != null
                      ? Text(
                          getFormattedDayDateTime(widget.playerResponseList.drawDate.toString()),
                          //getDayDateTimeFromTimeStamp(int.parse(widget.playerResponseList.drawDate.toString())),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.start,
                        ).pOnly(top: 40, right:10)
                      : Container()*/
                ],
              ).p(6),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: MabrookColor.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(18),
                    ),
                  ),
                  child: Text(
                    context.l10n.expired,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ).pOnly(bottom: .5),
        const MySeparator(height: 2, color: Colors.red),
        Container(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.voucher_no,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    widget.playerResponseList.couponCode.toString(),
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ).pOnly(left: 10),
              Expanded(
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              /*widget.playerResponseList.drawNumber != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.ticket_no,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          widget.playerResponseList.drawNumber.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ).pOnly(right: 8)
                  : Container()*/
            ],
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        )
      ],
    );
  }
}
