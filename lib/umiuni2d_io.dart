library umiuni2d_io_flutter;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
//import 'package: as io;
import 'package:umiuni2d_io/umiuni2d_io.dart' as umi;

import 'dart:io'as dio;
import 'package:umiuni2d_platform_path/umiuni2d_platform_path.dart' as path;
import 'package:path/path.dart' as dpath;
part 'src/file.dart';
part 'src/fileSystem.dart';

class Umiuni2dIoFlutter {
  static const MethodChannel _channel = const MethodChannel('umiuni2d_io_flutter');

  static Future<String> get platformVersion => _channel.invokeMethod('getPlatformVersion');
}