import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../presentation/screnns/settings_screen/providers/settings_provider.dart';
import 'add_results_provider.dart';
import 'navigation_provider.dart';
import 'text_data_provider.dart';

List<SingleChildWidget> providersApp = [
  ChangeNotifierProvider(create: (_) => AddResultsProvider()),
  ChangeNotifierProvider(create: (_) => TextDataProvider()),
  ChangeNotifierProvider(create: (_) => SettingsProvider()),
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
];
