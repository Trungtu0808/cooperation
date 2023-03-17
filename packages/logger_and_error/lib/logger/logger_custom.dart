import 'package:logger/logger.dart';
import 'package:logger_and_error/logger/pretty_printer_custom.dart';

var logger = LoggerCustom(logEnable: true);

class LoggerCustom extends Logger {
  LoggerCustom({bool logEnable = true})
      : super(
          filter: LogFilterCustom(
            logEnable: logEnable,
          ),
          printer: PrettyPrinterCustom(
            methodCount: 2,
            errorMethodCount: 2,
            lineLength: 2,

            colors: false, // Colorful log messages

            printEmojis: true, // Print an emoji for each log message

            printTime: false, // Should each log print contain a timestamp
          ),
        );
}

class LogFilterCustom extends LogFilter {
  final bool logEnable;
  LogFilterCustom({this.logEnable = true});

  @override
  bool shouldLog(LogEvent event) {
    return logEnable;
  }
}
