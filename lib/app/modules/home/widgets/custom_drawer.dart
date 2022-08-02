import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key? key,
    required this.contextGlobal,
  }) : super(key: key);
  BuildContext contextGlobal;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Container(
        color: Palette.purple.withOpacity(0.9),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            const _LogoHeader(),
            _DrawerTile(
              textColor: Palette.white,
              label: 'Perfil',
              onTap: () {
                Get.back();
                Get.toNamed(Routes.PROFILE);
              },
            ),
            _DrawerTile(
              textColor: Palette.white,
              label: 'Cerrar Sesión',
              onTap: () async {
                await auth.signOut();
                Get.offAllNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoHeader extends StatelessWidget {
  const _LogoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'RondApp',
                style: styles.tittleDrawer,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.topRight,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: Get.back,
                      child: const Icon(
                        Icons.close,
                        size: 36,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.label,
    required this.onTap,
    required this.textColor,
    this.padding,
  });
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(left: 20, bottom: 20),
        child: CupertinoButton(
          onPressed: onTap,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
