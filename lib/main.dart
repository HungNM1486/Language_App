import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:language_app/phunv/LoginSignup/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:language_app/locale_provider.dart'; // File bạn đã tạo trước đó
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import file sinh ra
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import flutter_local_notifications

// Khởi tạo plugin thông báo
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Gửi thông báo chào mừng
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'welcome_channel',
    'Welcome Notifications',
    channelDescription: 'Notifications when app starts',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Chào mừng đến Language App',
    'Bắt đầu học ngoại ngữ ngay hôm nay!',
    notificationDetails,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'BeVietnamPro', // Áp dụng font mặc định
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Delegate từ file sinh ra
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Tiếng Anh
        Locale('vi', 'VN'), // Tiếng Việt
      ],
      locale: localeProvider.locale, // Locale thay đổi động
      routes: {
        '/': (context) => const Loginscreen(),
        '/login': (context) => const Loginscreen(),
      },
    );
  }
}
