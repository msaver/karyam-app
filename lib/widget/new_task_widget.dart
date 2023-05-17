import 'package:flutter/material.dart';
import 'package:msaver/widget/primary_button.dart';

class NewTaskWidget extends StatelessWidget {
  const NewTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[600],
                )),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              style: const TextStyle(fontSize: 24.0),
              maxLines: 2,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: InputBorder.none,
                  hintText: "What you wanna do?",
                  hintStyle: TextStyle(
                    fontSize: 24,
                  )),
            ),
            const SizedBox(
              width: double.infinity,
              height: 54,
              child: PrimaryButton(),
            ),
          ],
        ),
      ),
    );
  }
}
