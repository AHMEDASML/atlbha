import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';

Widget lineSettingWidget() {
  return Column(
    children: [
      Divider(
        height: 1,
        color: ColorManager.gray6.withOpacity(0.2),
      ),
      Divider(
        height: 1,
        color: ColorManager.gray6.withOpacity(0.2),
      ),
      Divider(
        height: 1,
        color: ColorManager.gray6.withOpacity(0.2),
      ),
      Divider(
        height: 1,
        color: ColorManager.gray6.withOpacity(0.2),
      ),
      Divider(
        height: 1,
        color: ColorManager.gray6.withOpacity(0.2),
      ),
    ],
  );
}

class ProfileWidgetImageLogin extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const ProfileWidgetImageLogin({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  State<ProfileWidgetImageLogin> createState() =>
      _ProfileWidgetImageLoginState();
}

class _ProfileWidgetImageLoginState extends State<ProfileWidgetImageLogin> {
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      CircleAvatar(
        foregroundColor: Colors.white38,
        backgroundColor: ColorManager.yellow2,
        radius: 50,
        child: Text('A',
            style: TextStyle(fontSize: 70, color: ColorManager.white)),
      ),
      const SizedBox(
        width: 10,
      ),
      ButtonAppGold(
        onTap: widget.onTap,
        boxShadow: const BoxShadow(),
        text: widget.text,
        height: 50,
        width: 130,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      )
    ]);
  }
}

Widget lineSubSettingWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(
      height: 1,
      color: ColorManager.gray6.withOpacity(0.3),
    ),
  );
}

Widget listTileTitleWidgetSetting(
    {required BuildContext context, required String text, IconData? icon}) {
  return ListTile(
    title: Text(text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.firstGray,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
    leading: Icon(icon ?? Icons.settings, color: ColorManager.firstGray),
  );
}

Widget listTileSubWidgetSetting(
    {required BuildContext context,
    required String text,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      title: Text(text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.black4,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
      trailing:
          Icon(Icons.arrow_back_ios_new, color: ColorManager.black, size: 20),
    ),
  );
}
