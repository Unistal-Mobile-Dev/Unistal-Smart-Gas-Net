import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //  backgroundColor: AppColor.white,

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

          /// ================= LOGO =================

          Container(
            padding: EdgeInsets.all(width * 0.015),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
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

          /// ================= USER INFO =================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                /// USER NAME
                TextWidget(
                  userData.name.toString(),

                  maxLines: 1,


                  color: Colors.white,

                  fontSize: width * 0.038,

                  fontWeight: FontWeight.w700,
                ),

                SizedBox(height: width * 0.01),

                /// EMAIL
                TextWidget(
                  userData.email.toString(),

                  maxLines: 1,

                  color: Colors.white70,

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

  Widget _listBuilder({
    required FetchHomeDataState dataState,
  }) {
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

  Widget _singleMenuItem({
    required BuildContext context,
    required DrawerModel item,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),

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
                    title: item.label ?? "",
                  ),
                  body: BackgroundWidget(
                    child: item.widget,
                  ),
                ),
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            child: Row(
              children: [

                /// ICON
                Icon(
                  item.icon,
                  color: EnvironmentConfig.of(context)!.primaryTheme,
                  size: 24,
                ),

                const SizedBox(width: 14),

                /// TITLE
                Expanded(
                  child: TextWidget(
                    item.label,
                    fontSize: AppFont.font_13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                /// ARROW
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= EXPANSION MENU =================

  Widget _expandableMenuItem({
    required BuildContext context,
    required DrawerModel item,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),

      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),

        childrenPadding: EdgeInsets.zero,

        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        iconColor: AppColor.black,
        collapsedIconColor: AppColor.black,

        leading: Icon(
          item.icon,
          color: EnvironmentConfig.of(context)!.primaryTheme,
          size: 24,
        ),

        title: TextWidget(
          item.label,
          fontSize: AppFont.font_13,
          fontWeight: FontWeight.w600,
        ),

        children: item.sublist.map((subItem) {
          return ListTile(
            contentPadding: const EdgeInsets.only(
              left: 58,
              right: 16,
            ),

            leading: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: EnvironmentConfig.of(context)!.primaryTheme,
                shape: BoxShape.circle,
              ),
            ),

            horizontalTitleGap: 10,

            title: TextWidget(
              subItem.label ?? "",
              fontSize: AppFont.font_12,
              fontWeight: FontWeight.w500,
            ),

            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBarWidget(
                      boolLeading: true,
                      title: subItem.label ?? "",
                    ),
                    body: BackgroundWidget(
                      child: subItem.widget,
                    ),
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

  Widget _logout({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(14),

          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const LogoutWidget(),
            );
          },

          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),

            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(14),
            ),

            child: Row(
              children: [

                Icon(
                  Icons.logout_rounded,
                  color: Colors.red.shade700,
                ),

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