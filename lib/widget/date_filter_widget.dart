import 'package:flutter/material.dart';
import 'package:karyam/enums/enums.dart';
import 'package:karyam/screen/home/viewmodel/home_viewmodel.dart';

class DateFilterWidget extends StatelessWidget {
  final HomeViewModel model;
  final GlobalKey _filterKey = GlobalKey();
  DateFilterWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final RenderBox renderBox = _filterKey
            .currentContext
            ?.findRenderObject() as RenderBox;
        final Size size = renderBox.size;
        final Offset offset =
        renderBox.localToGlobal(Offset.zero);
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy + size.height,
                offset.dx + size.width,
                offset.dy + size.height),
            elevation: 4,
            items: [
              PopupMenuItem(
                child: const Text("None"),
                onTap: () {
                  model.applyFilter(ApplyFilter.none);
                },
              ),
              PopupMenuItem(
                  child: const Text("Today"),
                  onTap: () {
                    model.applyFilter(
                        ApplyFilter.today);
                  }),
              PopupMenuItem(
                child: const Text("Tomorrow"),
                onTap: () {
                  model.applyFilter(
                      ApplyFilter.tomorrow);
                },
              ),
              PopupMenuItem(
                child: const Text("Over Due"),
                onTap: () {
                  model.applyFilter(
                      ApplyFilter.overdue);
                },
              ),
              PopupMenuItem(
                child: const Text("Custom Day"),
                onTap: () async {
                  Future.delayed(Duration.zero,
                          () async {
                        DateTime? dateTime =
                        await showDatePicker(
                            initialEntryMode:
                            DatePickerEntryMode
                                .calendarOnly,
                            context: context,
                            initialDate:
                            model.filterDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (dateTime != null) {
                          model.applyFilter(
                              ApplyFilter.customDate,
                              dateTime: dateTime);
                        }
                      });
                },
              ),
            ]);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 4,
          top: 4,
        ),
        child: Icon(
          key: _filterKey,
          Icons.filter_alt,
          color:
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
