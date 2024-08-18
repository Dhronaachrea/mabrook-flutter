import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mabrook/dialogs/version_alert_dialog.dart';
import 'package:mabrook/models/response/version_response.dart';
import 'package:mabrook/repository/splash_repository.dart';
import 'package:mabrook/utility/app_constant.dart';
import 'package:mabrook/utility/screens.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  BuildContext? contextEvent;

  SplashBloc() : super(SplashInitial()) {
    on<LogPrefs>(_logPrefs);
    on<UserLogIn>(_userLogIn);
    on<CheckVersionControl>(_checkVersion);
  }

  _logPrefs(LogPrefs event, Emitter<SplashState> emit) async {
    log("---------------APP_DATA---------------");

    log("---------------USER_DATA---------------");
  }

  _userLogIn(UserLogIn event, Emitter<SplashState> emit) async {}

  _checkVersion(CheckVersionControl event, Emitter<SplashState> emit) async {

    Map<String, dynamic> request = {
      "appType"       : AppConstants.appType,
      "currAppVer"    : await getVersion(),
      "domainName"    : AppConstants.domainName,
      "os"            : AppConstants.os,
      "playerToken"   : UserInfo.userToken,
      "aliasName"     : AppConstants.aliasName,

    };

    contextEvent = event.context;

    VersionResponse? response = await SplashRepository.checkUpdateVersion(request);

    var fileName = DateTime.now().millisecondsSinceEpoch.toString() + "file.apk";

    if (response != null) {
      if (response.errorCode == 0) {
        if (response.appDetails!.isUpdateAvailable) {
          String message = response.appDetails!.message ?? "New version available. Please update to continue";

          if (response.appDetails!.mandatory == true) {
            VersionAlert.show(
              context: event.context,
              type: VersionAlertType.mandatory,
              message: message,
              onUpdate: () async {
                UserInfo.logout();
                flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                const android       = AndroidInitializationSettings('@mipmap/ic_launcher');
                const iOS           = IOSInitializationSettings();
                const initSettings  = InitializationSettings(android: android, iOS: iOS);

                flutterLocalNotificationsPlugin?.initialize(initSettings, onSelectNotification: _onSelectNotification);

                if (Platform.isAndroid) {
                  var unKnownStatus = await Permission.requestInstallPackages.status;

                  if (unKnownStatus.isDenied) {
                    await Permission.requestInstallPackages.request();
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      downloadNewVersion(response.appDetails!.url!, event.context, fileName);
                      UserInfo.logout();
                    } else {
                      await Permission.storage.request();
                      var status = await Permission.storage.status;
                      if (status.isGranted) {
                        downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                      } else {
                        _showNotificationError();

                      }
                    }
                  } else {
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                    } else {
                      await Permission.storage.request();
                      var status = await Permission.storage.status;
                      if (status.isGranted) {
                        downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                      } else {
                        _showNotificationError();

                      }
                    }
                  }
                }
                else {
                  downloadNewVersion(
                      response.appDetails!.url!,
                      event.context,
                      DateTime.now().millisecondsSinceEpoch.toString() + 'file.ipa'
                  );
                }
              },
            );
          } else {
            VersionAlert.show(
              context: event.context,
              type: VersionAlertType.optional,
              message: message,
              onUpdate: () async{
                if (Platform.isAndroid) {
                  var unKnownStatus = await Permission.requestInstallPackages.status;
                  UserInfo.logout();
                  if (unKnownStatus.isDenied) {
                    await Permission.requestInstallPackages.request();
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                    } else {
                      await Permission.storage.request();
                      var status = await Permission.storage.status;
                      if (status.isGranted) {
                        downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                      } else {
                        _showNotificationError();
                      }
                    }
                  } else {
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                    } else {
                      await Permission.storage.request();
                      var status = await Permission.storage.status;
                      if (status.isGranted) {
                        downloadNewVersion(response.appDetails!.url!, event.context, fileName);

                      } else {
                        _showNotificationError();
                      }
                    }
                  }
                }
                else {
                  downloadNewVersion(
                      response.appDetails!.url!,
                      event.context,
                      DateTime.now().millisecondsSinceEpoch.toString() + 'file.ipa');
                }
              },
              onCancel: () {
                navigateToHome(event.context);
              },
            );
          }
        } else {
          print("in else part move to home");
          navigateToHome(event.context);
        }
      }
    }
  }

  void navigateToHome(context) {
    Timer(const Duration(seconds: 2), () {
      if (UserInfo.isLoggedIn()) {
        if (context != null) {
          Navigator.pushReplacementNamed(context, Screen.home_screen);
        }
      } else {
        if (context != null) {
          Navigator.pushReplacementNamed(context, Screen.login_screen);
        }
      }
    });
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version          = packageInfo.version;

    return version;
  }

  downloadNewVersion(String url, context, String _fileName) async {
    final dir       = await _getDownloadDirectory();
    final savePath  = path.join(dir!.path, _fileName);

    await _startDownload(savePath, url);
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<void> _startDownload(String savePath, String url) async {
    final Dio _dio = Dio();

    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response      = await _dio.download(url, savePath, onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath']  = savePath;

    } catch (ex) {
      result['error'] = ex.toString();

    } finally {
      await _showNotification(result);

    }
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      // _progress = (received / total * 100).toStringAsFixed(0) + "%";
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    const android     = AndroidNotificationDetails('channel id', 'channel name', priority: Priority.high, importance: Importance.max);
    const iOS         = IOSNotificationDetails();
    const platform    = NotificationDetails(android: android, iOS: iOS);
    final json        = jsonEncode(downloadStatus);
    final isSuccess   = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin!.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  Future<void> _showNotificationError() async {
    const android   = AndroidNotificationDetails('channel id', 'channel name',priority: Priority.high, importance: Importance.max);
    const iOS       = IOSNotificationDetails();
    const platform  = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin!.show(
        0, // notification id
        'Failure',
        'There was an error while downloading the file.',
        platform,
        payload: 'json');
  }

  Future<void> _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: contextEvent!,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

}
