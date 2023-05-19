import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:msaver/screen/home/viewmodel/home_viewmodel.dart';

class CreateCategoryItemWidget extends StatefulWidget {
  final HomeViewModel model;
  const CreateCategoryItemWidget(this.model, {
    Key? key,
  }) : super(key: key);

  @override
  State<CreateCategoryItemWidget> createState() =>
      _CreateCategoryItemWidgetState();
}

class _CreateCategoryItemWidgetState extends State<CreateCategoryItemWidget> {
  bool isNewItemCreate = false;
  Color selectedColor = const Color(0xff938989);
  TextEditingController categoryEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: InkWell(
        onTap: () {
          setState(() {
            isNewItemCreate = true;
          });
        },
        child: !isNewItemCreate
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: selectedColor,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Text("Create List",
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
        Container(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).primaryColorLight,
          ),
          child: InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(0),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor: Colors.black,
                        onColorChanged: (value){
                          Navigator.pop(context);
                          setState(() {
                            selectedColor = value;
                          });
                        },
                        enableLabel: true,
                        portraitOnly: true,
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.crop_square,
                  color: selectedColor,
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.done,
            controller: categoryEditingController,
            onEditingComplete: (){
              widget.model.addNewCategory(categoryEditingController.text, selectedColor);
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
