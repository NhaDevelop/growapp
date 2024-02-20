import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';
import '../../../utils/colors.dart';

class FilterCategoryComponent extends StatefulWidget {
  const FilterCategoryComponent({super.key});

  @override
  State<FilterCategoryComponent> createState() =>
      _FilterCategoryComponentState();
}

class _FilterCategoryComponentState extends State<FilterCategoryComponent> {
  List categoryList = ["All", "Clothing", "Toys", "Food"];

  int categorySelectIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
                label: locale.category,
                labelTextStyle: boldTextStyle(),
                isShowAll: false)
            .paddingSymmetric(horizontal: 16),
        HorizontalList(
          spacing: 16,
          itemCount: categoryList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: radius(),
              onTap: () {
                categorySelectIndex = index;
                setState(() {});
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: boxDecorationDefault(
                    color: categorySelectIndex == index
                        ? indicatorColor
                        : context.cardColor),
                child: Text('${categoryList[index]}',
                    style: boldTextStyle(
                        color: categorySelectIndex == index
                            ? Colors.black
                            : textSecondaryColorGlobal,
                        size: 12)),
              ),
            );
          },
        ),
      ],
    );
  }
}
