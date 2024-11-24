class Urls {
  static String domain = 'https://moniat60.com.ng',
        cutlist ='https://cutlist.onrender.com/api/v1',
      test = "http://localhost:8000/api",
      appVersion = "1.0.0",
      port30 = ":3000",
      port31 = ":3001",
      port32 = ":3002",
      ip = domain;

  //URLSPOST
  //

  static String login = "$ip$port30/users/public/login",
      register = "$ip$port30/users/new-public-user",
      cutUsers = "$cutlist/account/user-register",
      cutCreateProject ="$cutlist/create-project",
      cutFeedback = "$cutlist/feedback/user-reply",
      cutCreditStat = "$cutlist/credit/credit-status",
      cutCreditPackages = "$cutlist/credit/credit-packages",
      cutMyNotifacions ="$cutlist/feedback/my-feedback",
      allCutList = "$cutlist/tasks",
      cutLogin ="$cutlist/account/login",
      cutPreview ="$cutlist/task/preview",
      createCutlist ="$cutlist/task/save",
      cutCategories ="$cutlist/all-cat",
      cutProjects = "$cutlist/get-projects",
      cutProjectUrl = "$cutlist/project",
      cutVerification ="$cutlist/account/verify-otp",
      cutResendOTP = "$cutlist/account/regenerate-otp",

      user = "$ip/user",
      dashboard = "$ip/dashboard",
      checkAppVersion = "$ip/app/current-version",
      verify = "$ip/verifyuser",
      resendCode = "$ip/resend-code",
      investments = "$ip/investments",
      portfolios = "$ip/portfolios",
      invoices = "$ip/invoices",
      partners = "$ip/partners",
      bonus = "$ip/bonus",
      withdrawalMethods = "$ip/withdrawal-request",
      accountTransfer = "$ip/account-transfer",
      purchaseInvestment = "$ip/purchase-investment",
      withdrawalActivities = "$ip/withdrawal-history",
      reinvest = "$ip/reinvest",
      updatePassword = "$ip/update-password",
      messages = "$ip/messages";
      
}
