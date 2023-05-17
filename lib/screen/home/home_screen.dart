import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';
import 'package:msaver/screen/new_task_screen/new_task_screen.dart';
import 'package:msaver/widget/category_item_widget.dart';
import 'package:msaver/widget/create_category_item_widget.dart';
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
              const SizedBox(
                height: 64,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CategoryItemWidget(isSelected: true, category: Category("Home",0xFF177e89, 12 )),
                      CategoryItemWidget(isSelected: false, category: Category("Personal",0xFFDB8480, 8 )),
                      CategoryItemWidget(isSelected: true, category: Category("Work",0xFF335C67, 4 )),
                      CategoryItemWidget(isSelected: false, category: Category("Complete",0xCB5959FF, 1 )),
                      CreateCategoryItemWidget()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 12,
        title: const Text("M.Saver"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const NewTaskWidget(),
                transitionDuration: const Duration(milliseconds: 200),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              ),
            );
          },
          strokeWidth: 1,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: Stack(
            children: [
              ListView(),
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
