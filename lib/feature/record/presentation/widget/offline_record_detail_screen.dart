import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/record/data/model/offline_record_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

// =============================================================================
// OFFLINE RECORD DETAIL
// Ek record ka POORA data dikhata hai (body ki har field) + attachment.
// Neeche: Delete aur Upload button.
// =============================================================================

class OfflineRecordDetailScreen extends StatelessWidget {
  final dynamic recordKey;

  const OfflineRecordDetailScreen({super.key, required this.recordKey});

  /// Ye fields technical hain, user ko dikhane ki zaroorat nahi
  static const Set<String> _hiddenFields = {
    "schema",
    "spread_id",
    "section_id",
    "user_id",
  };

  @override
  Widget build(BuildContext context) {
    final theme = EnvironmentConfig.of(context)!.primaryTheme;
    final box = HiveDataBase.offlineRecordBox!;

    // Sirf ISI record ko suno (upload / delete / error update)
    return ValueListenableBuilder<Box<OfflineRecordModel>>(
      valueListenable: box.listenable(keys: [recordKey]),
      builder: (context, box, _) {
        final record = box.get(recordKey);

        // Record ab Hive me nahi (auto sync ne upload kar diya ya delete hua)
        if (record == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Record Detail")),
            body: const Center(
              child: TextWidget("This record is no longer pending"),
            ),
          );
        }

        final fields = (record.body ?? {})
            .entries
            .where((e) => !_hiddenFields.contains(e.key))
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(record.activityName ?? "Record Detail"),
            backgroundColor: theme,
            foregroundColor: AppColor.white,
          ),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _statusCard(context, record, theme),
              const SizedBox(height: 12),
              _sectionTitle("Details", theme),
              Card(
                child: Column(
                  children: [
                    for (int i = 0; i < fields.length; i++) ...[
                      _fieldRow(fields[i].key, fields[i].value),
                      if (i != fields.length - 1) const Divider(height: 1),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _sectionTitle("Attachment", theme),
              _attachment(record.filePath ?? ""),
              const SizedBox(height: 80), // neeche buttons ke liye jagah
            ],
          ),
          bottomNavigationBar: _bottomButtons(context, theme),
        );
      },
    );
  }



  // ---------------------------------------------------------------------------
  // SECTION TITLE: "Details", "Attachment"
  // ---------------------------------------------------------------------------
  Widget _sectionTitle(String title, Color theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: TextWidget(
        title,
        fontWeight: FontWeight.w700,
        color: theme,
      ),
    );
  }
  // ---------------------------------------------------------------------------
  // STATUS CARD: Pending / Error + kab save hua
  // ---------------------------------------------------------------------------
  Widget _statusCard(
      BuildContext context, OfflineRecordModel record, Color theme) {
    final hasError = (record.lastError ?? "").isNotEmpty;
    final savedAt = record.createdAt == null
        ? "-"
        : DateFormat('dd-MM-yyyy hh:mm a').format(
        DateTime.fromMillisecondsSinceEpoch(record.createdAt!));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  hasError ? Icons.error_outline : Icons.schedule,
                  color: hasError ? AppColor.red : theme,
                  size: 20,
                ),
                const SizedBox(width: 6),
                TextWidget(
                  hasError ? "Rejected by server" : "Pending upload",
                  fontWeight: FontWeight.w700,
                  color: hasError ? AppColor.red : theme,
                ),
              ],
            ),
            const SizedBox(height: 6),
            TextWidget(
              "Saved offline: $savedAt",
              color: AppColor.black,
              fontSize: AppFont.font_12,
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: TextWidget(
                  "Error: ${record.lastError}",
                  color: AppColor.red,
                  fontSize: AppFont.font_12,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // EK FIELD KI ROW: "Chainage From"   |   "10"
  // ---------------------------------------------------------------------------
  Widget _fieldRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextWidget(
              _label(key),
              color: AppColor.black,
              fontSize: AppFont.font_12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextWidget(
              value.isEmpty ? "-" : value,
              color: AppColor.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ATTACHMENT: photo ho to dikhao, warna file ka naam
  // ---------------------------------------------------------------------------
  Widget _attachment(String path) {
    if (path.isEmpty || !File(path).existsSync()) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: TextWidget("No attachment"),
        ),
      );
    }

    final lower = path.toLowerCase();
    final isImage = lower.endsWith(".jpg") ||
        lower.endsWith(".jpeg") ||
        lower.endsWith(".png");

    if (isImage) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Image.file(File(path), height: 220, fit: BoxFit.cover),
      );
    }

    return Card(
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file_outlined),
        title: TextWidget(path.split('/').last),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // NEECHE BUTTONS: Delete | Upload
  // ---------------------------------------------------------------------------
  Widget _bottomButtons(BuildContext context, Color theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<bool>(
          valueListenable: RecordHelper.isSyncingNotifier,
          builder: (context, syncing, _) {
            return Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: syncing ? null : () => _delete(context),
                    icon: Icon(Icons.delete_outline, color: AppColor.red),
                    label: Text("Delete",
                        style: TextStyle(color: AppColor.red)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: syncing ? null : () => _upload(context),
                    icon: syncing
                        ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                        : const Icon(Icons.cloud_upload_outlined),
                    label: Text(syncing ? "Uploading..." : "Upload"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme,
                      foregroundColor: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ACTIONS
  // ---------------------------------------------------------------------------
  Future<void> _upload(BuildContext context) async {
    if (!await ConnectivityHelper.checkInterNetConnect()) {
      if (context.mounted) {
        SnackBarErrorWidget(context).show(message: "No internet connection");
      }
      return;
    }

    UploadSummary summary =
    await RecordHelper.uploadRecords(keys: [recordKey]);
    if (!context.mounted) return;

    if (summary.uploaded > 0) {
      SnackBarSuccessWidget(context).show(message: "Record uploaded");
      Navigator.pop(context); // wapas list par
    } else {
      SnackBarErrorWidget(context)
          .show(message: summary.error ?? "Upload failed");
    }
  }

  Future<void> _delete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Delete Record"),
        content: const Text(
            "This offline record will be permanently deleted. Continue?"),
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
    if (ok != true) return;

    await RecordHelper.deleteRecord(recordKey);
    if (context.mounted) {
      SnackBarSuccessWidget(context).show(message: "Record deleted");
      Navigator.pop(context);
    }
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  /// "chainage_from" -> "Chainage From"
  static String _label(String key) {
    return key
        .split('_')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}