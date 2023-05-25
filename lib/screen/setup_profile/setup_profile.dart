import 'package:flutter/material.dart';
import 'package:msaver/screen/setup_profile/viewmodel/setup_profile_viewmodel.dart';
import 'package:msaver/widget/primary_button.dart';
import 'package:provider/provider.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({Key? key}) : super(key: key);

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SetupProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setup your Profile here"),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Consumer<SetupProfileViewModel>(
      builder: (BuildContext context, model, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 64,
            ),
            const Text(
              "What we call you?",
              style: TextStyle(fontSize: 20),
            ),
            Align(
              alignment: Alignment.center,
              child: TextFormField(
                controller: model.nameController,
                style: const TextStyle(fontSize: 24.0),
                maxLines: 1,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  hintText: "Your name, please",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(text: "Next", onPressed: () {
                model.updateName(context);
              }),
            )
          ],
        );
      },
    );
  }
}
