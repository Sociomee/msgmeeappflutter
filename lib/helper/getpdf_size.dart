import 'dart:io';

String getFileSize(File file) {
  int bytes = file.lengthSync();

  if (bytes <= 0) {
    return '0 KB';
  }

  const int KB = 1024;
  const int MB = 1024 * KB;

  if (bytes >= MB) {
    double size = bytes / MB;
    return '${size.toStringAsFixed(2)} MB';
  } else if (bytes >= KB) {
    double size = bytes / KB;
    return '${size.toStringAsFixed(2)} KB';
  } else {
    return '$bytes bytes';
  }
}