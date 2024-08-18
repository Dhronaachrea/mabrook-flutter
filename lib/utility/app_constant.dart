class AppConstants {
  static const String appName                   = 'Mabroook';
  static const String appDisplayName            = 'Mabroook';
  static const String aliasName                 = 'Mabroook';
  static const String domainName                = 'Mabroook';
  static const String clientKey                 = 'NLB';
  static const String appDefaultLang            = 'en';
  static const String currencyCode              = 'SAR';
  static const String currencyId                = '25';
  static const String countryCode               = 'SA';
  static const String appDefaultCurrency        = 'LKR';
  static const String merchantCode              = 'INFINITI';
  static const String appType                   = 'CASH';
  static const String os                        = 'ANDROID';
  static const String merchantPwd               = 'ph2Nj5knd4IjWBVLc4mhmYHo1hQDEdS3FlIC2KskHpeHFhsqxD';
  static const String appDefaultCountry         = 'LK';
  static const String deviceType                = 'MOBILE';
  static const String loginDevice               = 'PC_BROWSER';
  static const String userAgent                 = 'NA';
  static const String requestIp                 = '10.160.10.23';
  static const int sessionExpiryCode            = 203;
  static final String loginTokenAsTimeStamp     = DateTime.now().millisecondsSinceEpoch.toString();
  static const String ticketGameCode            = "Raffle";
  static const String descOrderBy               = "DESC";

  static const RAM                              = "ram";
  static const VMS                              = "vms";
  static const DMS                              = "dms";
  static const WEAVER                           = "weaver";

  //***********************************| URLs |***************************************\\

/*  //QA
  static const String _ramUrl                     = "https://ram-mabroook.lottoweaver.com";
  static const String _vmsUrl                     = "https://vms-mabroook.lottoweaver.com";
  static const String _dmsUrl                     = "https://dms-mabroook.lottoweaver.com";
  static const String _weaverUrl                  = "https://weaver-mabroook.lottoweaver.com";
*/

  //UAT
  static const String _ramUrl                     = "https://uat-ram.mabroook.com";
  static const String _vmsUrl                     = "https://uat-vms.mabroook.com";
  static const String _dmsUrl                     = "https://uat-dms.mabroook.com";
  static const String _weaverUrl                  = "https://uat-weaver.mabroook.com";

  //---------------------------------------RAM-------------------------------------------\\
  static const String sendRegisterOtp             = "$_ramUrl/preLogin/sendRegOtp";
  static const String registerWithOtp             = "$_ramUrl/preLogin/registerPlayerWithOtp";
  static const String signInWithPassword          = "$_ramUrl/preLogin/playerLogin";
  static const String playerProfile               = "$_ramUrl/postLogin/playerProfile";
  static const String overallUpdatePlayerProfile  = "$_ramUrl/postLogin/overallUpdatePlayerProfile";
  static const String sendVerificationEmailLink   = "$_ramUrl/postLogin/sendVerficationEmailLink";
  static const String verifyEmailWithOtp          = "$_ramUrl/postLogin/verifyEmailWithOtp";

  //---------------------------------------DMS-------------------------------------------\\

  static const String buyTicket                   = "$_dmsUrl/DMS/ticket/buy";
  static const String getTicketDetails            = "$_dmsUrl/DMS/ticket/getTicketDetails";

  //---------------------------------------VMS-------------------------------------------\\

  static const String getPlayerCoupon             = "$_vmsUrl/client/getPlayerCoupon";
  static const String activateCoupon              = "$_vmsUrl/client/activateCoupon";

  //---------------------------------------WEAVER-------------------------------------------\\

  static const String checkAvailability           = "$_weaverUrl/Weaver/service/rest/checkAvailability";
  static const String forgotPassword              = "$_weaverUrl/Weaver/service/rest/forgotPassword";
  static const String resetPassword               = "$_weaverUrl/Weaver/service/rest/resetPassword";
  static const String profileImageUpload          = "$_weaverUrl/Weaver/service/rest/uploadAvatar";
  static const String checkUpdateVersion          = "$_weaverUrl/Weaver/service/rest/versionControl";

}
