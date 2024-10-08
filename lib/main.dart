import 'dart:async'; 
import 'package:fe_garbage_classification_app/home_page.dart';
import 'package:fe_garbage_classification_app/start_screen/api/token_storage.dart';
import 'package:fe_garbage_classification_app/start_screen/welcome.dart';
import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<bool> _submitLogin() async {
      final prefs = await SharedPreferences.getInstance();
      String? refresh = prefs.getString('refresh_token');
      try {
        await TokenStorage.getaccessToken(refresh!);
        return true;
      } catch (e) {
        return false;}
    }
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 79, 187, 90)),
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      
      home: FutureBuilder<bool>(
        future: _submitLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Scaffold(
              body: Center(child: Text('Error occurred')),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return homePage(index: 0, profile: null); 
          } else {
            return welcum_(); 
          }
        },
      ),
    );
  }
}

///class MyAppState extends ChangeNotifier {
//}