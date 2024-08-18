import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/utility/auth_bloc/auth_bloc.dart';
import 'package:mabrook/utility/router.dart';
import 'package:mabrook/utility/shared_prefs.dart';
import 'package:mabrook/utility/user_info.dart';
import 'package:mabrook/utility/utils.dart';

import 'flavor_config.dart';

Future<void> mainCommon(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtils.init();

  UserInfo.setConfigData(jsonEncode(config));
  print("config: $config");
  print("UserInfo.decodedMap.appTitle: ${UserInfo.decodedMap.appTitle}");
  print("UserInfo.decodedMap.buildType: ${UserInfo.decodedMap.buildType}");
  print("UserInfo.decodedMap.baseApiDetails: ${UserInfo.decodedMap.baseApiDetails}");

  if (Platform.isAndroid) {}

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MyApp(config: config),
    ),
  );
}

class MyApp extends StatefulWidget {
  FlavorConfig? config;

  MyApp({Key? key, required this.config}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter router = AppRouter();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(AppStarted(widget.config));
    BlocProvider.of<AuthBloc>(context).add(DeepLink());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      //navigatorObservers: [routeObserver],
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Roboto'),
    );
  }
}
