import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:karyam/screen/home/viewmodel/home_viewmodel.dart';
import 'package:karyam/util/app_utils.dart';
import 'package:karyam/widget/chip_widget.dart';
import 'package:karyam/widget/new_task_widget.dart';

class TaskListingWidget extends StatelessWidget {
  final HomeViewModel model;

  const TaskListingWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.tasks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog.adaptive(
                        title: const Text(
                          "Warning!",
                          style: TextStyle(color: Colors.red),
                        ),
                        content:
                            const Text("Are you sure to delete this task?"),
                        actions: [
                          adaptiveAction(
                              context: context,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          adaptiveAction(
                              context: context,
                              onPressed: () {
                                model.deleteTask(model.tasks[index]);
                                Navigator.pop(context);
                              },
                              child: const Text("Confirm"))
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.primary,
                icon: Icons.delete_forever,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (context) async {
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => NewTaskWidget(
                          categories: model.categories,
                          taskId: model.tasks[index].id),
                      transitionDuration: const Duration(milliseconds: 200),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  );
                  model.updateTasks();
                  model.updateCategoryValues();
                },
                backgroundColor: Theme.of(context).colorScheme.background,
                foregroundColor: Theme.of(context).colorScheme.primary,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Card(
              color: !model.tasks[index].isCompleted!
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).highlightColor,
              elevation: 0,
              child: ListTile(
                leading: Theme(
                  data: ThemeData(
                      unselectedWidgetColor:
                          Color(model.tasks[index].category!.colorCode)),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      activeColor: Color(model.tasks[index].category!.colorCode)
                          .withOpacity(0.3),
                      checkColor: Colors.white,
                      value: model.tasks[index].isCompleted,
                      onChanged: (bool? value) {
                        model.taskComplete(value!, model.tasks[index]);
                      },
                    ),
                  ),
                ),
                title: Text(
                  model.tasks[index].taskName!,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: model.tasks[index].isCompleted!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 16),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      chipsContainer(
                          AppUtils.getValueOfDate(
                              model.tasks[index].tobeDoneDate!),
                          Theme.of(context).primaryColor.value),
                      const SizedBox(
                        width: 16,
                      ),
                      chipsContainer(model.tasks[index].category!.name,
                          model.tasks[index].category!.colorCode),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget adaptiveAction(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  Widget chipsContainer(String text, int colorCode) {
    return ChipWidget(text: text, colorCode: colorCode);
  }
}
