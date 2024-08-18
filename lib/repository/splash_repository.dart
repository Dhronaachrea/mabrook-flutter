import 'package:mabrook/network/api_call.dart';

import '../models/response/version_response.dart';

class SplashRepository {
  static Future<VersionResponse> checkUpdateVersion(
      Map<String, dynamic> request) async {
        return await ApiCall.checkVersionApi(request);
      }
}
