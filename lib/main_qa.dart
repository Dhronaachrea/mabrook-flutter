import 'flavor_config.dart';
import 'main_common.dart';

void main() {
  final qaConfig = FlavorConfig()
    ..appTitle = "QA App"
    ..buildType = "QA"
    ..baseApiDetails = {
      "RAM"     : "https://ram-mabroook.lottoweaver.com",
      "VMS"     : "https://vms-mabroook.lottoweaver.com",
      "DMS"     : "https://dms-mabroook.lottoweaver.com",
      "WEAVER"  : "https://weaver-mabroook.lottoweaver.com"
    };
  print("-------- Q A ---------");
  mainCommon(qaConfig);
}