import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabrook/models/request/otp_model.dart';
import 'package:mabrook/models/request/rest_password_model.dart';
import 'package:mabrook/models/response/deep_link_response.dart';
import 'package:mabrook/ui/dashboard_screen/dashboard_bloc/dashboard_bloc.dart';
import 'package:mabrook/ui/dashboard_screen/dashboard_screen.dart';
import 'package:mabrook/ui/forgot_password_screen/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mabrook/ui/forgot_password_screen/forgot_screen.dart';
import 'package:mabrook/ui/otp_screen/otp_bloc/otp_bloc.dart';
import 'package:mabrook/ui/otp_screen/otp_screen.dart';
import 'package:mabrook/ui/profile_edit_screen/profile_edit_bloc/profile_edit_bloc.dart';
import 'package:mabrook/ui/profile_edit_screen/profile_edit_screen.dart';
import 'package:mabrook/ui/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:mabrook/ui/profile_screen/profile_screen.dart';
import 'package:mabrook/ui/registration_screen/registration_bloc/registration_bloc.dart';
import 'package:mabrook/ui/registration_screen/registration_screen.dart';
import 'package:mabrook/ui/reset_password_screen/reset_password_bloc/reset_password_bloc.dart';
import 'package:mabrook/ui/reset_password_screen/reset_password_screen.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_bloc/scan_voucher_bloc.dart';
import 'package:mabrook/ui/scan_voucher_screen/scan_voucher_screen.dart';
import 'package:mabrook/ui/sign_in_screen/login_screen.dart';
import 'package:mabrook/ui/sign_in_screen/sign_in_bloc/sign_in_bloc.dart';
import 'package:mabrook/ui/splash_screen/splash.dart';
import 'package:mabrook/ui/splash_screen/splash_bloc/splash_bloc.dart';
import 'package:mabrook/ui/ticket/bloc/ticket_bloc.dart';
import 'package:mabrook/ui/ticket/ticket_screen.dart';
import 'package:mabrook/utility/screens.dart';


class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashBloc(),
              ),
            ],
            child: const SplashScreen(),
          ),
          settings: settings,
        );

      case Screen.home_screen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DashBoardBloc(),
              ),
            ],
            child: const DashBoardScreen(),
          ),
          settings: settings,
        );

      case Screen.login_screen:
         return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(),
              ),
            ],
            child: const LoginScreen(),
          ),
          settings: settings,
        );

      case Screen.register_screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegistrationBloc(),
            child: const RegistrationScreen(),
          ),
          settings: settings,
        );

      case Screen.otp_screen:
        OtpModel otpModel = settings.arguments as OtpModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(create: (context) => OtpBloc()),
            BlocProvider(create: (context) => RegistrationBloc())
          ], child: OtpScreen(otpModel: otpModel)),
          settings: settings,
        );

      case Screen.forgot_password_screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordBloc(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Screen.scanVoucherScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ScanVoucherBloc(),
            child: const ScanVoucherScreen(),
          ),
        );

      case Screen.profile_screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileScreen(),
          ),
        );

      case Screen.rest_password_Screen:
        ResetPasswordModel restModel = settings.arguments as ResetPasswordModel;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ResetPasswordBloc(),
            child:  RestPasswordScreen(
              model: restModel,
            ),
          ),
          settings: settings,
        );
      case Screen.ticket:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TicketBloc(),
            child: const TicketScreen(),
          ),
        );

      case Screen.profileEditScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => ProfileEditBloc()),
                  BlocProvider(create: (context) => ProfileBloc()),
                ], child: const ProfileEditScreen()));

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashBloc>(
            create: (BuildContext context) => SplashBloc(),
            child: const SplashScreen(),
          ),
          settings: settings,
        );
    }
  }
}
