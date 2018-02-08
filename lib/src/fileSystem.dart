part of umiuni2d_io_flutter;

class FileSystem extends dartio.FileSystem {
  path.Umiuni2dPlatformPath _path = new path.Umiuni2dPlatformPath();

  umi.Entry _currentDirectory = null;
  FileSystem() {}

  @override
  Future<umi.Directory> getHomeDirectory() async {
    String path = await _path.getApplicationDirectory() + "/";
    return new dartio.Directory(new dio.Directory(path));
  }

}