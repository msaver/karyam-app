import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:karyam/constant/string_constant.dart';
import 'package:karyam/data/preference/preferences_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    moveToNextScreen(context);
    return Scaffold(
      body: Center(
        child: Text(
          "Karyam",
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.w200, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  void moveToNextScreen(BuildContext context) async {
    String name = await PreferencesData.getUserName();
    await Future.delayed(const Duration(seconds: 3));
    if (name.isEmpty) {
      context.go(StringConstant.setupProfile);
    } else {
      context.go(StringConstant.home);
    }
  }
}
