import 'package:flutter/material.dart';
import 'package:presentation_test/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoadingScreenVm>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Presentation test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Презентация: ${vm.presentationName}'),
            Text('URL: ${vm.presentationUrl}'),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: vm.loading ? null : vm.nextStep,
              child: Text(vm.nextStepLabel),
            ),
            const SizedBox(height: 60),
            OutlinedButton(
              onPressed: vm.loading ? null : vm.deleteAll,
              child: const Text('Удалить загрузки'),
            ),
          ],
        ),
      ),
    );
  }
}
