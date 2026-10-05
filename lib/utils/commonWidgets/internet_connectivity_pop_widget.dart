import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';

class InternetConnectivityPopWidget extends StatefulWidget {
  const InternetConnectivityPopWidget({super.key});

  static bool _isShowing = false;

  /// Shows the popup. Closes automatically when internet is back,
  /// or user can go back to the previous screen.
  static Future<void> show(BuildContext context) async {
    if (_isShowing) return;
    _isShowing = true;
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "NoInternet",
      barrierColor: Colors.black.withValues(alpha:0.6),
      transitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (_, __, ___) => const InternetConnectivityPopWidget(),
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
    _isShowing = false;
  }

  @override
  State<InternetConnectivityPopWidget> createState() =>
      _InternetConnectivityPopWidgetState();
}

class _InternetConnectivityPopWidgetState
    extends State<InternetConnectivityPopWidget>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _dotsController;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _isChecking = false;
  bool _isBackOnline = false;
  bool _retryFailed = false;
  bool _isClosing = false; // prevents double pop

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _subscription =
        Connectivity().onConnectivityChanged.listen((_) => _checkAndClose());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Future<void> _checkAndClose({bool fromRetry = false}) async {
    if (_isChecking || _isBackOnline || _isClosing) return;
    setState(() {
      _isChecking = true;
      _retryFailed = false;
    });

    final isOnline = await ConnectivityHelper.checkInterNetConnect();
    if (!mounted || _isClosing) return;

    if (isOnline) {
      setState(() {
        _isChecking = false;
        _isBackOnline = true;
      });
      // Show "Back Online" briefly, then close
      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted && !_isClosing) {
        _isClosing = true;
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _isChecking = false;
        _retryFailed = fromRetry;
      });
    }
  }

  /// Closes the popup AND goes back to the previous screen (works offline).
  void _goBack() {
    if (_isClosing) return;
    _isClosing = true;
    final navigator = Navigator.of(context);
    navigator.pop(); // close popup
    navigator.maybePop(); // go back to previous screen
  }

  Color get _accent => _isBackOnline ? Colors.green : AppColor.red;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final dialogWidth = size.width > 500 ? 380.0 : size.width * 0.85;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        // Android back button → close popup + go to previous screen
        if (!didPop && !_isBackOnline) _goBack();
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: dialogWidth,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _accent.withValues(alpha:0.18),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _header(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: _isBackOnline
                            ? _onlineContent(context)
                            : _offlineContent(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Header ----------
  Widget _header() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accent.withValues(alpha:0.18), _accent.withValues(alpha:0.04)],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -30,
            left: -20,
            child: _decorCircle(90, _accent.withValues(alpha:0.07)),
          ),
          Positioned(
            bottom: -40,
            right: -25,
            child: _decorCircle(120, _accent.withValues(alpha:0.05)),
          ),
          if (!_isBackOnline)
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_accent.withValues(alpha:0.8), _accent],
              ),
              boxShadow: [
                BoxShadow(
                  color: _accent.withValues(alpha:0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                _isBackOnline ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                key: ValueKey(_isBackOnline),
                color: Colors.white,
                size: 36,
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
          border: Border.all(color: _accent, width: 2),
        ),
      ),
    );
  }

  Widget _decorCircle(double d, Color color) => Container(
    height: d,
    width: d,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );

  // ---------- Offline content ----------
  Widget _offlineContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey("offline"),
      mainAxisSize: MainAxisSize.min,
      children: [
        _waitingChip(),
        const SizedBox(height: 14),
        TextWidget(
          "No Internet Connection",
          textAlign: TextAlign.center,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: AppFont.font_16,
        ),
        const SizedBox(height: 8),
        TextWidget(
          "This screen needs internet to work. It will close automatically once you're connected.",
          textAlign: TextAlign.center,
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
          fontSize: AppFont.font_12,
        ),
        const SizedBox(height: 18),
        _tipsBox(context),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: _retryFailed
              ? Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline_rounded,
                    size: 16, color: AppColor.red),
                const SizedBox(width: 6),
                TextWidget(
                  "Still offline. Please try again.",
                  color: AppColor.red,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFont.font_12,
                ),
              ],
            ),
          )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 20),
        _retryButton(context),
        const SizedBox(height: 10),
        _goBackButton(context),
      ],
    );
  }

  Widget _waitingChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.red.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.red.withValues(alpha:0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            "Waiting for connection",
            color: AppColor.red,
            fontWeight: FontWeight.w600,
            fontSize: AppFont.font_10,
          ),
          const SizedBox(width: 4),
          AnimatedBuilder(
            animation: _dotsController,
            builder: (_, __) => Row(
              children: List.generate(3, (i) {
                final t = (_dotsController.value - i * 0.2) % 1;
                final opacity = t < 0.5 ? t * 2 : (1 - t) * 2;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: Opacity(
                    opacity: opacity.clamp(0.2, 1.0),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipsBox(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha:0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.primary.withValues(alpha:0.16)),
      ),
      child: Column(
        children: [
          _tipRow(context, Icons.wifi_rounded, "Turn on Wi-Fi or mobile data"),
          const SizedBox(height: 10),
          _tipRow(context, Icons.airplanemode_inactive_rounded,
              "Make sure airplane mode is off"),
          const SizedBox(height: 10),
          _tipRow(context, Icons.router_outlined,
              "Move closer to your router or network"),
        ],
      ),
    );
  }

  Widget _tipRow(BuildContext context, IconData icon, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
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
          child: TextWidget(
            text,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontSize: AppFont.font_12,
          ),
        ),
      ],
    );
  }

  // ---------- Buttons ----------
  Widget _retryButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isChecking ? 0.75 : 1,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha:0.85),
              colorScheme.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha:0.35),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: _isChecking ? null : () => _checkAndClose(fromRetry: true),
            child: Center(
              child: _isChecking
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextWidget(
                    "Checking...",
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFont.font_14,
                  ),
                ],
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded,
                      color: colorScheme.onPrimary, size: 20),
                  const SizedBox(width: 8),
                  TextWidget(
                    "Retry",
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFont.font_14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _goBackButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.outline.withValues(alpha:0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _isChecking ? null : _goBack,
        icon: Icon(
          Icons.arrow_back_rounded,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
        label: TextWidget(
          "Go Back",
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          fontSize: AppFont.font_14,
        ),
      ),
    );
  }

  // ---------- Back online content ----------
  Widget _onlineContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey("online"),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha:0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.withValues(alpha:0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_rounded,
                  size: 14, color: Colors.green),
              const SizedBox(width: 6),
              TextWidget(
                "CONNECTED",
                color: Colors.green.shade700,
                fontWeight: FontWeight.w700,
                fontSize: AppFont.font_10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        TextWidget(
          "You're Back Online",
          textAlign: TextAlign.center,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: AppFont.font_16,
        ),
        const SizedBox(height: 8),
        TextWidget(
          "Connection restored. Continuing...",
          textAlign: TextAlign.center,
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
          fontSize: AppFont.font_12,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}