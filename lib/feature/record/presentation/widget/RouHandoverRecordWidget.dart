import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// ROU HANDOVER RECORD WIDGET
// Sirf ROU Handover ka offline data dikhata hai
// (Hive box: offline_rou_handover_box)
//
// Upload, Sync All, Delete, Delete All, Detail screen — sab andar se aata hai.
// =============================================================================

class RouHandoverRecordWidget extends StatelessWidget {
  const RouHandoverRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfflineRecordsWidget(
      activityName: OfflineActivity.rouHandover,
    );
  }
}