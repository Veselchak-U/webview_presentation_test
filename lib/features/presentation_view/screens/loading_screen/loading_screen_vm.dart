import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/data/mocks.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/delete_presentation.dart';

class LoadingScreenVm extends ChangeNotifier {
  final DeletePresentation _deletePresentation;

  LoadingScreenVm({
    required DeletePresentation deletePresentation,
  }) : _deletePresentation = deletePresentation;

  Future<void> init(
    BuildContext context,
    VoidCallback refreshPresentationsStates,
  ) async {
    _context = context;
    _refreshPresentationsStates = refreshPresentationsStates;
    presentations = Mocks().presentationsMock;
  }

  /// Regular properties
  ///

  late final BuildContext _context;
  late final VoidCallback _refreshPresentationsStates;
  late final List<PresentationEntity> presentations;

  /// Reactive properties
  ///

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  /// Data methods
  ///

  Future<void> deleteAll() async {
    final userConfirm = await showDialog<bool>(
      context: _context,
      builder: (context) => AlertDialog(
        title: const Text('Подтверждение'),
        content: const Text('Удалить все загруженные файлы презентаций?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(_context).pop(false),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
            onPressed: () => Navigator.of(_context).pop(true),
            child: const Text('Удалить всё'),
          ),
        ],
      ),
    );
    if (userConfirm != true) {
      return;
    }
    loading = true;
    try {
      await _deletePresentation.deleteAll();
      _refreshPresentationsStates();
      _showToast('Удаление завершено');
    } catch (error) {
      _showToast('Ошибка удаления: $error');
    }
    loading = false;
  }

  /// Navigation methods
  ///

  void _showToast(String message) {
    debugPrint('!!! showToast() message: $message');
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
