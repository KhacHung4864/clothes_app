import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  void signOutUser() async {
    var resultConfirm = await showDialogConfirm('Logout', 'Are you sure?\nYou want to logout from app?');
    if (resultConfirm == 'loggedOut') {
      AppStorage().removeString(SKeys.tokenUser).then((value) => Get.offNamedUntil(Routes.login, (route) => false));
    }
  }
}
