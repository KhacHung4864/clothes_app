class AppUrl {
  AppUrl._();

  // base url
  static const String baseUrl = "http://192.168.65.1/api_clothes_store";

  //admin url
  static const String admin = "$baseUrl/admin";

  static const String logInAdmin = "$admin/login.php";

  static const String readOrderAdmin = "$admin/read_orders.php";

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

  static const String searchItem = '$items/search.php';

  //clothes url
  static const String clothes = "$baseUrl/clothes";

  static const String trendingClothes = '$clothes/trending.php';

  static const String newClothes = '$clothes/all.php';

  //cart url
  static const String cart = "$baseUrl/cart";

  static const String additem = '$cart/add.php';

  static const String cartList = '$cart/read.php';

  static const String updateCartItem = '$cart/update.php';

  static const String deleteCartItem = '$cart/delete.php';

  //favorite
  static const String favorite = "$baseUrl/favorite";

  static const String addFavorite = "$favorite/add.php";

  static const String deleteFavorite = '$favorite/delete.php';

  static const String validateFavorite = '$favorite/validate_favorite.php';

  static const String readFavorite = '$favorite/read.php';

  //order
  static const String order = "$baseUrl/order";

  static const String neworder = "$order/add.php";

  static const String readOrder = "$order/read.php";

  static const String updateStatusOrder = "$order/update_status.php";

  static const hostImages = "$baseUrl/transactions_proof_images/";
}
