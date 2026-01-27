class ApiConstant {
  //static String baseUrl = 'http://192.168.29.135:5005';
  static String baseUrl =
      'http://pre-nirixir-version.ap-south-1.elasticbeanstalk.com';
  //Auth Section
  static String login = '/api/user/send_otp';
  static String verifyOtp = '/api/user/verify_otp';
  static String states = '/api/location/get_states';
  static String cities = '/api/location/get_cities';
  static String updateUser = '/api/user/update_profile';
  static String updateMetric = '/api/user/update_metric';
  static String deleteUser = '/api/user/delete_user';
  // static String getUser = '/api/user/get_user_data';
  static String userDetail = '/api/user/details';
  static String createRide = '/api/ride/create_ride';
  static String myRides = '/api/ride/get_my_rides';
  static String updateRideStatus = '/api/ride/change_status';
  static String updateRideStats = '/api/ride/update_stats';
  static String deleteRides = '/api/ride/delete_ride';
  static String createPost = '/api/posts/create_post';
  static String getPosts = '/api/posts/users_posts';
  static String getPostDetail = '/api/posts';
  static String updatePost = '/api/posts/update_post';
  static String deletePost = '/api/posts/delete_post';
  static String likePost = '/api/posts/like_post';
  static String comments = '/api/posts/comments';
  static String addComments = '/api/posts/comment';
  static String community = '/api/posts/community/all';
  static String follow = '/api/user/follow';
  static String notifications = '/api/notifications/get_notifications';
  static String notificationsCount = '/api/notifications/get_unread_count';
  static String connection = '/api/user/list';
  static String createEvent = '/api/ride/community/create_ride';
  static String upcomingRides = '/api/ride/community';
  static String previousRides = 'api/ride/community';
  static String eventDetails = '/api/ride/community/get_ride';
  static String rideRequest = '/api/ride/community';
  static String rideLog = '/api/ride/ride_logs';
  static String allRideLogs = '/api/ride/all_ride_logs';
  static String overAllAnalytics = '/api/ride/ride_overall_analytics';
  static String rideAnalytics = '/api/ride/ride_analytics';
  static String addJoinRideRequest = '/api/ride/ride_analytics';
  static String achievements = '/api/cyclo/user_achievements';
  static String banners = '/api/banners/all';
  static String allAchievements = '/api/cyclo/user/get_all_achievement';
  static String assignRideRole(String rideId, String acoId) =>
      '/api/ride/community/$rideId/member/$acoId/assign_role';
  static String removeRideRole(String rideId, String acoId) =>
      '/api/ride/community/$rideId/member/$acoId/remove_role';
}
