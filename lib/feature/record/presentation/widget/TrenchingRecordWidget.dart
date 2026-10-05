import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// TRENCHING RECORD WIDGET
// Sirf Trenching ka offline data dikhata hai
// (Hive box: offline_trenching_box)
//
// Upload, Sync All, Delete, Delete All, Detail screen — sab andar se aata hai.
// =============================================================================

class TrenchingRecordWidget extends StatelessWidget {
  const TrenchingRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfflineRecordsWidget(
      activityName: OfflineActivity.trenching,
    );
  }
}