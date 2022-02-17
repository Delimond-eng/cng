import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/chat_controller.dart';
import 'controllers/manager_controller.dart';
import 'controllers/users_controller.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await GetStorage.init();
  Get.put(UsersController());
  Get.put(ManagerController());
  Get.put(ChatController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [const Locale('fr', 'FR')],
      debugShowCheckedModeBanner: false,
      title: 'cng ventes & achat',
      theme: ThemeData(
        primaryColor: Colors.yellow[800],
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
          secondary: Colors.yellow[900],
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
