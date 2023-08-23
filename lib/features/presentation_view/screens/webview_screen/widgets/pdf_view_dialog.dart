import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewDialog extends StatefulWidget {
  final String filePath;

  const PdfViewDialog(
    this.filePath, {
    super.key,
  });

  @override
  State<PdfViewDialog> createState() => _PdfViewDialogState();
}

class _PdfViewDialogState extends State<PdfViewDialog> {
  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PDFView(
          filePath: widget.filePath,
          onError: (error) {
            debugPrint('!!! PdfViewDialog.onError: $error');
          },
          onPageError: (page, error) {
            debugPrint('!!! PdfViewDialog.onPageError: page = $page, $error');
          },
          onPageChanged: (page, total) {
            debugPrint('!!! PdfViewDialog.onPageChanged: $page / $total');
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 24,
          padding: const EdgeInsets.all(24),
          onPressed: _closeDialog,
        ),
      ],
    );
  }
}
