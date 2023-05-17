import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';

class CategoryItemWidget extends StatelessWidget {
  final bool isSelected;
  final Category category;
  const CategoryItemWidget({Key? key, required this.isSelected, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
      decoration: BoxDecoration(
          color: isSelected ? Colors.grey[100] : Colors.white,
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
          Text(category.name, style: TextStyle(fontSize: 16,)),
          const Spacer(),
          Container(
            height: 32,
            width: 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Center(child: Text("${category.count}")),
          )
        ],
      ),
    );
  }
}
