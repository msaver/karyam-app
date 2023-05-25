import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:karyam/constant/string_constant.dart';
import 'package:karyam/data/preference/preferences_data.dart';

class SetupProfileViewModel extends ChangeNotifier{

  final TextEditingController nameController = TextEditingController();

  SetupProfileViewModel();

  void updateName(BuildContext context) {
    PreferencesData.setUserName(userName: nameController.text);
    context.go(StringConstant.home);
  }

}