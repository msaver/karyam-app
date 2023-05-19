import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';
import 'package:msaver/screen/home/viewmodel/home_viewmodel.dart';
import 'package:msaver/widget/primary_button.dart';
import 'package:provider/provider.dart';

class NewTaskWidget extends StatelessWidget {
  final HomeViewModel model;

  const NewTaskWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Consumer<HomeViewModel>(
            builder: (BuildContext context, value, Widget? child) {
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
                    child: TextFormField(
                      controller: model.taskEditingController,
                      style: const TextStyle(fontSize: 24.0),
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
                                model.getValueOfDate(model.selectedDateTime),
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
                          Category category = await showModalBottomSheet(
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
                                    itemCount: model.categories.length-1,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.pop(
                                              context, model.categories[index]);
                                        },
                                        leading: Icon(
                                          Icons.crop_square,
                                          color: Color(model
                                              .categories[index].colorCode),
                                        ),
                                        title: Text(
                                          model.categories[index].name,
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

                          model.selectedCategory = category;
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
                                model.selectedCategory.name,
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
                          text: "Add Task",
                          onPressed: () async{
                            model.addTask(model.taskEditingController.text,
                                model.selectedCategory, model.selectedDateTime);
                            FocusManager.instance.primaryFocus?.unfocus();
                            await Future.delayed(const Duration(milliseconds: 100));

                            Navigator.pop(context);
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
}
