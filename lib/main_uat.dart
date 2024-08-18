import 'flavor_config.dart';
import 'main_common.dart';

void main() {
  final uatConfig = FlavorConfig()
    ..appTitle = "UAT App"
    ..buildType = "UAT"
    ..baseApiDetails = {
      "RAM"     : "https://uat-ram.mabroook.com",
      "VMS"     : "https://uat-vms.mabroook.com",
      "DMS"     : "https://uat-dms.mabroook.com",
      "WEAVER"  : "https://uat-weaver.mabroook.com"
    };
  print("-------- UAT ---------");
  mainCommon(uatConfig);
}