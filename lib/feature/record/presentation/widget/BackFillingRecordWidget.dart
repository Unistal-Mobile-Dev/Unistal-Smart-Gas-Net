import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// BACK FILLING RECORD WIDGET
// Sirf Back Filling ka offline data dikhata hai
// (Hive box: offline_back_filling_box)
//
// Upload, Sync All, Delete, Delete All, Detail screen — sab andar se aata hai.
// =============================================================================

class BackFillingRecordWidget extends StatelessWidget {
  const BackFillingRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfflineRecordsWidget(
      activityName: OfflineActivity.backFilling,
    );
  }
}