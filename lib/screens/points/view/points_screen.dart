import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/component/earned_points_chart_component.dart';
import 'package:grow_tokyo_app/screens/points/component/expiring_alerts_component.dart';
import 'package:grow_tokyo_app/screens/points/component/points_card_component.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/screens/points/point_repository.dart';
import 'package:grow_tokyo_app/screens/points/shimmer/point_transactions_shimmer.dart';
import 'package:grow_tokyo_app/screens/points/shimmer/points_card_shimmer.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  UniqueKey transactionsWidgetKey = UniqueKey();
  Future<PointData>? pointsFuture;
  Future<List<PointTransactionData>>? transactionsFuture;
  List<PointTransactionData> transactionsObj = [];
  int page = 1;
  String? tabParam;

  List<String> get tabTitles => [locale.history, locale.earned, locale.used];
  List<String?> get tabParams => [null, 'earned', 'used'];

  @override
  void initState() {
    super.initState();
    userStore.setUnreadNotificationCount(0);
    tabController.addListener(() {
      tabParam = tabParams[tabController.index];
      if (tabController.indexIsChanging) {
        refetchTransactions(showLoading: true);
      } else {
        setState(() {});
      }
    });
    init();
  }

  Future<void> init() async {
    pointsFuture = getPointsAPI(transactions: transactionsObj);
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    ).then((list) {
      pointsFuture = getPointsAPI(transactions: list);
      return list;
    });
  }

  void refetchTransactions({bool showLoading = false}) {
    page = 1;
    transactionsWidgetKey = UniqueKey();
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    ).then((list) {
      pointsFuture = getPointsAPI(transactions: list);
      return list;
    });
    if (showLoading) setState(() {});
  }

  void loadMoreTransactions() {
    page++;
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    );
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: locale.points,
      body: SnapHelperWidget<PointData>(
        future: pointsFuture,
        loadingWidget: const PointsCardShimmer(),
        errorBuilder: (error) => NoDataWidget(
          title: error.toString(),
          imageWidget: const ErrorStateWidget(),
          onRetry: () {
            refetchTransactions(showLoading: true);
          },
        ),
        onSuccess: (points) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: PointsCardComponent(points: points),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverTabBarDelegate(
                    TabBar(
                      controller: tabController,
                      labelColor: context.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: context.primaryColor,
                      indicatorWeight: 3,
                      tabs: tabTitles.map((title) => Tab(text: title)).toList(),
                    ),
                    context.cardColor,
                  ),
                ),
                if (tabController.index == 0) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ExpiringAlertsComponent(points: points),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: EarnedPointsChartComponent(points: points),
                  ),
                ],
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Text(
                      'Recent Transactions',
                      style: boldTextStyle(size: 15),
                    ),
                  ),
                ),
              ];
            },
            body: SnapHelperWidget<List<PointTransactionData>>(
              key: transactionsWidgetKey,
              future: transactionsFuture,
              loadingWidget: const PointTransactionsShimmer(),
              errorBuilder: (error) => NoDataWidget(
                title: error.toString(),
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  refetchTransactions(showLoading: true);
                },
              ),
              onSuccess: (transactions) {
                final displayList = tabController.index == 0
                    ? transactions
                    : transactions.where((t) {
                        if (tabController.index == 1) return !t.isDeduction;
                        if (tabController.index == 2) return t.isDeduction;
                        return true;
                      }).toList();

                if (displayList.isEmpty) {
                  return Center(
                    child: Text(
                      locale.noTransactionFound,
                      style: secondaryTextStyle(size: 13),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    if (index == displayList.length) {
                      loadMoreTransactions();
                      return const SizedBox(height: 20);
                    }
                    final transaction = displayList[index];
                    final valStr = transaction.value.toStringAsFixed(
                      transaction.value.truncateToDouble() == transaction.value
                          ? 0
                          : 2,
                    );
                    final displayVal = (transaction.value == 0)
                        ? '0 P'
                        : (transaction.isDeduction
                            ? '-$valStr P'
                            : '+$valStr P');

                    return Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.circular(12),
                        backgroundColor: context.cardColor,
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.displayTitle,
                                style: boldTextStyle(size: 14),
                              ),
                              4.height,
                              if (transaction.createdAtStr != null)
                                Text(
                                  formatDate(
                                    transaction.createdAtStr!,
                                    format: DateFormatConst.BOOK_DATE_FORMAT,
                                  ),
                                  style: secondaryTextStyle(size: 11),
                                ),
                            ],
                          ).expand(),
                          16.width,
                          Text(
                            displayVal,
                            style: boldTextStyle(
                              size: 14,
                              color: transaction.value == 0
                                  ? textSecondaryColorGlobal
                                  : (transaction.isDeduction
                                      ? const Color(0xFFFF5252)
                                      : const Color(0xFF4CAF50)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
