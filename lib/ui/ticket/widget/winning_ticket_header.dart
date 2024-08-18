part of "ticket_widget.dart";

class WinningTicketHeader extends StatelessWidget {
  const WinningTicketHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(
            color: MabrookColor.aquamarine_50_10,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.congratulations,
                style: const TextStyle(
                  color: MabrookColor.aquamarine,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        context.l10n.you_won,
                        style: const TextStyle(
                          color: MabrookColor.aquamarine,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${AppConstants.currencyCode} ",
                              style: TextStyle(
                                color: MabrookColor.darkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "100",
                              style: TextStyle(
                                color: MabrookColor.darkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).pSymmetric(h: 5),
                  SvgPicture.asset("assets/svg/win.svg")
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
