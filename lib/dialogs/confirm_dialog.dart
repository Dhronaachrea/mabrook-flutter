import 'package:flutter/material.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmDialog {
  static show({
    required BuildContext context,
    required String message,
    required String positiveButtonText,
    required String negativeButtonText,
  }) {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                             Navigator.pop(context, true);
                            },
                            child: const Icon(Icons.clear)
                        ),
                      ),
                      const Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const HeightBox(20),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const HeightBox(22),
                  Row(
                    children: [
                      positiveButtonText != null
                          ? Container()
                          /*ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(32.0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text(positiveButtonText,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                              .pOnly(top: 16, bottom: 16))*/
                          : Container(),
                          negativeButtonText != null
                           ?
                              const WidthBox(8)
                           :  Container(),
                           Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.grey,
                                    elevation: 3,
                                    minimumSize: const Size(10,10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0)),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text(negativeButtonText,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                      .pOnly(top: 16, bottom: 16)),
                            ),
                    ],
                  ),
                  const HeightBox(18),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
