import 'package:flutter/material.dart';
import 'package:karyam/data/category/category.dart';

class CategoryItemWidget extends StatelessWidget {
  final bool isSelected;
  final Category category;
  final Function(Category) onCategorySelected;

  const CategoryItemWidget(
      {Key? key,
      required this.isSelected,
      required this.category,
      required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCategorySelected.call(category);
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.crop_square,
              color: Color(category.colorCode),
            ),
            const SizedBox(
              width: 24,
            ),
            Text(category.name,
                style: const TextStyle(
                  fontSize: 16,
                )),
            const Spacer(),
            if (category.pendingCount != 0)
              Container(
                height: 32,
                width: 40,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text("${category.pendingCount}")),
              )
          ],
        ),
      ),
    );
  }
}
