import 'package:bmi/features/screens/home_page/home_page_bindings.dart';
import 'package:bmi/features/screens/home_page/home_page_view.dart';
import 'package:bmi/features/screens/profile_page/profile_page_bindings.dart';
import 'package:bmi/features/screens/profile_page/profile_page_view.dart';
import 'package:bmi/features/screens/splash_page/splash_page_bindings.dart';
import '../features/screens/splash_page/splash_page_view.dart';
import '/features/screens/login_page/login_page_bindings.dart';
import '/features/screens/login_page/login_page_view.dart';
import '/features/screens/register_page/register_page_bindings.dart';
import '/features/screens/register_page/register_page_view.dart';
import '/navigation/routes_constant.dart';
import 'package:get/get.dart';

List<GetPage> getPages = [
  GetPage(
    name: RoutesConstant.splashPage,
    page: () => SplashPageView(),
    binding: SplashPageBindings(),
  ),
  GetPage(
    name: RoutesConstant.loginPage,
    page: () => LoginPageView(),
    binding: LoginPageBindings(),
  ),
  GetPage(
    name: RoutesConstant.registerPage,
    page: () => RegisterPageView(),
    binding: RegisterPageBindings(),
  ),
  GetPage(
    name: RoutesConstant.homePage,
    page: () => HomePageView(),
    binding: HomePageBindings(),
  ),
  GetPage(
    name: RoutesConstant.profilePage,
    page: () => ProfilePageView(),
    binding: ProfilePageBindings(),
  ),
];
