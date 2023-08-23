import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/data/mocks.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<LoadingScreenVm>();
    vm.init(
      Mocks().presentationsMock[3],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoadingScreenVm>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Тестирование презентаций'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(vm.presentation.name),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: vm.loading ? null : vm.nextStep,
                      child: Text(vm.nextStepLabel),
                    ),
                    if (vm.isError)
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: OutlinedButton(
                          onPressed: vm.showError,
                          child: const Text('Показать ошибку'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 60),
                OutlinedButton(
                  onPressed: vm.loading ? null : vm.deleteAll,
                  child: const Text('Удалить загрузки'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
