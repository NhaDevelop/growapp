import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/back_widget.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/common_app_component.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/dashboard_appbar_component.dart';
import 'package:grow_tokyo_app/screens/referral/component/referral_code_details.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_data.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_transactions_response.dart';
import 'package:grow_tokyo_app/screens/referral/referral_repository.dart';
import 'package:grow_tokyo_app/screens/referral/shimmer/referral_code_details_shimmer.dart';
import 'package:grow_tokyo_app/screens/referral/shimmer/referral_transactions_shimmer.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  Future<ReferralData>? codeFuture;
  Future<List<ReferralTransactionData>>? transactionsFuture;
  List<ReferralTransactionData> transactionObj = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    codeFuture = getReferralCodeAPI();
    transactionsFuture =
        getReferralTransactionsAPI(page: page, list: transactionObj);
  }

  void refetchTransactions() {
    transactionsFuture = getReferralTransactionsAPI(
      page: page,
      list: transactionObj,
    );
    setState(() {});
  }

  void fetchMoreTransactions() {
    page++;
    transactionsFuture = getReferralTransactionsAPI(
      page: page,
      list: transactionObj,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: CommonAppComponent(
        innerWidget: DashboardAppBarComponent(
          innerChild: appBarWidget(
            locale.referral,
            center: true,
            color: context.primaryColor,
            textColor: white,
            backWidget: const BackWidget(),
          ),
        ),
        subWidget: Transform.translate(
          offset: const Offset(0, -20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SnapHelperWidget(
                future: codeFuture,
                initialData: referralDataCached,
                loadingWidget: const ReferralCodeDetailsShimmer(),
                errorWidget: const ReferralCodeDetails(),
                onSuccess: (data) => ReferralCodeDetails(data: data),
              ),
              24.height,
              Text(locale.rewardHistory, style: boldTextStyle())
                  .paddingSymmetric(horizontal: 16),
              8.height,
              SnapHelperWidget(
                future: transactionsFuture,
                loadingWidget: const ReferralTransactionsShimmer(),
                errorBuilder: (error) {
                  return NoDataWidget(
                    title: error,
                    retryText: locale.reload,
                    imageWidget: const ErrorStateWidget(),
                    onRetry: refetchTransactions,
                  ).paddingTop(100).center();
                },
                onSuccess: (transactions) {
                  if (transactions.isEmpty) {
                    return NoDataWidget(
                      title: locale.noTransactionFound,
                      imageWidget: const EmptyStateWidget(),
                    ).paddingTop(100).center();
                  }

                  return AnimatedListView(
                    itemCount: transactions.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final transaction = transactions[index];
                      return SettingItemWidget(
                        title: transaction.log,
                        subTitle: formatDate(
                          transaction.createdAt.toString(),
                          format: DateFormatConst.BOOK_DATE_FORMAT,
                        ),
                        leading: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF27AE60),
                          child: Icon(Icons.check, color: white, size: 18),
                        ),
                        trailing: Text(
                          '+${transaction.value}',
                          style: boldTextStyle(
                              color: const Color(0xFF27AE60), size: 14),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        onSwipeRefresh: () async {
          page = 1;
          init();
          setState(() {});
        },
        onNextPage: fetchMoreTransactions,
      ),
    );
  }
}
