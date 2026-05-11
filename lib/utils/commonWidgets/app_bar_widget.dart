import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/app_color.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class AppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool? boolLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? tabBar;

  const AppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.boolLeading,
    this.actions,
    this.tabBar,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (tabBar?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double logoSize = size.width * 0.10;
    final double titleFont = size.width * 0.032;
    final double subTitleFont = size.width * 0.022;

    return AppBar(
      automaticallyImplyLeading: boolLeading ?? true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      centerTitle: true,
      leading: leading,
      actions: actions,
      bottom: tabBar,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              EnvironmentConfig.of(context)!.primaryTheme,
              EnvironmentConfig.of(context)!.secondaryTheme,
            ],
          ),
        ),
      ),

      titleSpacing: 0,

      title: Row(
        children: [
          /// LEFT LOGO
          _logoContainer(
            context,
            UserInfo.instance!.userData!.projectLogo,
            logoSize,
          ),

          SizedBox(width: size.width * 0.02),

          /// CENTER CONTENT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// PAGE TITLE
                Text(
                  title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),

                SizedBox(height: size.height * 0.002),

                /// SECTION INFO
                Text(
                  "${UserInfo.instance!.userData!.sectionName}"
                      " | Dia - ${UserInfo.instance!.userData!.diameter}"
                      "${UserInfo.instance!.userData!.diauom}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subTitleFont,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: size.width * 0.02),

          /// RIGHT LOGO
          _logoContainer(
            context,
            UserInfo.instance!.userData!.smartLogo,
            logoSize,
          ),

          SizedBox(width: size.width * 0.01),
        ],
      ),
    );
  }

  Widget _logoContainer(
      BuildContext context,
      String? url,
      double size,
      ) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.2),
        child: Image.network(
          url ?? "",
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.image_not_supported,
              size: 18,
            );
          },
        ),
      ),
    );
  }
}