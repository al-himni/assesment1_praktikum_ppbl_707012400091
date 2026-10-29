import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_routes.dart';
import 'state/prediksi_model.dart';
import 'state/theme_model.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PrediksiModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: const AgriclimaApp(),
    ),
  );
}

class AgriclimaApp extends StatelessWidget {
  const AgriclimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return MaterialApp(
          title: 'AgriClima LSTM',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeModel.themeMode,
          initialRoute: AppRoutes.beranda,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
