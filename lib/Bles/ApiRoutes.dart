

import 'package:phinex/utils/app_utils.dart';

import 'Model/requests/BaseRequestSkipTake.dart';
import 'Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'Model/requests/real_state/RealStateFilterRequest.dart';
import 'Model/requests/store/FilterRequest.dart';
import 'Model/requests/store/RateByProductRequest.dart';
import 'Model/requests/wish_list/AddToWishListRequest.dart';

class ApiRoutes {

  static String search = "my/search";
  static String searchLite = "my/search-light";

  static String generalGet(String urlExtention) {
    return urlExtention;
  }

  //countries
  static String countries = "my/countries";

  // store
  static String my_products = "my/products";
  static String storeCreate = "my/users/vendor/register";
  static String storeCreateDetails = "my/users/vendor-registration-data";

  static String getProductsByCategory(FilterRequest product) {
    return "my/products/filtered" + "/skip/" + product.skip.toString() + "/take/" + product.take.toString();
  }

  static String getSignleProduct(int productID) {
    print("product id --->>>>> " + productID.toString());
    return "my/product/" + productID.toString();
  }

  static String getRatingByProductID(RateByProductRequest rate) {
    return "my/product/" + rate.productID.toString() + "/rating/skip/" + rate.skip.toString() + "/take/" + rate.take.toString();
  }

  static String filter = "my/products/filtered";

  // auth
  static String registeration = "users?";
  static String login = "my/users/login";

  static String verifyOTP(String phone, String otp) {
    return 'my/users/forgot-password/check-otp/$otp/phone/$phone';
  }

  static String forgotPassword() {
    return 'my/users/forgot-password/send';
  }

  static String updatePassword(int id) {
    return 'my/users/$id';
  }

  static String verifyPhoneForgetPassword(String otp, String phone) {
    return 'my/users/forgot-password/check-otp/$otp/phone/$phone';
  }

  static String resendOTP(int userId) {
    return 'my/users/resend-message/$userId';
  }

  // vendor links
  static String getVendorByID(dynamic vendorID) {
    return "my/vendor/" + vendorID.toString();
  }

  static String getProductsByVendor(BaseRequestSkipTake base) {
    return "my/vendor/" + base.id.toString() + "/products/skip/" + base.skip.toString() + "/take/" + base.take.toString();
  }

  static String getVendorRating(BaseRequestSkipTake base) {
    return "my/vendor/" + base.id.toString() + "/rating/skip/" + base.skip.toString() + "/take/" + base.take.toString();
  }

  // rating
  static String MakeRate = "my/rating";

  // wish list
  static String getWishListUser(int userID) {
    return "my/wishlist/user/" + userID.toString();
  }

  static String addToWishListUser = "my/wishlist";

  static String deleteFromWishListUser(WishListRequest request) {
    return "my/wishlist/user/" + request.user_id.toString() + "/product/" + request.product_id.toString();
  }

  // cart
  static String addToCart = "my/carts/add-to-cart-after-login";

  static String getUserCart(int userID) {
    return "my/carts/" + userID.toString();
  }

  static String deleteCartItem(int userID, int productID) {
    return "my/cart/" + userID.toString() + "/" + productID.toString();
  }

  static String updateCartItem(int userID, int productID) {
    return "my/cart/" + userID.toString() + "/" + productID.toString();
  }

  // order

  static String checkoutOrder() {
    return "my/orders";
  }

  static String getOrders(int userID) {
    return "my/orders/user/" + userID.toString();
  }

  static String getSingleOrder(int orderID) {
    return "my/order/" + orderID.toString();
  }

  // buy & sell

  static String buySellLanding = "my/buy-sells";
  static String buySellSearch = "my/buy-sells/search";
  static String buySellCreate = "my/buy-sells";

  static String getBuySellSingle(int singleID) {
    return "my/buy-sells/" + singleID.toString();
  }

