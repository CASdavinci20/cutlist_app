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
      cutVerification ="$cutlist/account/verify-otp",
      cutResendOTP = "$cutlist/account/regenerate-otp",
      passwordResetRequest = "$ip$port30/users/reset-password-request",
      passwordReset = "$ip$port30/users/password-reset/",
      updateUser = "$ip$port30/users/public/update/",
      resourcesPublic = "$ip$port32/resources/public",
      resources = "$ip$port32/resources",
      searchResources = "$ip$port32/resources/search",
      resourcesOne = "$ip$port32/resources/one",
      getCategories = "$ip$port32/categories/all",
      resourcesTypes = "$ip$port32/resources/resource-types",
      riLogin = "$ip$port30/users/login",
      riMyMessage = "$ip$port30/messages/my-messages",
      riSentMessages = "$ip$port30/messages/sent-messages",
      riPublicResources = "$ip$port32/resources/public",
      riResourcesOne = "$ip$port32/resources/one",
      riInstitute = "$ip$port31/institutes/my-institutes",
      riCreateResources = "$ip$port31/resources/new",
      riInstituteFile ="$ip$port31/institutes",
      riCreateMessage = "$ip$port30/messages/new",
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
