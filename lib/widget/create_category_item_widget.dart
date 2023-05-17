import 'package:flutter/material.dart';
import 'package:msaver/data/category/category.dart';

class CreateCategoryItemWidget extends StatefulWidget {
  const CreateCategoryItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateCategoryItemWidget> createState() =>
      _CreateCategoryItemWidgetState();
}

class _CreateCategoryItemWidgetState extends State<CreateCategoryItemWidget> {
  bool isNewItemCreate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: InkWell(
        onTap: () {
          setState(() {
            isNewItemCreate = true;
          });
        },
        child: !isNewItemCreate
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text("Create List",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ],
              )
            : createNewItemField(),
      ),
    );
  }

  Widget createNewItemField(){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.crop_square,
          color: Colors.black,
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.done,
            onEditingComplete: (){
              setState(() {
                isNewItemCreate = false;
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Category name",
            ),
          ),
        )
      ],
    );
  }


}
