// splash_screen.dart
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/splash/view/screen/select_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          const SelectLanguage(), // Replace with your next screen widget
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.yellow2,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoAppWidget(),
              SizedBox(
                height: 20,
              ),
              TextBoldeWidget(
                text: 'Atlobha',
              ),
              TextBoldeWidget(
                text: 'اطلبها',
              ),
            ],
          ),
        ));
  }
}
