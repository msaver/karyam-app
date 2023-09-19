import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:karyam/constant/image_constant.dart';
import 'package:karyam/screen/home/viewmodel/home_viewmodel.dart';
import 'package:karyam/widget/category_item_widget.dart';
import 'package:karyam/widget/category_listing_horizontal_widget.dart';
import 'package:karyam/widget/chip_widget.dart';
import 'package:karyam/widget/create_category_item_widget.dart';
import 'package:karyam/widget/date_filter_widget.dart';
import 'package:karyam/widget/new_task_widget.dart';
import 'package:karyam/widget/task_listing_widget.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _controller = ScrollController();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void dispose() {
    homeViewModel.closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: homeViewModel,
      child: UpgradeAlert(
        upgrader: Upgrader(
            dialogStyle: Platform.isAndroid
                ? UpgradeDialogStyle.material
                : UpgradeDialogStyle.cupertino),
        child: Scaffold(
          key: scaffoldKey,
          onDrawerChanged: (isOpen) async {
            if (!isOpen) {
              await Future.delayed(const Duration(milliseconds: 100));
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          drawer: buildDrawerWidget(context),
          appBar: AppBar(
            elevation: 12,
            title: const Text("Karyam"),
            actions: [
              InkWell(
                onTap: () {
                  context.go("/home/about");
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.info_outline),
                ),
              )
            ],
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
                        pageBuilder: (_, __, ___) =>
                            NewTaskWidget(categories: model.categories),
                        transitionDuration: const Duration(milliseconds: 200),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                    );
                    model.updateTasks();
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
                              child:
                                  CategoryListingHorizontalWidget(model: model),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: DateFilterWidget(
                                model: model,
                              ),
                            ),
                            // SelectDateWidget(),
                            const SizedBox(
                              height: 16,
                            ),
                            model.tasks.isNotEmpty
                                ? TaskListingWidget(
                                    model: model,
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              color:
                                                  Theme.of(context).hintColor,
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
      ),
    );
  }

  Widget chipsContainer(String text, int colorCode) {
    return ChipWidget(text: text, colorCode: colorCode);
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
      height: MediaQuery.of(context).size.height * 1,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Consumer<HomeViewModel>(
          builder: (BuildContext context, model, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 32.0, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "<---- Slide left",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                DrawerHeader(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            child: Text(model.userName![0],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300)),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Welcome, ${model.userName}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CreateCategoryItemWidget(model),
                        ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryItemWidget(
                                isSelected: model.selectedCategory.name ==
                                    model.categories[index].name,
                                category: model.categories[index],
                                onCategorySelected: (category) {
                                  model.updateSelectedCategory(category);
                                  scaffoldKey.currentState!.closeDrawer();
                                  _animateToIndex(index);
                                },
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.categories.length,
                            shrinkWrap: true),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
