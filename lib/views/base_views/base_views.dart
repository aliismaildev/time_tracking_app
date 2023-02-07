import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/assets.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/consts/menu_items.dart';
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
      appBar: showAppBar
          ? AppBar(
              title: const Text("HomeView test"),
              actions: [
                PopupMenuButton(
                  color: const Color.fromRGBO(58, 66, 86, 1.0),
                  onSelected: (value) async {
                    if (value == MenuItems.logOut) {
                      await read.logOut().then((value) => Navigator.pushReplacementNamed(context, LoginView.routeName));
                    }
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                        value: MenuItems.logOut,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            AppAssets.logoutSvg,
                            color: AppColors.deleteColor,
                            height: context.percentHeight * 3.0,
                          ),
                          title: subText2(Lang.logout),
                        ),
                      ),
                    ];
                  },
                )
              ],
            )
          : null,
      body: SingleChildScrollView(scrollDirection: scrollDirection, child: body),
    );
  }
}
