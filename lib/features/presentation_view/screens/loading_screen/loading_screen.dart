import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/bloc/presentation_bloc.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  PresentationEntity _presentation = const PresentationEntity(
      id: 'id_Calquence_RU_3_2022_Publish',
      url:
          'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1_33cRbPzWpT-hUrcF-Z0wvqyUZtD93Iv',
      fileName: 'Calquence_RU_3_2022_Publish',
      name: 'Название презентации');

  void _updatePresentation(PresentationEntity value) {
    setState(() {
      _presentation = value;
    });
  }

  bool _loading = false;

  void _updateLoading(PresentationState state) {
    final value = state.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (_loading != value) {
      setState(() {
        _loading = value;
      });
    }
  }

  String get nextStepLabel {
    if (loading && progressLabel.isNotEmpty) {
      return progressLabel;
    }
    switch (status) {
      case LoadingStatus.notLoaded:
        return 'Скачать презентацию';
      case LoadingStatus.loaded:
        return 'Распаковать презентацию';
      case LoadingStatus.unpacked:
        return 'Найти index.html';
      case LoadingStatus.ready:
        return 'Открыть презентацию';
    }
  }

  void _showToast(String message) {
    debugPrint('!!! showToast() message: $message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final vm = context.watch<LoadingScreenVm>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Тестирование презентаций'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocListener<PresentationBloc, PresentationState>(
              listener: (context, state) {
                _updateLoading(state);
                state.maybeWhen(
                  updated: (value) => _updatePresentation(value),
                  failure: (message) => _showToast(message),
                  orElse: () {},
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Презентация: ${_presentation.name}'),
                  const SizedBox(height: 16),
                  Text('URL: ${_presentation.url}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: _loading ? null : vm.nextStep,
                        child: Text(vm.nextStepLabel),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: null, // vm.cancelDownloading,
                        child: const Text('Остановить загрузку'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const OutlinedButton(
                    onPressed: null, // _loading ? null : vm.deleteAll,
                    child: Text('Удалить загрузки'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
