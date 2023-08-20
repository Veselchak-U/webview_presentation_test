import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 100,
  ),
);

// final log = Logger(
//   filter: _MyFilter(),
//   printer: SimplePrinter(
//     printTime: true,
//     colors: false,
//   ),
//   output: logOutput,
// );
//
// class _MyFilter extends LogFilter {
//   @override
//   bool shouldLog(LogEvent event) {
//     return true;
//   }
// }
