import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app_new/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/constants/constants_exp.dart';
import 'core/firebase/firebase_options.dart';
import 'data/hive/adapters.dart';
import 'domain/providers/navigation_provider.dart';
import 'domain/providers/providers.dart';
import 'presentation/screnns/help_screen/help.dart';
import 'presentation/screnns/home_screen/home_screen.dart';
import 'presentation/widgets/navigation_bar_blur.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CardHealthAdapter());
  final db = DatabaseProvider();
  await db.openCardHealthBox();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: db),
        ...providersApp,
      ],
      child: const HomeApp(),
    ),
  );
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = context.select(
      (NavigationProvider nav) => nav.selectedIndex,
    );
    return MaterialApp(
      title: 'Дневник давления',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorBackgroundApp.bg,
        body: Stack(
          children: [
            tabIndex == 0 ? const HomeScreen() : const Help(),
            const NavigationBarBlur(),
          ],
        ),
      ),
    );
  }
}
