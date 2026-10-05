import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// ROUTE SURVEY RECORD WIDGET
// Sirf Route Survey ka offline data dikhata hai
// (Hive box: offline_route_survey_box)
//
// Upload, Sync All, Delete, Delete All, Detail screen — sab andar se aata hai.
// =============================================================================

class RouteSurveyRecordWidget extends StatelessWidget {
  const RouteSurveyRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OfflineRecordsWidget(
      activityName: OfflineActivity.routeSurvey,
    );
  }
}