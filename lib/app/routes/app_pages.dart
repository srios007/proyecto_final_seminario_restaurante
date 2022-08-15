import 'package:get/get.dart';

import '../modules/add_ingredients/bindings/add_ingredients_binding.dart';
import '../modules/add_ingredients/views/add_ingredients_view.dart';
import '../modules/add_menu/bindings/add_menu_binding.dart';
import '../modules/add_menu/views/add_menu_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_user/bindings/forgot_user_binding.dart';
import '../modules/forgot_user/views/forgot_user_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_detail/bindings/menu_detail_binding.dart';
import '../modules/menu_detail/views/menu_detail_view.dart';
import '../modules/profile/add_address/bindings/add_address_binding.dart';
import '../modules/profile/add_address/views/add_address_view.dart';
import '../modules/profile/add_bank_account/bindings/add_bank_account_binding.dart';
import '../modules/profile/add_bank_account/views/add_bank_account_view.dart';
import '../modules/profile/profile/bindings/profile_binding.dart';
import '../modules/profile/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/tour/bindings/tour_binding.dart';
import '../modules/tour/views/tour_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TOUR,
      page: () => TourView(),
      binding: TourBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_USER,
      page: () => ForgotUserView(),
      binding: ForgotUserBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MENU,
      page: () => const AddMenuView(),
      binding: AddMenuBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INGREDIENTS,
      page: () => const AddIngredientsView(),
      binding: AddIngredientsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK_ACCOUNT,
      page: () => const AddBankAccountView(),
      binding: AddBankAccountBinding(),
    ),
    GetPage(
      name: _Paths.MENU_DETAIL,
      page: () => const MenuDetailView(),
      binding: MenuDetailBinding(),
    ),
  ];
}
