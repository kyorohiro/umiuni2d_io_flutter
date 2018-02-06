library umiuni2d_io_flutter;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
//import 'package: as io;
import 'package:umiuni2d_io/umiuni2d_io.dart' as umi;
import 'package:umiuni2d_io_flutter/umiuni2d_io.dart' as path;
import 'dart:io'as dio;
import 'package:path/path.dart' as dpath;
part 'src/file.dart';
part 'src/fileSystem.dart';

class Umiuni2dPlatformPath {
  MethodChannel _channel;

  Umiuni2dPlatformPath() {
    _channel = const MethodChannel('umiuni2d_platform_path');
  }

  Future<String> getCacheDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getCacheDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }

  Future<String> getApplicationDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getApplicationDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }

  Future<String> getDocumentDirectory({String defaultPath:"/"}) async {
    String path = await _channel.invokeMethod("getDocumentDirectory");
    if(path == null) {
      return defaultPath;
    } else {
      return path;
    }
  }


}