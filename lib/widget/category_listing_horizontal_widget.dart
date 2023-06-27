import 'package:flutter/material.dart';
import 'package:karyam/screen/home/viewmodel/home_viewmodel.dart';

class CategoryListingHorizontalWidget extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  final HomeViewModel model;
  CategoryListingHorizontalWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: model.categories.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 4.0, right: 4.0),
          child: Card(
            borderOnForeground: false,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: model.selectedCategory
                      .name ==
                      model.categories[index].name
                      ? Theme.of(context)
                      .colorScheme
                      .primary
                      : Colors.transparent),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: InkWell(
              onTap: () {
                model.updateSelectedCategory(
                    model.categories[index]);
              },
              child: SizedBox(
                height: MediaQuery.of(context)
                    .size
                    .height *
                    0.14,
                width: MediaQuery.of(context)
                    .size
                    .width *
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
                            fontWeight:
                            FontWeight.w700,
                            color: Theme.of(context)
                                .hintColor,
                            fontSize: 14),
                      ),
                      Text(
                        model.categories[index].name,
                        style: const TextStyle(
                            fontWeight:
                            FontWeight.w700,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: model.getProgress(
                            model.categories[index]),
                        minHeight: 2,
                        color: Color(model
                            .categories[index]
                            .colorCode),
                      )
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
}
