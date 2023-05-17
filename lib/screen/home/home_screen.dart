import 'package:flutter/material.dart';
import 'package:msaver/screen/home/viewmodel/home_viewmodel.dart';
import 'package:msaver/widget/category_item_widget.dart';
import 'package:msaver/widget/create_category_item_widget.dart';
import 'package:msaver/widget/new_task_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeViewModel(),
      child: Scaffold(
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 10,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 64,
                ),
                Consumer<HomeViewModel>(
                  builder: (BuildContext context, model, Widget? child) {
                    // model.getAllCategory();
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoryItemWidget(
                                      isSelected: false,
                                      category: model.categories![index]);
                                },
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.categories!.length,
                                shrinkWrap: true),
                            CreateCategoryItemWidget(model)
                          ],
                        ),
                      ),
                    );
                  },
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
      ),
    );
  }
}
