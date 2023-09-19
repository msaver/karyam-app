import 'package:flutter/material.dart';
import 'package:karyam/data/category/category.dart';
import 'package:karyam/screen/home/viewmodel/home_viewmodel.dart';
import 'package:karyam/util/app_utils.dart';
import 'package:karyam/widget/primary_button.dart';
import 'package:provider/provider.dart';

class NewTaskWidget extends StatelessWidget {
  // final HomeViewModel model;
  final List<Category> categories;
  final String? taskId;
  final List<Category> localCategories = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  NewTaskWidget({super.key, Key? key1, required this.categories, this.taskId}) {
    // localCategories.addAll(categories);
    // localCategories.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeViewModel(taskId: taskId),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Consumer<HomeViewModel>(
            builder: (BuildContext context, model, Widget? child) {
              getAllCategories(model.categories);
              // model.selectedCategoryForCreateTask = localCategories[0];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                        )),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: model.taskEditingController,
                        style: const TextStyle(fontSize: 24.0),
                        validator: (value) => value!.trim().isEmpty
                            ? 'Please enter task here'
                            : null,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: InputBorder.none,
                          hintText: "What you wanna do?",
                          hintStyle: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: model.selectedDateTime,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          model.selectedDateTime = dateTime!;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12.0, top: 8, bottom: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today_sharp, size: 16),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppUtils.getValueOfDate(model.selectedDateTime),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).hintColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () async {
                          Category? category = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Select Category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).hintColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: localCategories.length - 1,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.pop(
                                              context, localCategories[index]);
                                        },
                                        leading: Icon(
                                          Icons.crop_square,
                                          color: Color(
                                              localCategories[index].colorCode),
                                        ),
                                        title: Text(
                                          localCategories[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize: 14),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (category != null) {
                            model.selectedCategoryForCreateTask = category;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12.0, top: 8, bottom: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.category_outlined, size: 16),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                model.selectedCategoryForCreateTask.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).hintColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: PrimaryButton(
                          text: taskId != null ? "Update Task" : "Add Task",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (taskId == null) {
                                model.addTask(
                                    model.taskEditingController.text,
                                    model.selectedCategoryForCreateTask,
                                    model.selectedDateTime);
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else {
                                model.updateTask(taskId!);
                              }
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void getAllCategories(List<Category> categories) {
    localCategories.clear();
    localCategories.addAll(categories);
    localCategories.removeAt(0);
  }
}
