import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyhub/core/constants/global_variables.dart';
import 'package:studyhub/domain/provider/post_provider.dart';
import 'package:studyhub/domain/provider/register_provider.dart';
import 'package:studyhub/screens/login/login_screen.dart';
import 'package:studyhub/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
        ),
        ChangeNotifierProvider(create: (context) => PostProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.whiteColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.trasperantColor)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainSCreen(),
      ),
    );
  }
}
