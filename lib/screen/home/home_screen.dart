import 'package:flutter/material.dart';
import 'package:msaver/screen/new_task_screen/new_task_screen.dart';
import 'package:msaver/widget/new_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNewTaskWidgetVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 10,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 64,),
              Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.home_filled,),
                    SizedBox(width: 24,),
                    Text("Home", style: TextStyle(fontSize: 16)),
                    Container(
                      child: Text("12"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            // setState(() {
            //   isNewTaskWidgetVisible = false;
            // });

            await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const NewTaskWidget(),
                transitionDuration: const Duration(milliseconds: 200),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          },
          strokeWidth: 1,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: Stack(
            children: [
              ListView(),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: const [
                    SizedBox(
                      height: 54,
                    ),
                    Text(
                      "MSaver",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              //  AnimatedOpacity(
              //   opacity: isNewTaskWidgetVisible ? 1.0 : 0.0,
              //   duration: Duration(milliseconds: 200),
              //   child: NewTaskWidget(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
