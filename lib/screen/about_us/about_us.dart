import 'package:flutter/material.dart';
import 'package:karyam/widget/primary_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String version = '';

  @override
  void initState() {
    getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        actions: [
          PrimaryButton(text: "Share", onPressed: (){
            launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.devlopertechie.karyam"));
          })
        ],
        elevation: 12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Version :- $version",
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "This Karyam App is Open Source Project.\nFor this app we are not storing any kind of users information. This app totally works on offline mode, which means each and everything you do, will store in your device\n\nIf this project help you anytime or you think this app make little bit impact on your day to day life please share this app as many as to your friends.\n\n In future we are adding more features in this app.",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Row(
              children: [
                PrimaryButton(text: "New Feature Request", onPressed: (){
                  launchUrl(Uri.parse("https://forms.gle/gtk7WYWM2XYYCrhL7"));
                }),

              ],
            )
          ],
        ),
      ),
    );
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
}
