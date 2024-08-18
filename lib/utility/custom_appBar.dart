import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? showAppBar;
  final bool? showDrawer;
  final bool? showBell;
  final bool? showCart;
  final bool? showLogin;
  final bool? showBalance;
  final String? title;
  final bool? showStatusBar;
  final bool? isCartScreen;
  final bool? isInboxScreen;
  final bool? showElevation;
  final Function dialogFunction;
  final bool? showAction;
  final bool? backButton;
  final bool? isShowAddVoucherBtn;
  final bool? isShowFilterBtn;
  final bool? isShowLogoutBtn;

  const MyAppBar({
    Key? key,
    this.showAppBar,
    this.showDrawer,
    this.showBell,
    this.showCart,
    this.showLogin,
    this.title,
    this.showStatusBar,
    this.showBalance,
    this.isCartScreen,
    this.isInboxScreen,
    this.showElevation,
    this.isShowAddVoucherBtn,
    this.isShowFilterBtn,
    this.isShowLogoutBtn,
    this.showAction = true,
    this.backButton = false,
    required this.dialogFunction,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => showAppBar == true
      ? const Size(double.infinity, kToolbarHeight)
      : const Size(double.infinity, 0);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.showStatusBar == true
          ? MabrookColor.white
          : Colors.transparent,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: AppBar(
          leading: widget.backButton!
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          elevation: widget.showElevation == false ? 0 : 4,
          centerTitle: false,
          backgroundColor: MabrookColor.white,
          title: widget.title != null
              ? FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(widget.title!,
                          style: const TextStyle(
                              color: MabrookColor.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold))
                      .pOnly(top: 8),
                )
              : const SizedBox(
                  height: kToolbarHeight * 0.8, child: Icon(Icons.drag_handle)),
          actions: widget.showAction!
              ?
                [
                  widget.isShowAddVoucherBtn != null
                    ?
                        ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Screen.scanVoucherScreen);

                    },
                    child: Text(context.l10n.add_voucher, style: const TextStyle(color: Colors.white),),
                  ).pSymmetric(v: 15, h: 15)
                    :
                        Container(),

                  widget.isShowFilterBtn != null
                    ?
                      InkWell(
                      onTap: () {
                        widget.dialogFunction.call();
                      },
                      child: Container(
                          child: const Icon(Icons.filter_alt_outlined,
                                  color: MabrookColor.black)
                              .pOnly(right: 8)),
                  )
                    :
                      Container(),

                  widget.isShowLogoutBtn != null
                      ?
                  InkWell(
                    onTap: () {
                      showUserConfirmationDialog("Are you sure want to Logout ?", "Cancel", "Logout", false);
                    },
                    child: Container(
                        child: const Icon(Icons.logout,
                            color: MabrookColor.red)
                            .pOnly(left: 8, right: 8)),
                  )
                      :
                  Container()
                ]
        : null,
        ),
      ),
    );
  }
}
