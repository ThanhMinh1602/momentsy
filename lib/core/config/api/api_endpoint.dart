class ApiEndpoint {
  static String register = "/auth/register";
  static String login = "/auth/login";
  static String logout = "/auth/logout";
  static String forgotPassword = "/auth/forgot-password";
  static String verifyOTP = "/auth/verify-otp";
  static String resetPassword = "/auth/reset-password";
  static String fileUpload = "/file/file-upload";
  static String allImage = "/file/list-images";
  static String getUserById = "/user";
  //Chat
  static String getConversation = "/chat";

  //Friend
  static String sendFriendRequest = "/friend/send-friend-request";
  static String acceptFriendRequest = "/friend/accept-friend-request";
  static String friendRequests = "/friend/friend-requests";
  static String friendList = "/friend/friend-list";
}
