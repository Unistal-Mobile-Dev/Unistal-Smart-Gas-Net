import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/bloc/home_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/drawer_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/logout_widget.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/Background/background_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_bar_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class HomeDrawerWidget extends StatelessWidget {
  HomeDrawerWidget({super.key});

  final LoginDataModel _userData = UserInfo.instance!.userData!;

  LoginDataModel get userData => _userData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.68,
      elevation: 10,

      child: SafeArea(
        top: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchHomeDataState) {
              return Column(
                children: [

                  /// ================= HEADER =================
                  _header(context: context),

                  /// ================= MENU =================
                  Flexible(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: _horizontal(context: context),
                        vertical: _vertical(context: context),
                      ),
                      children: [
                        _listBuilder(dataState: state),
                      ],
                    ),
                  ),

                  /// ================= LOGOUT =================
                  _logout(context: context),
                ],
              );
            } else {
              return const Center(
                child: CenterLoaderWidget(),
              );
            }
          },
        ),
      ),
    );
  }

  /// ================= HEADER =================

  Widget _header({required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.1,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            EnvironmentConfig.of(context)!.primaryTheme,
            EnvironmentConfig.of(context)!.secondaryTheme,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            padding: EdgeInsets.all(width * 0.015),
            decoration: BoxDecoration(
              // ✅ was Colors.white — use semi-transparent white so it
              //    looks good on gradient in both light and dark mode
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              AppIcon.appLogo(),
              height: width * 0.11,
              width: width * 0.11,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(width: width * 0.035),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  userData.name.toString(),
                  maxLines: 1,
                  color: Colors.white,       // ✅ fine — on gradient bg
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: width * 0.01),
                TextWidget(
                  userData.email.toString(),
                  maxLines: 1,
                  color: Colors.white70,     // ✅ fine — on gradient bg
                  fontSize: width * 0.028,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= MENU LIST =================

  Widget _listBuilder({required FetchHomeDataState dataState,}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataState.drawerList.length,
      itemBuilder: (context, index) {
        final item = dataState.drawerList[index];

        /// ================= NORMAL MENU =================
        if (item.sublist.isEmpty) {
          return _singleMenuItem(
            context: context,
            item: item,
          );
        }

        /// ================= EXPANSION MENU =================
        return _expandableMenuItem(
          context: context,
          item: item,
        );
      },
    );
  }

  /// ================= SINGLE MENU =================

  /// ================= SINGLE MENU =================
  Widget _singleMenuItem({
    required BuildContext context,
    required DrawerModel item,
  }) {
    final theme = Theme.of(context);
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;
    final textColor = theme.colorScheme.onSurface; // ✅

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBarWidget(
                    boolLeading: true,
                    title: item.label.toString(),
                  ),
                  body: BackgroundWidget(child: item.widget),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(item.icon, color: primaryColor, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: TextWidget(
                    item.label,
                    color: textColor,
                    fontSize: AppFont.font_13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  // ✅ was Colors.grey.shade500 — hardcoded
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= EXPANSION MENU =================

  /// ================= EXPANSION MENU =================
  Widget _expandableMenuItem({
    required BuildContext context,
    required DrawerModel item,
  }) {
    final theme = Theme.of(context);
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;
    final textColor = theme.colorScheme.onSurface; // ✅

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        childrenPadding: EdgeInsets.zero,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        // ✅ was AppColor.black — invisible in dark mode
        iconColor: theme.colorScheme.onSurface,
        collapsedIconColor: theme.colorScheme.onSurface,

        leading: Icon(item.icon, color: primaryColor, size: 24),

        title: TextWidget(
          item.label,
          color: textColor,
          fontSize: AppFont.font_13,
          fontWeight: FontWeight.w600,
        ),

        children: item.sublist.map((subItem) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 58, right: 16),
            leading: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            horizontalTitleGap: 10,
            title: TextWidget(
              subItem.label ?? "",
              color: textColor,
              fontSize: AppFont.font_12,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              Navigator.pop(context);
              AppConfig.instanceInit()?.setActivitySection(
                newActivitySection: subItem.activityData,
              );
              print("activityData ==> ${subItem.activityData.appJoint}");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBarWidget(
                      boolLeading: true,
                      title: subItem.label ?? "",
                    ),
                    body: BackgroundWidget(child: subItem.widget),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  /// ================= LOGOUT =================

  /// ================= LOGOUT =================
  Widget _logout({required BuildContext context}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // ✅ was Colors.grey.shade300 — too light in dark mode
    final borderColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade300;

    // ✅ was Colors.red.shade50 — wrong in dark mode
    final logoutBg = isDark
        ? Colors.red.withValues(alpha: 0.15)
        : Colors.red.shade50;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            showModalBottomSheet(
              context: context,
              // ✅ was default white
              backgroundColor: theme.colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => const LogoutWidget(),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: logoutBg, // ✅
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.logout_rounded, color: Colors.red.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: TextWidget(
                    AppString.logout,
                    fontSize: AppFont.font_13,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _vertical({required BuildContext context}){
    return MediaQuery.of(context).size.height * 0.001;
  }
  _horizontal({required BuildContext context}){
    return MediaQuery.of(context).size.height * 0.002;
  }
}