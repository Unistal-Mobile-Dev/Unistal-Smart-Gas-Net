import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class OfflineConnectivityPopWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final String buttonText;
  final VoidCallback? onContinue;

  const OfflineConnectivityPopWidget({
    super.key,
    this.title = "You're Offline",
    this.subTitle =
    "No internet connection found. You can still fill this form offline.",
    this.buttonText = "Continue Offline",
    this.onContinue,
  });

  /// Shows the popup with a smooth scale + fade animation.
  static Future<void> show(BuildContext context, {VoidCallback? onContinue}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Offline",
      barrierColor: Colors.black.withValues(alpha:0.55),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) =>
          OfflineConnectivityPopWidget(onContinue: onContinue),
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        );
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: curved, child: child),
        );
      },
    );
  }

  @override
  State<OfflineConnectivityPopWidget> createState() =>
      _OfflineConnectivityPopWidgetState();
}

class _OfflineConnectivityPopWidgetState
    extends State<OfflineConnectivityPopWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _close() {
    Navigator.pop(context);
    widget.onContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final dialogWidth = size.width > 500 ? 380.0 : size.width * 0.85;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dialogWidth,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.18),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _statusChip(),
                      const SizedBox(height: 14),
                      _title(context),
                      const SizedBox(height: 8),
                      _subTitle(context),
                      const SizedBox(height: 18),
                      _infoBox(context),
                      const SizedBox(height: 22),
                      _continueButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Header with gradient + pulsing icon ----------
  Widget _header(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.red.withValues(alpha:0.16),
            AppColor.red.withValues(alpha:0.04),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            left: -20,
            child: _decorCircle(90, AppColor.red.withValues(alpha:0.06)),
          ),
          Positioned(
            bottom: -40,
            right: -25,
            child: _decorCircle(120, AppColor.red.withValues(alpha:0.05)),
          ),

          // Pulsing rings
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: [
                _pulseRing(_pulseController.value),
                _pulseRing((_pulseController.value + 0.5) % 1),
              ],
            ),
          ),

          // Icon badge
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.red.withValues(alpha:0.85), AppColor.red],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.red.withValues(alpha:0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),

          // Close button
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.white.withValues(alpha:0.7),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _close,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pulseRing(double t) {
    final ringSize = 72 + (60 * t);
    return Opacity(
      opacity: (1 - t).clamp(0.0, 1.0) * 0.5,
      child: Container(
        height: ringSize,
        width: ringSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.red, width: 2),
        ),
      ),
    );
  }

  Widget _decorCircle(double d, Color color) {
    return Container(
      height: d,
      width: d,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  // ---------- Status chip ----------
  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha:0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withValues(alpha:0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          TextWidget(
            "OFFLINE MODE",
            color: Colors.orange.shade800,
            fontWeight: FontWeight.w700,
            fontSize: AppFont.font_10,
          ),
        ],
      ),
    );
  }

  // ---------- Texts ----------
  Widget _title(BuildContext context) {
    return TextWidget(
      widget.title,
      textAlign: TextAlign.center,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: AppFont.font_16,
    );
  }

  Widget _subTitle(BuildContext context) {
    return TextWidget(
      widget.subTitle,
      textAlign: TextAlign.center,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w400,
      fontSize: AppFont.font_12,
    );
  }

  // ---------- Info box ----------
  Widget _infoBox(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha:0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.primary.withValues(alpha:0.18)),
      ),
      child: Column(
        children: [
          _infoRow(
            context,
            icon: Icons.save_outlined,
            text: "Your data will be saved on this device",
          ),
          const SizedBox(height: 10),
          _infoRow(
            context,
            icon: Icons.cloud_sync_outlined,
            text: "It will sync automatically when you're back online",
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context,
      {required IconData icon, required String text}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha:0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: colorScheme.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextWidget(
              text,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: AppFont.font_12,
            ),
          ),
        ),
      ],
    );
  }

  // ---------- Continue button ----------
  Widget _continueButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [colorScheme.primary.withValues(alpha:0.85), colorScheme.primary],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: _close,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                widget.buttonText,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: AppFont.font_14,
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded,
                  color: colorScheme.onPrimary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}