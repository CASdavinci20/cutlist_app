class PublicVar {
  static late int userId, userPin, basePage = 0;

  static late var hasLogin,
      onProduction = false,
      hasData = false,
      isVerified = false,
      isRegistred,
      accountApproved = false;

  //Defaults
  static int primaryColor = 0XFFF2C94C,
      primaryDark = 0XFF329F74,
      textPrimaryDark = 0XFF329F74,
      white = 0XFFFFFFFF,
      nameColor = 0xff333636,
      black = 0XFF000000;
  
  static var userEmail = "",
      userAppID = "",
      longitude = "",
      firstName = "",
      projectName = "",
      userName = "",
      lastName = "",
      userOtp = '',
      userPhone = "",
      forGotStage = "",
      latitude = "",
      appToken = "",
      defaultLogo = "assets/logo.png",
      defaultProfileImage = "assets/default-user.png",
      defaultPlaceImage = "assets/placeholder.jpg",
      noImage = "No Moment's yet,\nShare a moment or Reload",
      selectVideo = "You have not selected a video ",
      noNotification = "No Notifications ",
      verfECode ="otp not recognized",
      noComment = "No Comments yet,\nSend a Comments or Reload",
      noMessage = "No Messages yet,\nSend a message or Reload",
      checkInternet = "Please check your internet connection",
      serverError = 'something went wrong,\n please try again',
      wait = 'One moment please....',
      zeroValues = 'Please make sure all fields has a default value of zero',
      requestErrorString = "Something went wrong!!\n please try again";


      static Map<dynamic,dynamic> allList = {};
      static double creditAmount = 0.0;
    
   
}
