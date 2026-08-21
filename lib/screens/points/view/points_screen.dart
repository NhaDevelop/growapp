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
import 'package:grow_tokyo_app/utils/app_common.dart';
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
      setState(() {});
      return list;
    });
  }

  Future<void> refetchAll() async {
    page = 1;
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    ).then((list) {
      pointsFuture = getPointsAPI(transactions: list);
      setState(() {});
      return list;
    });
    pointsFuture = getPointsAPI(transactions: transactionsObj);
    setState(() {});
  }

  Future<void> refetchTransactions({bool showLoading = false}) async {
    page = 1;
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    ).then((list) {
      pointsFuture = getPointsAPI(transactions: list);
      setState(() {});
      return list;
    });
    if (showLoading) transactionsWidgetKey = UniqueKey();
    setState(() {});
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

  List<PointTransactionData> getFilteredTransactions(
      List<PointTransactionData> list) {
    if (tabParam == 'earned' || tabParam == 'earn') {
      return list.where((e) => !e.isDeduction).toList();
    } else if (tabParam == 'used' || tabParam == 'use') {
      return list.where((e) => e.isDeduction).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isHistoryTab = tabController.index == 0;

    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.points,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: RefreshIndicator(
        onRefresh: refetchAll,
        child: SnapHelperWidget<PointData>(
          future: pointsFuture,
          loadingWidget: Column(
            children: const [
              PointsCardShimmer(),
              PointTransactionsShimmer(),
            ],
          ),
          errorWidget: const PointsCardComponent(),
          onSuccess: (points) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Top Membership Card
                SliverToBoxAdapter(
                  child: PointsCardComponent(points: points),
                ),
                // TabBar (History, Earned, Used)
                SliverToBoxAdapter(
                  child: TabBar(
                    controller: tabController,
                    labelStyle: boldTextStyle(size: 14),
                    unselectedLabelStyle: primaryTextStyle(size: 14),
                    tabs: tabTitles.map((e) => Tab(text: e)).toList(),
                  ).paddingSymmetric(horizontal: 8),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Display Expiring Alerts and Bar Chart ONLY on History Tab (Index 0)
                if (isHistoryTab) ...[
                  // Expiring Alerts Section
                  SliverToBoxAdapter(
                    child: ExpiringAlertsComponent(points: points),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  // Earned Points History Bar Chart Section
                  SliverToBoxAdapter(
                    child: EarnedPointsChartComponent(
                      history: points.earnedPointsHistory,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],

                // Transactions Header Title
                SliverToBoxAdapter(
                  child: Text(
                    locale.recentTransactions,
                    style: boldTextStyle(size: 15),
                  ).paddingSymmetric(horizontal: 16),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // Transactions List
                SnapHelperWidget<List<PointTransactionData>>(
                  key: transactionsWidgetKey,
                  future: transactionsFuture,
                  loadingWidget: const SliverToBoxAdapter(
                    child: PointTransactionsShimmer(),
                  ),
                  errorBuilder: (error) {
                    return SliverToBoxAdapter(
                      child: NoDataWidget(
                        title: error,
                        retryText: locale.reload,
                        imageWidget: const ErrorStateWidget(),
                        onRetry: refetchTransactions,
                      ).center().paddingAll(16),
                    );
                  },
                  onSuccess: (transactions) {
                    final displayList = getFilteredTransactions(transactions);

                    if (displayList.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(24),
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor: context.cardColor,
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                locale.noTransactionFound,
                                style: secondaryTextStyle(size: 13),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == displayList.length) {
                            loadMoreTransactions();
                            return const SizedBox(height: 20);
                          }
                          final transaction = displayList[index];
                          final valStr = transaction.value.toStringAsFixed(
                            transaction.value.truncateToDouble() ==
                                    transaction.value
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
                                horizontal: 16, vertical: 12),
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
                                          format:
                                              DateFormatConst.BOOK_DATE_FORMAT,
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
                        childCount: displayList.length,
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}
