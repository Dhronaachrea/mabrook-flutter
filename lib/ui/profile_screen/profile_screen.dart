import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/dialogs/image_preview_sheet.dart';
import 'package:mabrook/models/response/player_profile_response.dart';
import 'package:mabrook/ui/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:mabrook/ui/profile_screen/profile_bloc/profile_event.dart';
import 'package:mabrook/ui/profile_screen/profile_bloc/profile_state.dart';
import 'package:mabrook/ui/profile_screen/widget/image_placeholder_widget.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/custom_appBar.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isRefreshAllowed = false;
  final _emailOtp       = TextEditingController();

  PlayerProfileResponse? playerProfileResponse;
  String _name                      = "--";
  String _mobileNo                  = "--";
  String _emailId                   = "--";
  String _dob                       = "--";
  String _imagePath                 = "";
  String _nationality               = "";
  bool _isGetOtpBtnActive           = false;
  bool _isOtpSend                   = false;
  bool isErrorOnSettingProfileImage = false;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProfileBloc>(context).add(PlayerProfileApiCallEvent());

    _emailOtp.addListener(() {
      setState(() {
        isOtpValid() ? _isGetOtpBtnActive = true : _isGetOtpBtnActive = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: context.l10n.my_profile,
        showDrawer: true,
        showElevation: false,
        showAppBar: true,
        isShowLogoutBtn: true,
        backButton: true,
        dialogFunction: () {},
      ),
      body: Stack(
        children: [
      BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is PlayerProfileSuccessState) {
            playerProfileResponse = state.response;
            //UserInfo.setPlayerEmailVerified(playerProfileResponse?.playerInfoBean?.emailVerified ?? "N");

                _name         = "${UserInfo.firstname.isNotEmpty ? UserInfo.firstname.capitalized : "-"} ${UserInfo.lastname.isNotEmpty ? UserInfo.lastname.capitalized : ""}";
                //_mobileNo     = "${UserInfo.countryCode.isNotEmpty ? UserInfo.countryCode : "-"} ${UserInfo.mobileNo.isNotEmpty ? UserInfo.mobileNo : "--"}";
                _mobileNo     = UserInfo.mobileNo.isNotEmpty ? UserInfo.mobileNo : "--";
                _emailId      = UserInfo.emailId.isNotEmpty ? UserInfo.emailId : "--";
                _dob          = UserInfo.dob.isNotEmpty ? UserInfo.dob : "--";
                _nationality  = playerProfileResponse?.basicPlayerInfo?.nationality ?? "--";
                _imagePath    = UserInfo.profileImage != null ? UserInfo.profileImage : "";

          } else if (state is ProfileImageUploadSuccessState) {
            if(state.response.avatarPath != null) {
              imageCache?.clear();
              imageCache?.clearLiveImages();

              (state.response.avatarPath != null && state.response.avatarPath!.isNotEmpty)
                  ?
                      UserInfo.setPlayerProfileImage( state.response.avatarPath ?? "")
                  :
                      "";
              CachedNetworkImage.evictFromCache(UserInfo.profileImage);
            }
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MabrookColor.black, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(150)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _imagePath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        const PlaceholderImage(),
                        errorWidget: (context, url, error) =>
                        const PlaceholderImage(),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 60,
                        ),
                      ),
                    ).pOnly(top:16),
                    Positioned(
                        bottom: 0,
                        right: -45,
                        child: RawMaterialButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return Wrap(children: [ImagePreviewSheet(imagePath: _imagePath, optionSelected: (optionSelectedValue) async {
                                  BlocProvider.of<ProfileBloc>(context).add(ProfileImageUploadApiCallEvent(context, optionSelectedValue));
                                },)]);
                              },
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                              ),
                            );
                          },
                          elevation: 0.0,
                          fillColor: MabrookColor.black,
                          child: const Icon(Icons.camera_alt_outlined, color: MabrookColor.lightGrey, size: 20),
                          shape: const CircleBorder(),
                        ).p(8)),
                  ],
                ),
                Text(_name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold))
                    .pOnly(top: 16),
                Text(_mobileNo,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16))
                    .pOnly(top: 8),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MabrookColor.lightGrey),
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  side: const BorderSide(
                                      color: MabrookColor
                                          .lightGreyCardBorder)))),
                  onPressed: () {
                    Navigator.pushNamed(context, Screen.profileEditScreen);
                  },
                  child: Text(context.l10n.cap_edit,
                          style: const TextStyle(
                              color: MabrookColor.fadedBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                      .pOnly(top: 12, bottom: 12, left: 16, right: 16),
                ).pOnly(top: 20, bottom: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Screen.ticket);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MabrookColor.extraLightPurple,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1.0, color: Colors.deepPurple)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.list_alt_outlined,
                              size: 60, color: Colors.deepPurple),
                        Center(
                          child: Text(context.l10n.my_tickets,
                              style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)
                            ).pOnly(left: 16),
                        )
                        ],
                      ).pOnly(top: 16, bottom: 20, left: 24, right: 24),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.l10n.email_address,
                                      style: const TextStyle(
                                          color: MabrookColor.warmGrey,
                                          fontSize: 18),
                                      textAlign: TextAlign.center)
                                  .pOnly(top: 12),

                              UserInfo.isEmailVerified()
                                  ?
                                    const Icon(Icons.check_circle,size: 17, color: Colors.green)
                                  :
                                    Container()
                            ],
                          ),
                          Row(
                            children: [
                              Text(_emailId,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)).pOnly(top: 2),
                              Expanded(child: Container()),
                              (!UserInfo.isEmailVerified() && UserInfo.emailId.isNotEmpty)
                                  ?
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    side: const BorderSide(
                                                        color: Colors.grey
                                                    )
                                                )
                                            )
                                        ),
                                        onPressed: () {
                                          if (!UserInfo.isEmailVerified()) {
                                            BlocProvider.of<ProfileBloc>(context).add(EmailVerifyApiCallEvent(_emailId));
                                          }
                                        },
                                        child: Text(_isOtpSend ? "Resend Otp" :"Get Otp",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold
                                            )
                                        ).pOnly(
                                            top: 12,
                                            bottom: 12,
                                            left: 2,
                                            right: 2 ),
                              ).pOnly(left: 20,right: 20)
                                  :
                                    Container()
                            ],
                          ),
                        ],
                      ),
                      UserInfo.isEmailVerified()
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (state is EmailVerifySuccessState)
                                    ? Text(
                                            context.l10n.we_have_send_otp_on_your_email_id,
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12),
                                            textAlign: TextAlign.center)
                                        .pOnly(top: 3)
                                    : (state is VerifyEmailWithOtpSuccessState)
                                        ? Container()
                                        :
                                          UserInfo.emailId.isNotEmpty
                                              ?
                                                Text(
                                                  context.l10n.not_verified_click_to_verify,
                                                  style: const TextStyle(
                                                      color: MabrookColor.red,
                                                      fontSize: 12),
                                                  textAlign: TextAlign.center).pOnly(top: 3)
                                              :
                                                Container(),

                                ((state is EmailVerifySuccessState) && (state is! VerifyEmailWithOtpSuccessState))
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.l10n.enter_otp_to_verify,
                                            style: const TextStyle(
                                                color:
                                                    MabrookColor.warmGrey,
                                                fontSize: 20),
                                          ).pOnly(top: 8),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  maxLines: 1,
                                                  controller: _emailOtp,
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(
                                                        _isGetOtpBtnActive
                                                            ? MabrookColor
                                                                .white
                                                            : MabrookColor
                                                                .lightGrey),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    60),
                                                            side: BorderSide(
                                                                color: _isGetOtpBtnActive
                                                                    ? MabrookColor
                                                                        .lawnGreen
                                                                    : MabrookColor
                                                                        .lightGreyCardBorder)))),
                                                onPressed: () {
                                                  if (isOtpValid()) {
                                                    BlocProvider.of<ProfileBloc>(context).add(
                                                        VerifyEmailWithOtpApiCallEvent(
                                                            _emailId,
                                                            _emailOtp.text.toString()
                                                        )
                                                    );
                                                  }
                                                },
                                                child: Text(context.l10n.cap_verify,
                                                        style: TextStyle(
                                                            color: _isGetOtpBtnActive
                                                                ? MabrookColor
                                                                    .lawnGreen
                                                                : MabrookColor
                                                                    .fadedBlack,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                    .pOnly(
                                                        top: 12,
                                                        bottom: 12,
                                                        left: 2,
                                                        right: 2),
                                              ).pOnly(left: 20),
                                            ],
                                          ).pOnly(top: 2, right: 20),
                                        ],
                                      ).pOnly(top: 4, bottom: 16)
                                    : Container()
                              ],
                            ),
                      Text(context.l10n.date_of_birth,
                              style: const TextStyle(
                                  color: MabrookColor.warmGrey,
                                  fontSize: 18))
                          .pOnly(top: 18),
                      Text(getFormattedDob(_dob),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)
                          .pOnly(top: 2),
                      /*Text(context.l10n.nationality,
                              style: const TextStyle(
                                  color: MabrookColor.warmGrey,
                                  fontSize: 18))
                          .pOnly(top: 18),
                      Text(_nationality,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                          .pOnly(top: 2,bottom: 15)*/
                    ],
                  ).pOnly(top: 20),
                ).pOnly(left: 30)
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is PlayerProfileErrorState) {
            showSnackBar(context, state.errorMessage, Colors.red);

          } else if (state is EmailVerifyErrorState) {
            showSnackBar(context, state.errorMessage, Colors.red);

          } else if (state is VerifyEmailWithOtpErrorState) {
            _isOtpSend = false;
            setState(() {
              _emailOtp.clear();
            });
            showSnackBar(context, state.errorMessage, Colors.red);
          } else if (state is VerifyEmailWithOtpSuccessState) {
            showSnackBar(context, "Email verified successfully", Colors.green);

          } else if (state is ProfileImageUploadErrorState) {
            showSnackBar(context, state.errorMessage ?? "NA", Colors.red);

          } else if (state is EmailVerifySuccessState) {
            _isOtpSend = true;
          }
        },
      ),
      BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is PlayerProfileLoadingState || state is EmailVerifyLoadingState || state is VerifyEmailWithOtpLoadingState ||
            state is ProfileImageUploadLoadingState) {
          log("loading . . .");
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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

  bool isOtpValid() {
    if (_emailOtp.text.isEmpty) {
      return false;
    }
    return true;
  }
}
