import 'package:added/app/data/initial_data.dart';
import 'package:added/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(SubSubjectAdapter());
  Hive.registerAdapter(FlashCardAdapter());

  bool isFirstOpen = await checkFirstOpen();

  if (isFirstOpen) {
    print('here');
    await initHiveData();
    await markFirstOpen();
  }

  runApp(
    GetMaterialApp(
      title: "عداد",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"),
      ],
      locale: const Locale("ar", "AE"),
    ),
  );
}

Future<bool> checkFirstOpen() async {
  var box = await Hive.openBox('settings');
  return !box.containsKey('firstOpen');
}

Future<void> markFirstOpen() async {
  var box = await Hive.openBox('settings');
  await box.put('firstOpen', true);
}
