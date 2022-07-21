import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  // await PushNotificationService.initNotifications();
  // await constantsService.getConstants();
  // initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  String? _setInitialRoute() {
    // var firebaseUser = auth.getCurrentUser();
    return AppPages.INITIAL;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: const [
      // GlobalMaterialLocalizations.delegate,
      // GlobalCupertinoLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('es', ''), // Spanish, no country code
      // ],
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: "Application",
      initialRoute: _setInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.purple,
          iconTheme: IconThemeData(color: Palette.darkBlue),
          elevation: 0,
        ),
      ),
    );
  }
}
