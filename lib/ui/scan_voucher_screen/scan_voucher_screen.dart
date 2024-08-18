import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/response/activate_coupon_response.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_bloc.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_event.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_state.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:velocity_x/velocity_x.dart';

class ScanVoucherScreen extends StatefulWidget {
  const ScanVoucherScreen({Key? key}) : super(key: key);

  @override
  State<ScanVoucherScreen> createState() => _ScanVoucherScreenState();
}

class _ScanVoucherScreenState extends State<ScanVoucherScreen> {
  final TextEditingController _voucherCode  = TextEditingController();
  final GlobalKey qrKey                     = GlobalKey(debugLabel: 'QR');
  bool isKeyboardVisible                    = false;
  bool _isProcceedButtonActive              = false;
  bool _isProcceesButtonClickAble           = true;

  String? takeImagePath;
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    _voucherCode.addListener(() {
      setState(() {
        isCouponEntered()
            ?
        _isProcceedButtonActive = true
            :
        _isProcceedButtonActive = false;
      });
    });
  }


  /*@override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }*/

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      isKeyboardVisible = true;
    } else {
      isKeyboardVisible = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Column(
              children: [
                _titleBar(),
                Container(
                    color: MabrookColor.white,
                    child: BlocListener<ScanVoucherBloc, ScanVoucherState>(
                        listener: (context, state) {
                          if (state is ScanVoucherSuccessState) {
                            ActivateCouponResponse? response  = state.response;
                            int? failedCouponCount            = response?.data?.failedCouponCount;
                            int? succeededCouponCount         = response?.data?.successedCouponCount;
                            int? totalCouponCount             = failedCouponCount! + succeededCouponCount!;
                            String succeedCoupon              = succeededCouponCount > 1 ? "Coupons" : "Coupon";
                            String totalCoupon                = totalCouponCount > 1 ? "Coupons" : "Coupon";

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Screen.home_screen, (route) => false);
                            showSnackBar(
                              context,
                              "$succeededCouponCount $succeedCoupon added successfully out of $totalCouponCount $totalCoupon",
                              Colors.green,
                            );
                          } else if (state is ScanVoucherErrorState) {
                            _isProcceesButtonClickAble = true;
                            Navigator.pop(context);
                            showSnackBar(context, state.errorMessage, Colors.red);
                            //showSnackBar(context, "Qr-Code Already Used", Colors.red);
                          }
                        },
                        child: ListView(
                          shrinkWrap: true,
                          reverse: true,
                          children: <Widget>[
                            if (!isKeyboardVisible) _qrScannerWithGallery(),
                            _enterVoucherManually(),
                            _proceedButton()
                          ].reversed.toList(),
                        ).pOnly(left: 20, right: 20))),

                //////////////////Loader///////////////////////
                BlocBuilder<ScanVoucherBloc, ScanVoucherState>(
                    builder: (context, state) {
                  if (state is ScanVoucherLoadingState) {
                    log("loading . . .");
                    return Container(
                      color: MabrookColor.lightTransparentGrey,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                                color: Colors.black),
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
            )
          ],
        ),
      ),
    );
  }

  _titleBar() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(context.l10n.enter_scan_voucher,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
            .pOnly(top: 40, bottom: 10, left: 10));
  }

  _qrScannerWithGallery() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          (takeImagePath == null)
              ? _buildQrView(context) // cam scanner
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Image.file(
                    File(takeImagePath ?? ""),
                  )),
          Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                  String? path = image?.path;
                  if (path != null) {
                    String? result = await Scan.parse(path);
                    if (result != null) {
                      setState(() {
                        takeImagePath = path;
                      });

                      try {


                        Map<String, dynamic> scanRequest = jsonDecode(result);
                        scanRequest["aliasName"] = AppConstants.aliasName;
                        var lst = [];
                        for (dynamic i in scanRequest["postData"]["data"]) {
                          i["code"];
                          lst.add(i["code"]);
                        }

                        Map<String, dynamic> request = {
                          "aliasName": AppConstants.aliasName,
                          "couponCode": lst,
                          "gameCode": "RAFFLE",
                          "userId": UserInfo.userId,
                          "referenceId": "EngineRef",
                          "serviceCode": "DRAW_GAMES",
                          "providerCode": "DGE"
                        };

                        BlocProvider.of<ScanVoucherBloc>(context).add(ScanVoucherCallApiEvent(request));

                      } on Exception catch (e) {
                        showSnackBar(context, "Not a Valid Qr-code!", Colors.red);
                        log("error:  $e");

                      } catch (e) {
                        showSnackBar(context, "Not a Valid Qr-code!", Colors.red);

                      }
                      log("Image Scan Result:-------------->$result");
                    } else {
                      showSnackBar(context, "Image Not Recognized", Colors.red);

                    }
                  } else {
                    log("=============>Error on Image QR-Code Scan<===============");

                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                          ).pOnly(right: 8),
                          Text(
                            context.l10n.select_code_from_picture,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                ),
              ))
        ],
      ),
    );
  }

  _enterVoucherManually() {
    return Column(
      children: [
        Text(context.l10n.enter_voucher_code,
                style: const TextStyle(fontSize: 24, color: Colors.grey))
            .pOnly(top: 20),
        TextField(
          scrollPadding: const EdgeInsets.only(bottom: 40),
          textAlignVertical: TextAlignVertical.center,
          controller: _voucherCode,
        ).pOnly(bottom: 20, left: 20, right: 20),
      ],
    );
  }

  _proceedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: _isProcceedButtonActive ? Colors.black : Colors.grey,
        onPrimary: Colors.white,
        shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: const Size(300, 50),
      ),
      onPressed: () {
        if (isCouponEntered() && _isProcceesButtonClickAble) {
          _isProcceesButtonClickAble = false;
          var requestString = '{"aliasName": "Mabroook", "userId": "${UserInfo.userId.toString()}","serviceCode": "DRAW_GAMES","gameCode": "RAFFLE","providerCode": "DGE","referenceId": "EngineRef","couponCode": ["${_voucherCode.text}"]}';
          Map<String, dynamic> requestData = jsonDecode(requestString);
          BlocProvider.of<ScanVoucherBloc>(context).add(ScanVoucherCallApiEvent(requestData));
        }
      },
      child: Text(
        context.l10n.cap_proceed,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ).pOnly(top: 10);
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 35,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        try {
          Map<String, dynamic> scanRequest = jsonDecode(scanData.code.toString());
          scanRequest["aliasName"] = AppConstants.aliasName;
          var lst = [];
          for (dynamic i in scanRequest["postData"]["data"]) {
            i["code"];
            lst.add(i["code"]);
          }

          Map<String, dynamic> request = {
            "aliasName": AppConstants.aliasName,
            "couponCode": lst,
            "gameCode": "RAFFLE",
            "userId": UserInfo.userId,
            "referenceId": "EngineRef",
            "serviceCode": "DRAW_GAMES",
            "providerCode": "DGE"
          };

          BlocProvider.of<ScanVoucherBloc>(context).add(ScanVoucherCallApiEvent(request));

        } on Exception catch (e) {
          showSnackBar(context, "Not a Valid Request!", Colors.red);
          controller.resumeCamera();
          log("error:  $e");
        } catch (e) {
          showSnackBar(context, "Not a Valid Request!", Colors.red);
          controller.resumeCamera();
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  isCouponEntered() {
    if (_voucherCode.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
