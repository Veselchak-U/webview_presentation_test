import 'dart:async';

import 'package:flutter/material.dart';
import 'package:presentation_test/core/di/dependency_injection.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:presentation_test/features/presentation_view/widgets/presentation_widget.dart';
import 'package:presentation_test/features/presentation_view/widgets/presentation_widget_vm.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _refreshController = StreamController<void>.broadcast();

  @override
  void initState() {
    super.initState();
    final vm = context.read<LoadingScreenVm>();
    vm.init(
      context,
      _refreshPresentationsStates,
    );
  }

  @override
  void dispose() {
    _refreshController.close();
    super.dispose();
  }

  void _refreshPresentationsStates() {
    _refreshController.add(null);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoadingScreenVm>();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final columnCount = screenWidth ~/ 250;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Тестирование презентаций'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: columnCount,
          padding: const EdgeInsets.all(24),
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 234 / 223,
          children: List.generate(
            vm.presentations.length,
            (index) {
              return ChangeNotifierProvider<PresentationWidgetVm>(
                create: (context) => sl<PresentationWidgetVm>(),
                child: PresentationWidget(
                  vm.presentations[index],
                  refreshStream: _refreshController.stream,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: vm.deleteAll,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
