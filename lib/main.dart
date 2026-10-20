import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_app_new/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/constants/constants_exp.dart';
import 'core/firebase/firebase_options.dart';
import 'data/hive/adapters.dart';
import 'domain/providers  /add_results_provider.dart';
import 'domain/providers  /providers.dart';
import 'presentation/screnns/help_screen/help.dart';
import 'presentation/screnns/home_screen/home_screen.dart';
import 'package:flutter/services.dart';
import 'presentation/widgets/navigation_bar_blur.dart';

Future<void> main() async {
  await Hive.initFlutter();
  DatabaseProvider().openCardHealthBox();
  Hive.registerAdapter(CardHealthAdapter());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providersApp, child: HomeApp());
  }
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationProvider helpData = context.watch<NavigationProvider>();
    return MaterialApp(
      title: 'Дневник давления',
      theme: ThemeData(fontFamily: "Manrope"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorBackgroundApp().bg,
        body: Stack(
          children: [
            (helpData.currenBotton1Index == 0)
                ? const HomeScreen()
                : const Help(),
            NavigationBarBlur(),
          ],
        ),
        //bottomNavigationBar: NavigationModel(),
      ),
    );
  }
}
