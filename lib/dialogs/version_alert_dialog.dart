import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utility/app_constant.dart';

enum VersionAlertType {
  mandatory,
  optional,
}

class VersionAlert {
  static show({
    required BuildContext context,
    required VersionAlertType type,
    required String message,
    String? description,
    VoidCallback? onUpdate,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          boxShadow: const [
                            BoxShadow(color: Colors.black),
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const HeightBox(20),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset('assets/icons/mabroook.png'),
                            ),
                            const HeightBox(20),
                            const Text(
                              AppConstants.appName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const HeightBox(20),
                            Text(
                              message,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            description != null
                                ? Text(
                                    description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ).py8()
                                : Container(),
                            const HeightBox(20),
                            type == VersionAlertType.optional
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: onCancel != null
                                              ? () {
                                                  Navigator.of(ctx).pop();
                                                  onCancel();
                                                }
                                              : () {
                                                  Navigator.of(ctx).pop();
                                                },
                                          child: const Text('Later',),
                                        ),
                                      ),
                                      const WidthBox(10),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: onUpdate != null
                                              ? () {
                                                  Navigator.of(ctx).pop();
                                                  onUpdate();
                                                }
                                              : () {
                                                  Navigator.of(ctx).pop();
                                                },
                                          child: const Text('Update'),
                                        ),
                                      ),
                                    ],
                                  )
                                : ElevatedButton(
                                    onPressed: onUpdate != null
                                        ? () {
                                            Navigator.of(ctx).pop();
                                            onUpdate();
                                          }
                                        : () {
                                            Navigator.of(ctx).pop();
                                          },
                                    child: const Text('Update Now'),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
