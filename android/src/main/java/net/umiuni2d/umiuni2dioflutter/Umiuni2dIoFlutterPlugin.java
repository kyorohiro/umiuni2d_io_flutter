package net.umiuni2d.umiuni2dioflutter;

import android.os.Environment;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * Umiuni2dIoFlutterPlugin
 */
public class Umiuni2dIoFlutterPlugin implements MethodCallHandler {
  private final Registrar mRegistrar;

  Umiuni2dIoFlutterPlugin(Registrar registrar){
    mRegistrar = registrar;
  }
  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "umiuni2d_platform_path");
    channel.setMethodCallHandler(new Umiuni2dIoFlutterPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getApplicationDirectory")) {
      result.success(mRegistrar.context().getFilesDir().getPath());
    } else if (call.method.equals("getCacheDirectory")) {
      result.success(mRegistrar.context().getCacheDir().getPath());
    } else if (call.method.equals("getDocumentDirectory")) {
      result.success(Environment.getExternalStorageDirectory().getAbsolutePath());
    } else {
      result.notImplemented();
    }
  }
}
