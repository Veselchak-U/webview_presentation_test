import 'package:flutter/material.dart';
import 'package:presentation_test/loading_screen/loading_screen.dart';
import 'package:presentation_test/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentation test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<LoadingScreenVm>(
        create: (context) => LoadingScreenVm(context),
        child: const LoadingScreen(),
      ),
    );
  }
}
