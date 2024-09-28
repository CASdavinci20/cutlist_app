import 'package:cutlist/login/createaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main_utils/bloc/app_bloc.dart';
import 'main_utils/models/PublicVar.dart';

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
        home: MyHomePage(
          title: "Vancutz",
        ), //Base InfoGraph
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEf9f9f9),
        body: SizedBox(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: 250,
                  child: Image.asset(
                    "assets/woodworker.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text(
                    'Elevate your craftsmanship ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE0f2851),
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 400,
                  height: 30,
                  child: Text(
                    'Perfect cut lists at your fingertips',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE0f2851),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccountPage()),
                      );
                    },
                    child: Image.asset(
                      'assets/buttonnext.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
