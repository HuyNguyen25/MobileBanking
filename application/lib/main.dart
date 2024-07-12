import 'package:application/screens/authentication/authentication_screen.dart';
import 'package:application/screens/history/history_screen.dart';
import 'package:application/screens/home/home_screen.dart';
import 'package:application/screens/money_transfer/money_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(ProviderScope(child: const MobileBankingApp()));
}

class MobileBankingApp extends StatelessWidget {
  const MobileBankingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Mobile Banking App',
          theme: ThemeData(
            colorSchemeSeed: Colors.black,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => AuthenticationScreen(),
            "/homeScreen": (context) => HomeScreen(),
            "/moneyTransferScreen": (context) => MoneyTransferScreen(),
            "/historyScreen": (context) => HistoryScreen()
          },
        );
      }
    );
  }
}
