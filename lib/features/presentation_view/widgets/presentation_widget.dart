import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/widgets/presentation_widget_vm.dart';
import 'package:provider/provider.dart';

class PresentationWidget extends StatefulWidget {
  final PresentationEntity presentation;
  final Stream<void> refreshStream;

  const PresentationWidget(
    this.presentation, {
    required this.refreshStream,
    Key? key,
  }) : super(key: key);

  @override
  State<PresentationWidget> createState() => _PresentationWidgetState();
}

class _PresentationWidgetState extends State<PresentationWidget> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<PresentationWidgetVm>();
    vm.init(
      context,
      widget.presentation,
      widget.refreshStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PresentationWidgetVm>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
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
          ),
        ),
        const SizedBox(height: 16),
        Text(vm.presentation.name),
      ],
    );
  }
}
