class ResponseCode {

  ///////////////////////////// RAM //////////////////////////////////
  static const Map<String, String> ramErrorCode = {
    "ram_0"             : "Success",
    "ram_1"             : "Unknown Error Occurred, Please Try Again",
    "ram_10004"         : "Please Provide Valid Alias Name",
    "ram_10005"         : "Invalid Length Found For Domain Name",
    "ram_10006"         : "Invalid Format Found For Mobile No",
    "ram_10008"         : "Invalid JSON Found.",
    "ram_10009"         : "Requested Url Not Found",
    "ram_10012"         : "Invalid Response Found From Communication",
    "ram_10353"         : "Invalid  Alias Found",
    "ram_10514"         : "You Are Not Allowed To Perform This Action.",
    "ram_10453"         : "Otp Verification Failed.",
    "ram_10454"         : "Entered OTP is Expired. Please Try Again.",
    "ram_10460"         : "Please Provide Valid Player Profile Url.",
    "ram_10457"         : "Please Provide Valid Player Register Url.",
    "ram_10459"         : "Something went wrong, please try again later.",
    "ram_10452"         : "Player Already Exist.",
    "ram_10308"         : "Please enter valid Mobile/Email",
    "ram_406"           : "Either username or password is invalid",
    "ram_10512"         : "Not Allowed As Per Status.",
    "ram_10458"         : "Please Provide Valid Player Login Url.",
    "ram_10495"         : "Player Basic Information Not Found.",
    "ram_10103"         : "Please Provide Valid Merchant IP Address.",
    "ram_10107"         : "Please Provide Valid Email",
    "ram_10106"         : "Please Provide Valid Mobile No",
    "ram_10302"         : "Email Already Exist.",
    "ram_10306"         : "Invalid Country Found.",
    "ram_10104"         : "Invalid Currency Found.",
    "ram_10523"         : "Please Provide Valid Player Primary Id.",
    "ram_10562"         : "Player Already Exist With This Primary Id.",
    "ram_10567"         : "Player is blocked. Please contact The Administrator.",
    "ram_10528"         : "Email Not Verified For Successful Login.",
    "ram_10201"         : "Invalid Domain Found.",
    "ram_10531"         : "Only Provide Either DomainId or Merchant Domain Id",
    "ram_10536"         : "Profile Update Request Count Reached.",
    "ram_10491"         : "Invalid Player Found.",
    "ram_10526"         : "Player Profile Status Already Same As Requested",
    "ram_10540"         : "Please update Rsa Id first.",
    "ram_10538"         : "Player Profile Has To Be Active For Inactivating Its Profile.",
    "ram_10102"         : "Invalid Merchant Found.",
    "ram_10301"         : "Invalid PLayer Found.",
    "ram_10489"         : "Player Profile Update Request Not Found",
    "ram_10469"         : "Requested Player And Logged In Player Are Different.",
    "ram_10470"         : "No Verification Detail Found For Player.",
    "ram_10463"         : "No Active Doctype Exist.",
    "ram_10354"         : "No Active Alias Found.",
    "ram_10310"         : "Invalid Bank Detail Fields",
    "ram_10497"         : "Please Provide Valid Document",
    "ram_10303"         : "Mobile Already Exist",
    "ram_10110"         : "Please Provide Valid State",
    "ram_10547"         : "Invalid City Found",

  };

  ///////////////////////////// VMS //////////////////////////////////
  static const Map<String, String> vmsErrorCode = {
    "vms_0"             : "Success",
    "vms_12204"         : "No Active Alias Found.",
    "vms_12413"         : "Please Provide Valid Player Id",
    "vms_12303"         : "Please Provide Valid Provider.",
    "vms_12301"         : "Please Provide Valid Service.",
    "vms_12302"         : "Please Provide Valid Game.",
    "vms_12401"         : "Please Provide Valid DomainId",
    "vms_12051"         : "Data Not Found.",
    "vms_12304"         : "Please Provide Valid Coupon Details.",

  };

  ////////////////////////////// DMS //////////////////////////////////
  static const Map<String, String> dmsErrorCode = {
    "dms_0"             : "Success",

  };

  /////////////////////////// WEAVER ////////////////////////////////
  static const Map<String, String> weaverErrorCode = {
    "weaver_0"          : "Success",

  };

}