import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/data/model/offline_record_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

import 'widget/offline_record_detail_screen.dart';
class OfflineActivity {
  static const String routeSurvey = "Route Survey";
  static const String rouHandover = "ROU Handover";
  static const String clearGrade = "Clear & Grade";
  static const String trenching = "Trenching";
  static const String backFilling = "Back Filling";
}


class OfflineRecordsWidget extends StatefulWidget {
  /// null = saari activities (filter chips ke saath)
  /// "Trenching" = sirf Trenching ke records (filter chips nahi)
  final String? activityName;

  const OfflineRecordsWidget({super.key, this.activityName});

  @override
  State<OfflineRecordsWidget> createState() => _OfflineRecordsWidgetState();
}

class _OfflineRecordsWidgetState extends State<OfflineRecordsWidget> {
  /// Kaunsi activity dikhani hai ("All" = sab)
  String _filter = "All";

  Color get _theme => EnvironmentConfig.of(context)!.primaryTheme;

  @override
  Widget build(BuildContext context) {
    final box = HiveDataBase.offlineRecordBox;
    if (box == null || !box.isOpen) {
      return const Scaffold(
        body: Center(child: TextWidget("Local database not available")),
      );
    }

    return Scaffold(
      // Box ko sunta hai -> upload / delete hote hi list khud update
      body: ValueListenableBuilder<Box<OfflineRecordModel>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          // Saari keys, naya record sabse upar
          final allKeys = box.keys.toList().reversed.toList();

          // Filter chips ke liye activity naam
          final activities = <String>{
            "All",
            ...allKeys
                .map((k) => box.get(k)?.activityName ?? "")
                .where((name) => name.isNotEmpty),
          }.toList();

          // Activity fix hai (alag list) -> wahi filter, warna chip wala
          final bool isSingleActivity = widget.activityName != null;
          final filter = isSingleActivity
              ? widget.activityName!
              : (activities.contains(_filter) ? _filter : "All");

          // Filter ke hisaab se keys
          final keys = filter == "All"
              ? allKeys
              : allKeys
              .where((k) => box.get(k)?.activityName == filter)
              .toList();

          return Column(
            children: [
              _header(keys),
              // Alag list me chips nahi, sab activities wali list me hi
              if (!isSingleActivity && activities.length > 2)
                _filterChips(activities, filter),
              Expanded(child: _list(box, keys)),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER: count + Sync All + Delete All
  // ---------------------------------------------------------------------------
  Widget _header(List keys) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: [
          Expanded(
            child: TextWidget(
              "Pending Records: ${keys.length}",
              fontWeight: FontWeight.w700,
              color: _theme,
            ),
          ),
          if (keys.isNotEmpty)
            ValueListenableBuilder<bool>(
              valueListenable: RecordHelper.isSyncingNotifier,
              builder: (context, syncing, _) {
                if (syncing) {
                  return const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }
                return Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => _upload(keys),
                      icon: Icon(Icons.cloud_upload_outlined, color: _theme),
                      label: TextWidget("Sync All", color: _theme),
                    ),
                    IconButton(
                      tooltip: "Delete All",
                      onPressed: () => _deleteAll(keys),
                      icon: Icon(Icons.delete_sweep_outlined,
                          color: AppColor.red),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FILTER CHIPS: All | Route Survey | Trenching ...
  // ---------------------------------------------------------------------------
  Widget _filterChips(List<String> activities, String selected) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        scrollDirection: Axis.horizontal,
        itemCount: activities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final name = activities[index];
          final isSelected = name == selected;
          return ChoiceChip(
            label: Text(name),
            selected: isSelected,
            selectedColor: _theme.withOpacity(0.15),
            labelStyle: TextStyle(
              color: isSelected ? _theme : AppColor.black,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
            onSelected: (_) => setState(() => _filter = name),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LIST
  // ---------------------------------------------------------------------------
  Widget _list(Box<OfflineRecordModel> box, List keys) {
    if (keys.isEmpty) {
      final name = widget.activityName;
      return Center(
        child: TextWidget(
          name == null ? "No Pending Record Found" : "No $name Record Found",
        ),
      );
    }

    // Kaunsa record upload ho raha hai -> us row par loader
    return ValueListenableBuilder<dynamic>(
      valueListenable: RecordHelper.uploadingKeyNotifier,
      builder: (context, uploadingKey, _) {
        final syncing = RecordHelper.isUploading;

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final key = keys[index];
            final record = box.get(key);
            if (record == null) return const SizedBox();

            final isThisUploading = uploadingKey == key;

            return Card(
              child: SlideMenuWidget(
                menuItems: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.20,
                    width: MediaQuery.of(context).size.width * 0.30,
                    color: AppColor.red,
                    child: IconButton(
                      onPressed: syncing ? null : () => _deleteOne(key),
                      icon: Icon(Icons.delete_forever_outlined,
                          color: AppColor.white),
                    ),
                  ),
                ],
                child: InkWell(
                  onTap: () => _openDetail(key),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _recordInfo(record)),
                        isThisUploading
                            ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2),
                          ),
                        )
                            : IconButton(
                          onPressed:
                          syncing ? null : () => _upload([key]),
                          icon: Icon(Icons.upload_outlined,
                              color: _theme),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // EK RECORD KI CHHOTI JAANKARI (list row)
  // ---------------------------------------------------------------------------
  Widget _recordInfo(OfflineRecordModel r) {
    final body = r.body ?? {};
    final hasFile = (r.filePath ?? "").isNotEmpty;
    final hasError = (r.lastError ?? "").isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Activity badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: _theme.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextWidget(
            _v(r.activityName),
            color: _theme,
            fontSize: AppFont.font_12,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextWidget(
          _v(r.activityDate),
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        TextWidget(
          "Report No: ${_v(r.reportNo)}",
          color: AppColor.black,
          fontSize: AppFont.font_12,
        ),
        TextWidget(
          "Chainage: ${_v(body["chainage_from"])} - ${_v(body["chainage_to"])}",
          color: AppColor.black,
          fontSize: AppFont.font_12,
        ),
        if (hasFile)
          Row(
            children: [
              Icon(Icons.attach_file, size: 14, color: AppColor.black),
              TextWidget(
                "Attachment",
                color: AppColor.black,
                fontSize: AppFont.font_12,
              ),
            ],
          ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextWidget(
              "Error: ${r.lastError}",
              color: AppColor.red,
              fontSize: AppFont.font_12,
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ACTIONS
  // ---------------------------------------------------------------------------

  /// Detail screen kholo
  void _openDetail(dynamic key) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OfflineRecordDetailScreen(recordKey: key),
      ),
    );
  }

  /// Ek ya saare records upload
  Future<void> _upload(List keys) async {
    if (RecordHelper.isUploading) {
      SnackBarErrorWidget(context).show(message: "Upload already running");
      return;
    }

    if (!await ConnectivityHelper.checkInterNetConnect()) {
      if (mounted) {
        SnackBarErrorWidget(context).show(message: "No internet connection");
      }
      return;
    }

    UploadSummary summary = await RecordHelper.uploadRecords(keys: keys);
    if (!mounted) return;

    if (summary.error == null) {
      SnackBarSuccessWidget(context)
          .show(message: "${summary.uploaded} record(s) uploaded");
    } else {
      SnackBarErrorWidget(context).show(
        message: summary.uploaded > 0
            ? "${summary.uploaded} uploaded. Error: ${summary.error}"
            : summary.error!,
      );
    }
  }

  /// Ek record delete
  Future<void> _deleteOne(dynamic key) async {
    final ok = await _confirm(
      "Delete Record",
      "This offline record will be permanently deleted. Continue?",
    );
    if (!ok) return;

    await RecordHelper.deleteRecord(key);
    if (mounted) {
      SnackBarSuccessWidget(context).show(message: "Record deleted");
    }
  }

  /// Saare (filter wale) records delete
  Future<void> _deleteAll(List keys) async {
    final ok = await _confirm(
      "Delete All",
      "${keys.length} offline record(s) will be permanently deleted. "
          "This data will NOT reach the server. Continue?",
    );
    if (!ok) return;

    await RecordHelper.deleteRecords(keys);
    if (mounted) {
      SnackBarSuccessWidget(context)
          .show(message: "${keys.length} record(s) deleted");
    }
  }

  /// Haan / Na dialog
  Future<bool> _confirm(String title, String message) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text("Delete", style: TextStyle(color: AppColor.red)),
          ),
        ],
      ),
    );
    return ok == true;
  }

  String _v(String? value) =>
      (value == null || value.isEmpty || value == "null") ? "-" : value;
}