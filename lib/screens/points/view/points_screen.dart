import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/component/points_card_component.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

const tabTitles = ['History', 'Earned', 'Used'];

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen>
    with SingleTickerProviderStateMixin {
  late final tabController =
      TabController(length: tabTitles.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.points,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: Column(
        children: [
          const PointsCardComponent(),
          TabBar(
            controller: tabController,
            tabs: tabTitles.map((e) => Tab(text: e)).toList(),
          ),
          AnimatedListView(
            itemCount: 3,
            itemBuilder: (_, index) {
              return Container(
                decoration: boxDecorationDefault(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Men’s Haircut', style: boldTextStyle(size: 14)),
                        4.height,
                        Text(
                          'Earn points by completing services.',
                          style: secondaryTextStyle(size: 12),
                        ),
                        2.height,
                        Text(
                          '10/10/2021',
                          style: secondaryTextStyle(size: 12),
                        ),
                      ],
                    ).expand(),
                    Text(
                      '+100',
                      style: boldTextStyle(),
                    ),
                  ],
                ),
              );
            },
          ).expand()
        ],
      ),
    );
  }
}
