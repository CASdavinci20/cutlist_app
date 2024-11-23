import 'package:cutlist/login/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main_utils/bloc/app_bloc.dart';
import 'main_utils/models/PublicVar.dart';
import 'SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppBloc>.value(value: AppBloc()),
      ],
      child: MaterialApp(
        title: 'Vancutz',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Roboto",
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Color(PublicVar.primaryColor)),
          primaryColorLight: Color(PublicVar.primaryColor),
          primaryColor: Color(PublicVar.primaryColor),
          primaryColorDark: Color(PublicVar.primaryColor),
        ),
        // navigatorObservers: [observer],
        home: SplashScreen( ), //Base InfoGraph
      ),
    );
  }
}


