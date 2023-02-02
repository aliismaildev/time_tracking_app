import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/assets.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/core/viewmodels/auth_viewmodel.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/auth/login_view.dart';
import 'package:time_tracking_app/views/widgets/text.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final Axis scrollDirection;
  final bool showAppBar;

  const BaseScaffold({Key? key, required this.body, this.scrollDirection = Axis.vertical, this.showAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: showAppBar ? AppBar(title: const Text("HomeView test")) : null,
      drawer: Drawer(
        backgroundColor: AppColors.primary,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  subText5("${Lang.name}: John Carry"),
                ],
              ),
            ),
            SizedBox(
              height: context.percentHeight * 5.0,
            ),
            _drawerListTile(
                context: context,
                isLogoutTile: true,
                title: Lang.logout,
                icon: AppAssets.logoutSvg,
                onTap: () async => await read.logOut().then((value) => Navigator.pushReplacementNamed(context, LoginView.routeName))),
          ],
        ),
      ),
      body: SingleChildScrollView(scrollDirection: scrollDirection, child: body),
    );
  }

  Widget _drawerListTile({
    required BuildContext context,
    required String title,
    required String icon,
    bool isLogoutTile = false,
    required GestureTapCallback onTap,
  }) {
    return SizedBox(
      height: context.percentHeight * 10,
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            minVerticalPadding: context.percentHeight * 3.0,
            minLeadingWidth: context.percentWidth * 15,
            leading: SvgPicture.asset(
              icon,
              color: isLogoutTile ? AppColors.deleteColor : null,
              height: context.percentHeight * 2.5,
            ),
            title: subText4(title,
                fontWeight: FontWeight.w500, color: isLogoutTile ? AppColors.deleteColor : AppColors.textColor, align: TextAlign.left),
          ),
          Container(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
