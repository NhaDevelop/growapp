import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/component/points_card_component.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/screens/points/point_repository.dart';
import 'package:grow_tokyo_app/screens/points/shimmer/point_transactions_shimmer.dart';
import 'package:grow_tokyo_app/screens/points/shimmer/points_card_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

const tabTitles = ['History', 'Earned', 'Used'];
const tabParams = [null, 'earn', 'use'];

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen>
    with SingleTickerProviderStateMixin {
  late final tabController =
      TabController(length: tabTitles.length, vsync: this);
  UniqueKey transactionsWidgetKey = UniqueKey();
  Future<double>? pointsFuture;
  Future<List<PointTransactionData>>? transactionsFuture;
  List<PointTransactionData> transactionsObj = [];
  int page = 1;
  String? tabParam;

  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        tabParam = tabParams[tabController.index];
        refetchTransactions(showLoading: true);
      }
    });
    init();
  }

  Future<void> init() async {
    pointsFuture = getPointsAPI();
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    );
  }

  Future<void> refetchTransactions({bool showLoading = false}) async {
    page = 1;
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      tabParam: tabParam,
      list: transactionsObj,
    );
    if (showLoading) transactionsWidgetKey = UniqueKey();
    setState(() {});
  }

  void loadMoreTransactions() {
    page++;
    transactionsFuture = getPointsTransactionsAPI(
      page: page,
      list: transactionsObj,
    );
    setState(() {});
  }

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
          SnapHelperWidget(
            future: pointsFuture,
            loadingWidget: const PointsCardShimmer(),
            errorWidget: const PointsCardComponent(),
            onSuccess: (points) => PointsCardComponent(points: points),
          ),
          TabBar(
            controller: tabController,
            tabs: tabTitles.map((e) => Tab(text: e)).toList(),
          ),
          SnapHelperWidget(
              key: transactionsWidgetKey,
              future: transactionsFuture,
              loadingWidget: const PointTransactionsShimmer(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: refetchTransactions,
                ).center();
              },
              onSuccess: (transactions) {
                return AnimatedListView(
                  itemCount: transactions.length,
                  onNextPage: loadMoreTransactions,
                  onSwipeRefresh: refetchTransactions,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final transaction = transactions[index];
                    return Container(
                      decoration: boxDecorationDefault(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction.type.capitalizeFirstLetter(),
                                  style: boldTextStyle(size: 14)),
                              4.height,
                              Text(
                                transaction.log,
                                style: secondaryTextStyle(size: 12),
                              ),
                              2.height,
                              Text(
                                formatDate(
                                  transaction.createdAtStr,
                                  format: DateFormatConst.BOOK_DATE_FORMAT,
                                ),
                                style: secondaryTextStyle(size: 12),
                              ),
                            ],
                          ).expand(),
                          16.width,
                          Text(
                            transaction.value > 0
                                ? '+${transaction.value}'
                                : transaction.value.toString(),
                            style: boldTextStyle(
                              color: transaction.value > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).expand(),
        ],
      ),
    );
  }
}