  // static String getBuySellByCat(int catID) {
  //   return "/buy-sells/category/"+catID.toString();
  // }
  static String getBuySellByCat(SearchRequest request) {
    return "my/buy-sells/category/" + request.search + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // index
  static String indexLanding = "my/index/categories/parent/2";
  static String indexSearch = "my/catalogues/search";
  static String createCatalouge = "catalogues";

  static String indexSingle(int id) {
    return "my/index/catalogue/" + id.toString();
  }

  static String indexByCatID(BaseRequestSkipTake request) {
    print("indexByCatID request ----- >>> " + request.id.toString());
    return "my/index/catalogues/category/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // mising filter api

  //car rental
  static String carRentalFilter(BaseRequestSkipTake request) {
    return "my/car-rental/filtered/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String carRentalSearch(SearchRequest request) {
    return "my/car-rental/search/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String carRentalSingle(int id) {
    return "my/car-rental/show/" + id.toString();
  }

  static String createCarRentalString = "my/car-rental";
  static String carRentalDetails = "my/car-rental/details";

  // static String carRentalByCat(BaseRequestSkipTake request) {
  //   return "my/car-rental/filtered/"+request.skip.toString()+"/take"+request.take.toString();
  // }

  // real states  -----------------
  static String realStateFilter(RealStateFilterRequest request) {
    return "my/realestate/search-realestate/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String realStateSingle(int id) {
    return "my/realestate/" + id.toString();
  }

  static String realStateSearch = "my/realestate/search-realestate";
  static String realStateCreate = "my/users/developer/register";

  // restaurant  -------------------
  static String restaurantLanding = "my/restaurants";
  static String restaurantCreate = "my/users/restaurants-owner/register";

  // static String restaurantByCat = "";
  static String restaurantByCat(SearchRequest request) {
    return "my/restaurants/categories/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String restaurantMeals(BaseRequestSkipTake request) {
    return "my/meals/restaurants/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString() + "";
  }

  static String restaurantSearch = "my/restaurants/search";

  static String restaurantSingle(int id) {
    return "my/restaurants/" + id.toString();
  }

  // Professions
  static String professionsLanding = "my/technicians";
  static String professionsCreate = "my/users/partner/technician/register";
  static String professionsCreateDetails = "my/users/profession-registration-data";

  static String bookNowInTechnician() {
    return 'https://technicians.appointments.phinex.net/v1/tech-appointments';
  }

  static String professionsByCat(BaseRequestSkipTake request) {
    return "my/technicians/category/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString() + "";
  }

  static String ProfessionsByUser(int id) {
    return "my/technicians/" + id.toString();
  }

  static String professionsSearch = "my/technicians/search";

  //---------------------- medical ---------------------

  static String medicalLanding = "my/medical-services";

  // doctor
  static String doctorLanding = "my/doctors";
  static String doctorCreateDetails = "my/users/doctor-registration-data";
  static String doctorCreate = "my/users/doctor/register";

  static String doctorBySpecialityID(BaseRequestSkipTake request) {
    return "my/doctors/speciality/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String doctorSingle(int id) {
    return "my/doctor/user/" + id.toString();
  }

  static String doctorBookNow = "my/doctor/book-now";

  static String doctorReviews(BaseRequestSkipTake request) {
    return "my/doctors/rate-review/doctor/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // pharmacy
  static String pharmacyLanding = "my/pharmacies/random/5";
  static String pharmacyCreate = "my/users/pharmacist/register";

  static String pharmacies(BaseRequestSkipTake request) {
    return "my/pharmacies/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String pharamcySingle(int id) {
    return "my/pharmacy/" + id.toString();
  }

  static String pharmacyProducts(BaseRequestSkipTake request) {
    return "my/pharmacy/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String pharmacyReviews(BaseRequestSkipTake request) {
    return "my/pharmacies/rate-review/pharmacy/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // spa
  static String spaLanding = "my/spa";

  static String spaSingle(int id) {
    return "my/spa/" + id.toString();
  }

  static String spaPaginated(BaseRequestSkipTake request) {
    return "my/spa/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // clinic
  static String clinicLanding = "my/clinics";

  static String clinicSingle(int id) {
    return "my/clinic/" + id.toString();
  }

  // laboratories

  static String laboratoriesLanding = "my/laboratories";

  static String laboratoriesSingle(int id) {
    return "my/laboratory/" + id.toString();
  }

  static String laboratoriesPagin(BaseRequestSkipTake request) {
    return "my/laboratories/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // hostpitals

  static String hostpitalsLanding = "my/hospitals";

  static String hostpitalsSingle(int id) {
    return "my/hospital/" + id.toString();
  }

  static String hostpitalsPagin(BaseRequestSkipTake request) {
    return "my/hospital/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  // common medical (spa - lab - hospital)
  static String commonLanding(String objName) {
    return "my/" + objName;
  }

  static String commonSingle(int id, String objName) {
    return "my/" + objName + "/" + id.toString();
  }

  static String commonPagin(BaseRequestSkipTake request, String objName) {
    return "my/" + objName + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String commonBookNow = "my/clinic/book-now";

  // driver
  static String driverCreate = "my/users/driver/register";
  static String driverCreateDetails = "my/users/driver-registration-data";

  // social
  static String userProfile(int userID) {
    return "my/social/profile/" + userID.toString();
  }

  static String showFriendsRequests(int userID) {
    return "my/social/friendrequests/user/" + userID.toString();
  }

  static String showFriendList(BaseRequestSkipTake request) {
    return "my/social/friends/user/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString() + "";
  }

  static String cancelFriendRequest(int userID, int friendID) {
    return "my/social/friendrequests/user/" + userID.toString() + "/friend/" + friendID.toString();
  }

  static String acceptFriendRequest(int userID, int friendID) {
    return "my/social/friendrequests/user/" + userID.toString() + "/friend/" + friendID.toString();
  }

  static String deleteFriendRequest(int userID, int friendID) {
    return "my/social/friends/user/" + '$userID' + "/friend/" + '$friendID';
  }

  static String searchUser(SearchRequest request) {
    return "my/social/users/search/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String addNewFriend = "my/social/friendrequests";

  static String addImageToUserGallery(int userID) {
    return "my/social/user/" + userID.toString() + "/add/gallery-items";
  }

  static String updateUserProfile(int userID) {
    return "my/social/profile/" + userID.toString();
  }

  // chat
  static String showRecentChat(BaseRequestSkipTake request) {
    return "my/chatting/chats/skip/" + request.skip.toString() + "/take/" + request.take.toString() + "";
  }

  static String showMessagesChat(BaseRequestSkipTake request) {
    return "my/chatting/chat/${request.id}/messages/skip/" + request.skip.toString() + "/take/" + request.take.toString() + "";
  }

  static String getFriendsRequestCount(int userId) {
    return "my/social/user/$userId/friends-page";
  }

  static String newChat = "my/chatting/initiate";

  static String newMessageToChat(int chatID) {
    return "my/chatting/chat/" + chatID.toString() + "/messages";
  }

  static String showChatInfo(int chatID) {
    return "my/chatting/chat/" + chatID.toString() + "/info";
  }

  // rooms
  static String publicRooms = 'my/public-rooms';

  static String getRoomLanding() {
    return publicRooms;
  }

  static getSingleRoom(int roomId) {
    return 'my/rooms/$roomId';
  }

  static makePostInSingleRoom() {
    return 'my/rooms/post-message';
  }

  static createRoom() {
    return 'my/rooms/create';
  }

  static updateRoom(int roomId) {
    return 'my/rooms/$roomId';
  }

  // auctions
  static String auctionLanding = "my/auctions/categories";

  static String showAuctionByCat(BaseRequestSkipTake request) {
    return "my/auctions/categories/" + request.id.toString() + "/auctions/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String getMyAuctions(dynamic userId) {
    return 'my/auctions/user/$userId';
  }

  static String getMoreReviews(String objectName, String objectId, BaseRequestSkipTake baseRequestSkipTake) {
    return 'my/rates/type/$objectName/object-id/$objectId/skip/${baseRequestSkipTake.skip}/take/${baseRequestSkipTake.take}';
  }

  static String getSubscribedAuctions(dynamic userId) {
    return 'my/auctions/subscribed/user/$userId';
  }

  static String showAuctionSingle(BaseRequestSkipTake request) {
    // '/auction/{auctionID}/auth/presence'
    return "my/auctions/" + request.id.toString();
  }

  static String showAuctionBids(BaseRequestSkipTake request) {
    return "my/auctions/" + request.id.toString() + "/bids/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String showAuctionDeals(BaseRequestSkipTake request) {
    return "my/auctions/" + request.id.toString() + "/deals/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String makeAdeal(int auctionID) {
    return "my/auctions/" + auctionID.toString() + "/deals";
  }

  static String submitBid(int auctionID) {
    return "my/auctions/" + auctionID.toString() + "/bids";
  }

  static String submitDealReply(int auctionID) {
    return "my/auctions/deals/" + auctionID.toString() + "/reply";
  }

  static String createAuction = "my/auctions";

  // funny videos
  static String getVideos(BaseRequestSkipTake request) {
    return "my/videos/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String getVideoComments(BaseRequestSkipTake request) {
    return "my/videos/comments/video/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String getUserVideos(BaseRequestSkipTake request) {
    return "my/videos/user/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String editVideo(int videoID) {
    return "my/videos/" + videoID.toString();
  }

  static String deleteComment(int videoID) {
    return "my/videos/comment/" + videoID.toString();
  }

  static String deleteVideo(int videoID) {
    return "my/videos/" + videoID.toString();
  }

  static String addNewVideo() {
    return "my/videos";
  }

  static String getSingleVideo(int videoID) {
    return "my/videos/" + videoID.toString();
  }

  static String addCommentToVideo() {
    return "my/videos/comments";
  }

  // client taxi
  static String makeTaxiRequest() {
    return "userrequestride";
  }

  static String getVehicleTypes() {
    return "vhieclesTypes";
  }

  static String changeRideStatus() {
    return "ridestatus";
    //return "statusUserRideRequest";
  }

  static String changeRideReplyStatus() {
    return "statusUserRideRequest";
  }

  static String rateRideByUser() {
    return "rideuserrate";
  }

  static String getUserRides(int userId) {
    return "userrides/$userId";
  }

  static String getSingelRide(int rideId) {
    return "ride/$rideId";
  }

  static String getReplyRides(int rideId) {
    return "riderequest/$rideId";
  }

  static String startOrEndRide() {
    return "ridestatus";
  }

  // bank ideas
  static String bankIdeas() {
    return 'my/ideas-bank';
  }

  // news
  static String news(String language,String country,String category){
    return "sources?language=$language&country=$country&apiKey=${AppUtils.newsApiKey}&category=$category";
  }

  // jobs
  static String jobCategory(){
    return "my/jobs/categories";
  }
  static String jobrandom(int count){
    return "my/jobs/count/$count";
  }
  static String jobByCat(BaseRequestSkipTake request){
    return "my/jobs/category/${request.id}/skip/${request.skip}/take/${request.take}";
  }
  static String jobByrec(int recID){
    return "my/jobs/recruiter/$recID";
  }
  static String singleJob(int jobID){
    return "my/jobs/$jobID";
  }
  static String createJob(){
    return "my/jobs";
  }

  static String editJob(int jobID){
    return "my/jobs/$jobID";
  }

  static String deleteJob(int jobID){
    return "my/jobs/$jobID";
  }

  static String doctorReservations(int userId) {
    return "my/appointments/user/$userId";
  }

  static String techReservations(int userId) {
    return "my/tech-appointments/user/$userId";
  }


  // courses
  static String courseCategory() {
    return "my/courses/categories";
  }

  static String courserandom(int count){
    return "my/courses/count/$count";
  }

  static String courseByCat(BaseRequestSkipTake request){
    return "my/courses/category/${request.id}/skip/${request.skip}/take/${request.take}";
  }

  static String courseByrec(int recID){
    return "my/courses/recruiter/$recID";
  }

  static String singleCourse(int courseID){
    return "my/courses/$courseID";
  }

  static String createcourse(){
    return "my/courses";
  }

  static String editcourse(int courseID){
    return "my/courses/$courseID";
  }
  static String deletecourse(int courseID){
    return "my/courses/$courseID";
  }

  // suggest servuce
  static String suggestService = 'my/suggestion';

  // wholesale
  static String wholesaleLanding = "my/wholesale/categories";

  static String showWholesaleByCat(BaseRequestSkipTake request) {
    return "my/wholesale/categories/" + request.id.toString() + "/auctions/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String showWholesaleSingle(BaseRequestSkipTake request) {
    return "my/wholesale/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String showWholesaleBids(BaseRequestSkipTake request) {
    return "my/wholesale/" + request.id.toString() + "/bids/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String showWholesaleDeals(BaseRequestSkipTake request) {
    return "my/wholesale/" + request.id.toString() + "/deals/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }

  static String makeWholesaledeal(int wholesaleID) {
    return "my/wholesale/" + wholesaleID.toString() + "/deals";
  }

  static String submitWholesaleBid(int wholesaleID) {
    return "my/wholesale/" + wholesaleID.toString() + "/bids";
  }

  static String submitWholesaleDealReply(int wholesaleID) {
    return "my/wholesale/deals/" + wholesaleID.toString() + "/reply";
  }

  static String createWholesale = "my/wholesale";

  // custom service
  static String initiateNewChatWithAdmin() {
    return "my/support/initiate";
  }

  static String sendMessageToAdmin(int chatId) {
    return "my/support/chat/$chatId/messages";
  }

  static String adminChatMessages(BaseRequestSkipTake request) {
    return "my/support/chat/${request.id}/messages/skip/${request.skip}/take/${request.take}";
  }

  static String catalogueLanding(int parentID){
    return "my/index/categories/parent/$parentID";
  }
  static String catalogueSingle(int id) {
    return "my/index/catalogue/" + id.toString();
  }

  static String catalogueByCatID(BaseRequestSkipTake request) {
    return "my/index/catalogues/category/" + request.id.toString() + "/skip/" + request.skip.toString() + "/take/" + request.take.toString();
  }
}

class ApiRoutesUpdate {

  // static String mainUrlPart = 'https://developers.api.tbdm.net/v-1872020/';
  static String mainUrlPart = 'https://api.phinex.net/v-1872020/';

  static String baseUrl({String country, String language, String currency}) => "$mainUrlPart${country ?? AppUtils.country?.toLowerCase()}-${language ?? AppUtils.language ?? 'en'}-${currency ?? AppUtils.currency?.toLowerCase()}/";

  static String taxiUrl = 'https://taxi.codecaique.com/api/';

  static String newsUrl = 'https://newsapi.org/v2/';

  static link(String url) {
    print("url 111------>>>>   " + baseUrl() + url);
    return baseUrl() + url;
  }

  getLink(String url) {
    print("url 111------>>>>   " + baseUrl() + url);
    return baseUrl() + url;
  }

  getLink2(String url) {
    print("url 222------>>>>   " + taxiUrl + url);
    return taxiUrl + url;
  }

  getLink3(String url) {
    print("url 333------>>>>   " + newsUrl + url);
    return newsUrl + url;
  }
}
