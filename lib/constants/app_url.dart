class AppUrl {
  AppUrl._();

  // base url
  static const String baseUrl = "http://192.168.65.1/api_clothes_store";

  //admin url
  static const String admin = "$baseUrl/admin";

  static const String logInAdmin = "$admin/login.php";

  //user url
  static const String users = "$baseUrl/user";

  static const String validateEmail = "$users/validate_email.php";

  static const String signUpUser = "$users/signup.php";

  static const String logInUser = "$users/login.php";

  static const String getUserFromToken = "$users/get_user_from_token.php";

  //up load image url
  static const String upLoadImage = 'https://api.imgur.com/3/image';

  //items url
  static const String items = "$baseUrl/items";

  static const String uploadNewItem = '$items/upload.php';

  //clothes url
  static const String clothes = "$baseUrl/clothes";

  static const String trendingClothes = '$clothes/trending.php';

  static const String newClothes = '$clothes/all.php';

  //cart url
  static const String cart = "$baseUrl/cart";

  static const String additem = '$cart/add.php';

  static const String cartList = '$cart/read.php';
}
