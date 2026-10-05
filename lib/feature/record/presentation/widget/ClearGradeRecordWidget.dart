import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// CLEAR & GRADE RECORD WIDGET
// Sirf Clear & Grade ka offline data dikhata hai
// (Hive box: offline_clear_grade_box)
//
// Upload, Sync All, Delete, Delete All, Detail screen — sab andar se aata hai.
// =============================================================================

class ClearGradeRecordWidget extends StatelessWidget {
  const ClearGradeRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfflineRecordsWidget(
      activityName: OfflineActivity.clearGrade,
    );
  }
}