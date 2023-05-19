import 'package:flutter/material.dart';
import 'package:msaver/constant/image_constant.dart';
import 'package:msaver/screen/home/viewmodel/home_viewmodel.dart';
import 'package:msaver/widget/category_item_widget.dart';
import 'package:msaver/widget/create_category_item_widget.dart';
import 'package:msaver/widget/new_task_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeViewModel(),
      child: Scaffold(
        onDrawerChanged: (isOpen) async {
          if (!isOpen) {
            await Future.delayed(const Duration(milliseconds: 100));
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        drawer: buildDrawerWidget(context),
        appBar: AppBar(
          elevation: 12,
          title: const Text("M.Saver"),
        ),
        body: Consumer<HomeViewModel>(
          builder: (BuildContext context, model, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => NewTaskWidget(model: model),
                      transitionDuration: const Duration(milliseconds: 200),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                },
                strokeWidth: 1,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          buildTextForSwipeDown(context),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Categories',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).hintColor,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: ListView.builder(
                              itemCount: model.categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, right: 4.0),
                                  child: Card(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0,
                                            right: 16,
                                            top: 8.0,
                                            bottom: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${model.categories[index].pendingCount} Task',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              model.categories[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(height: 12),
                                            LinearProgressIndicator(
                                              value: model.getProgress(
                                                  model.categories[index]),
                                              minHeight: 2,
                                              color: Color(model
                                                  .categories[index].colorCode),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          model.tasks.isNotEmpty
                              ? ListView.builder(
                                  itemCount: model.tasks.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  reverse: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Card(
                                        color: !model.tasks[index].isCompleted
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                            : Theme.of(context).highlightColor,
                                        elevation: 0,
                                        child: ListTile(
                                          leading: Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor: Color(
                                                    model.tasks[index].category!
                                                        .colorCode)),
                                            child: Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                activeColor: Color(model
                                                        .tasks[index]
                                                        .category!
                                                        .colorCode)
                                                    .withOpacity(0.3),
                                                checkColor: Colors.white,
                                                value: model
                                                    .tasks[index].isCompleted,
                                                onChanged: (bool? value) {
                                                  model.taskComplete(value!,
                                                      model.tasks[index]);
                                                },
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            model.tasks[index].taskName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                decoration: model.tasks[index]
                                                        .isCompleted
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                                fontSize: 16),
                                          ),
                                          subtitle: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 4,
                                                  top: 4),
                                              decoration: BoxDecoration(
                                                  color: Color(model
                                                      .tasks[index]
                                                      .category!
                                                      .colorCode),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12))),
                                              child: Text(
                                                model.tasks[index].category!
                                                    .name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 120,
                                      ),
                                      Image.asset(
                                        ImageConstant.emptyImage,
                                        height: 120,
                                        width: 120,
                                      ),
                                      Text(
                                        'Create new task with swipe down',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).hintColor,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Center buildTextForSwipeDown(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.swipe_down, color: Theme.of(context).colorScheme.primary),
          Text(
            'Swipe down to create new task',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
                fontSize: 14),
          ),
        ],
      ),
    );
  }

  SizedBox buildDrawerWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 10,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Consumer<HomeViewModel>(
              builder: (BuildContext context, model, Widget? child) {
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
                                  category: model.categories[index]);
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.categories.length,
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
    );
  }
}
