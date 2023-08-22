import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

// const _presentation = PresentationEntity(
//   id: 'id_Calquence_RU_3_2022_Publish',
//   url:
//   'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1_33cRbPzWpT-hUrcF-Z0wvqyUZtD93Iv',
//   fileName: 'Calquence_RU_3_2022_Publish.zip',
//   name: 'Calquence_RU_3_2022_Publish',
// );

// const _presentation = PresentationEntity(
//   id: 'id_Synagis_RIA_GI_2023_1',
//   url:
//       'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1UYsDW9FvR4JOaXn8SLp9bYOdLfNlQFsr',
//   fileName: 'Synagis_RIA_GI_2023_1.zip',
//   name: 'Synagis_RIA_GI_2023_1',
// );

const _presentation = PresentationEntity(
  id: 'id_Pulmocort_spec_2023_hobl',
  url:
      'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1lKK-WiWvYhowvTtEOkTa3CDHqiViAOpc',
  fileName: 'Pulmocort_spec_2023_hobl.zip',
  name: 'Pulmocort_spec_2023_hobl',
);

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
    vm.init(_presentation);
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
