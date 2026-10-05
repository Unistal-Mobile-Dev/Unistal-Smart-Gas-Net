import 'package:flutter/widgets.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';


class OfflineAutoSync {

  static bool _started = false;
  static StreamSubscription? _subscription;
  static Timer? _debounce;
  static final _AppResumeObserver _observer = _AppResumeObserver();

  static void start() {
    if (_started) return;
    _started = true;
    _subscription = Connectivity().onConnectivityChanged.listen((dynamic result) {
      if (_isConnected(result)) {
        _scheduleSync();
      }
    });
    WidgetsBinding.instance.addObserver(_observer);
    debugPrint("🟢 OfflineAutoSync started");
  }

  static void stop() {
    _subscription?.cancel();
    _subscription = null;
    _debounce?.cancel();
    WidgetsBinding.instance.removeObserver(_observer);
    _started = false;
    debugPrint("🔴 OfflineAutoSync stopped");
  }

  static Future<void> syncNow() async {

    final box = HiveDataBase.offlineRecordBox;
    if (box == null || !box.isOpen || box.isEmpty) return;
    if (!await ConnectivityHelper.checkInterNetConnect()) {
      debugPrint("📴 Sync skipped: no internet (pending: ${box.length})");
      return;
    }

    debugPrint("🔄 Sync start, pending: ${box.length}");
    UploadSummary summary = await RecordHelper.uploadRecords(keys: box.keys.toList());
    debugPrint("🔄 Sync end: ${summary.uploaded} uploaded, error: ${summary.error}, pending: ${box.length}");
  }

  static void _scheduleSync() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 3), syncNow);
  }

  static bool _isConnected(dynamic result) {
    if (result is List) {
      return result.isNotEmpty && !result.contains(ConnectivityResult.none);
    }
    return result != ConnectivityResult.none;
  }
}

class _AppResumeObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      OfflineAutoSync._scheduleSync();
    }
  }
}