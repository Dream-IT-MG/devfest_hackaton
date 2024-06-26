import 'package:devfest_hackaton/viewmodels/google_map_viewmodels.dart';
import 'package:devfest_hackaton/viewmodels/historique_viewmodels.dart';
import 'package:devfest_hackaton/viewmodels/search_viewmodels.dart';
import 'package:devfest_hackaton/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => SearchViewModels()),
        ChangeNotifierProvider(create: (context) => HistoriqueViewModels()),
        ChangeNotifierProvider(create: (context) => GoogleMapViewModels()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const OnBoardingView(),
      ),
    );
  }
}
