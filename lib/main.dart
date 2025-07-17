import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fourtyfourties/firebase_options.dart';
import 'package:fourtyfourties/helpers/consts.dart';
import 'package:fourtyfourties/helpers/notifications_helper.dart';
import 'package:fourtyfourties/providers/base_provider.dart';
import 'package:fourtyfourties/providers/dark_theme_provider.dart';
import 'package:fourtyfourties/providers/encyclopedia_provider.dart';
import 'package:fourtyfourties/screens/auth_screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (Platform.isIOS) {
    await FirebaseMessaging.instance.getAPNSToken().then((apnToken) async {
      //     String? fcm = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print('apnToken: $apnToken');
        //       print("fcm :$fcm");
      }
    });
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      debugPrint('message-');
    }
    showFlutterNotification(message);
  });

  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
    print('notif +: ${message.data}');
    print('message--');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseProvider()),

        ChangeNotifierProvider(
          create: (_) => EncyclopediaProvider()..loadData(),
        ),
        ChangeNotifierProvider(
          create: (_) => DarkThemeProvider()..getModeFromSharedPref(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            locale: Locale("ar"),
            supportedLocales: const [Locale("ar")],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            debugShowCheckedModeBanner: false,
            title: '40x40',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
              scaffoldBackgroundColor: theme.isDark ? blackColor : greyColor,
              tabBarTheme: TabBarTheme(
                labelColor: theme.isDark ? whiteColor : blackColor,
                unselectedLabelColor:
                    theme.isDark
                        ? greyColor.withValues(alpha: 0.5)
                        : blackColor.withValues(alpha: 0.5),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(whiteColor),
                ),
              ),

              listTileTheme: ListTileThemeData(tileColor: whiteColor),
              shadowColor: blackColor,

              iconTheme: IconThemeData(
                color: theme.isDark ? whiteColor : blackColor,
              ),
            ),
            home: UpgradeAlert(showIgnore: false, child: SplashScreen()),
          );
        },
      ),
    );
  }
}
