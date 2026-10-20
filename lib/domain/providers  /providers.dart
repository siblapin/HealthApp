import 'package:health_app_new/data/data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../presentation/screnns/settings_screen/providers/settings_provider.dart';
import 'add_results_provider.dart';
import 'board_home_provider.dart';
import 'text_data_provider.dart';

List <SingleChildWidget> providersApp =[  ChangeNotifierProvider(create: (context) => AddResultsProvider()),
        ChangeNotifierProvider(create: (context) => TextDataProvider()),
        ChangeNotifierProvider(create: (context) => BoardHomeProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
         ChangeNotifierProvider(create: (context) => NavigationProvider())];