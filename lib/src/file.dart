part of umiuni2d_io_flutter;

class Directory extends umi.Directory {

  dio.FileSystemEntity fe;
  Directory(this.fe);

  String get name => dpath.basename(fe.path);

  String get path => fe.path;

  Future<bool> isDir() async{
    if(!await exists()) {
      return false;
    }
    if(fe is dio.Directory) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> isFile() async{
    if(!await exists()) {
      return false;
    }
    if(fe is dio.File) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> exists() async{
    return fe.exists();
  }
}

class File extends umi.File{
  dio.FileSystemEntity fe;
  dio.RandomAccessFile af;
  File(this.fe, this.af);

  //
  //
  String get name => dpath.basename(fe.path);

  String get path => fe.path;

  Future<bool> isDir() async{
    if(!await exists()) {
      return false;
    }
    if(fe is dio.Directory) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> isFile() async{
    if(!await exists()) {
      return false;
    }
    if(fe is dio.File) {
      return true;
    } else {
      return false;
    }
  }

  Future<File> open() async {
    af = await (fe as dio.File).open(mode: dio.FileMode.APPEND);
    return this;
  }
  Future<bool> exists() async{
    return fe.exists();
  }

  Future<File> close() async {
    if(af != null) {
      await af.close();
    }
    return this;
  }

  @override
  Future<int> writeAsBytes(List<int> buffer, int offset) async {
    if(this.af == null) {
      this.af = await (this.fe as dio.File).open(mode: dio.FileMode.APPEND);
    }
    await af.setPosition(offset);
    await af.writeFrom(buffer);
    return buffer.length;
  }

  @override
  Future<List<int>> readAsBytes(int offset, int length) async {
    await af.setPosition(offset);
    List<int> ret = await af.read(length);
    return ret;
  }

  @override
  Future<int> getLength() async {
    return af.length();
  }

  @override
  Future<int> truncate(int fileSize) async {
    int s = await getLength();
    if(fileSize >= s) {
      return s;
    }
    await af.truncate(fileSize);
    int ret = await getLength();
    return ret;
  }
}
