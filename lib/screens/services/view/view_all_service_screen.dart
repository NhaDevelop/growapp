import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frezka/components/app_scaffold.dart';
import 'package:frezka/components/common_bottom_price_widget.dart';
import 'package:frezka/components/view_all_label_component.dart';
import 'package:frezka/main.dart';
import 'package:frezka/screens/booking/view/booking_screen.dart';
import 'package:frezka/screens/dashboard/component/common_app_component.dart';
import 'package:frezka/screens/dashboard/component/dashboard_appbar_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/back_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../utils/common_base.dart';
import '../../category/category_repository.dart';
import '../../category/component/category_item_component.dart';
import '../../category/model/category_response.dart';
import '../component/services_info_list_component.dart';
import '../models/service_response.dart';
import '../service_repository.dart';
import '../shimmer/view_all_service_shimmer.dart';

class ViewAllServiceScreen extends StatefulWidget {
  final String serviceTitle;
  final String search;
  final int? categoryId;

  ViewAllServiceScreen({required this.serviceTitle, this.categoryId, this.search = ""});

  @override
  _ViewAllServiceScreenState createState() => _ViewAllServiceScreenState();
}

class _ViewAllServiceScreenState extends State<ViewAllServiceScreen> {
  TextEditingController searchServiceCont = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  Future<List<CategoryData>>? futureCategory;
  List<CategoryData> categoryList = [];

  Future<List<ServiceListData>>? futureService;
  List<ServiceListData> serviceListObj = [];

  int page = 1;

  int? subCategoryId;
  int selectedSubCategoryIndex = -1;

  List<ServiceListData> selectedService = [];

  bool isLastPage = false;
  bool isSubCategorySelected = false;

  @override
  void initState() {
    super.initState();

    if (widget.search.isNotEmpty) {
      searchServiceCont.text = widget.search;
    }
    init();
  }

  void init() async {
    fetchAllServiceData();

    if (widget.categoryId != null) {
      fetchCategoryList();
    }
  }

  void fetchCategoryList({bool flag = false}) async {
    futureCategory = getCategoryList(categoryId: widget.categoryId, list: categoryList);
    if (flag) setState(() {});
  }

  void fetchAllServiceData({bool flag = false, bool isClear = false}) async {
    if (isClear) {
      selectedService.clear();
      bookingRequestStore.setSelectedServiceListInRequest(selectedService);
    }

    futureService = getServiceList(
      branchId: appStore.branchId,
      categoryId: subCategoryId != null ? '' : (widget.categoryId.validate() != 0 ? widget.categoryId!.toString() : ''),
      subCategoryId: subCategoryId != null ? subCategoryId.validate().toString() : '',
      page: page,
      search: searchServiceCont.text,
      list: serviceListObj,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    );

    if (flag) setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    selectedService.clear();
    bookingRequestStore.setSelectedServiceListInRequest(selectedService);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CommonAppComponent(
            innerWidget: DashboardAppBarComponent(
              hintText: '${locale.searchFor} ${widget.serviceTitle.validate()}',
              positionWidget: AppTextField(
                textFieldType: TextFieldType.OTHER,
                focus: myFocusNode,
                controller: searchServiceCont,
                suffix: CloseButton(
                  onPressed: () {
                    page = 1;
                    searchServiceCont.clear();

                    appStore.setLoading(true);
                    fetchAllServiceData(flag: true);
                  },
                ).visible(searchServiceCont.text.isNotEmpty),
                onFieldSubmitted: (s) {
                  page = 1;

                  appStore.setLoading(true);

                  fetchAllServiceData(flag: true);
                },
                decoration: inputDecoration(
                  context,
                  hint: locale.searchForServices,
                  prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal),
                ),
              ),
              innerChild: appBarWidget(
                widget.serviceTitle.validate(),
                center: true,
                color: context.primaryColor,
                textColor: white,
                backWidget: BackWidget(),
              ).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20).paddingTop(10),
            ),
            mainWidgetHeight: 135,
            onSwipeRefresh: () {
              page = 1;

              appStore.setLoading(true);
              selectedService.clear();
              bookingRequestStore.setSelectedServiceListInRequest(selectedService);
              fetchAllServiceData(isClear: true, flag: true);

              return Future.value(false);
            },
            onNextPage: () {
              if (!isLastPage) {
                page++;

                appStore.setLoading(true);
                fetchAllServiceData(flag: true);
              }
            },
            subWidget: AnimatedScrollView(
              padding: EdgeInsets.only(top: 25, bottom: 80),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Subcategory List Api
                if (widget.categoryId != null)
                  SnapHelperWidget<List<CategoryData>>(
                    future: futureCategory,
                    loadingWidget: ViewAllServiceShimmer(),
                    onSuccess: (list) {
                      if (list.isEmpty) return Offstage();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.height,
                          ViewAllLabel(
                            label: locale.subCategories,
                            trailingText: locale.clear,
                            isShowAll: isSubCategorySelected,
                            onTap: () {
                              selectedSubCategoryIndex = -1;
                              isSubCategorySelected = false;

                              subCategoryId = null;

                              appStore.setLoading(true);
                              fetchAllServiceData(flag: true);

                              setState(() {});
                            },
                          ).paddingLeft(16),
                          HorizontalList(
                            runSpacing: 16,
                            spacing: 16,
                            itemCount: list.length,
                            padding: EdgeInsets.only(left: 16, right: 16, top: isSubCategorySelected ? 0 : 8),
                            itemBuilder: (_, i) {
                              CategoryData data = list[i];

                              return GestureDetector(
                                onTap: () {
                                  selectedSubCategoryIndex = i;
                                  subCategoryId = data.id;
                                  isSubCategorySelected = true;

                                  page = 1;

                                  appStore.setLoading(true);
                                  fetchAllServiceData();

                                  setState(() {});
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CategoryItemWidget(categoryData: data, width: context.width() / 3 - 20),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: boxDecorationDefault(color: context.primaryColor),
                                        child: Icon(Icons.done, size: 16, color: Colors.white),
                                      ).cornerRadiusWithClipRRect(16).visible(selectedSubCategoryIndex == i),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),

                /// Service List Api
                SnapHelperWidget<List<ServiceListData>>(
                  future: futureService,
                  loadingWidget: Offstage(),
                  errorBuilder: (error) {
                    return NoDataWidget(
                      title: error,
                      retryText: locale.reload,
                      imageWidget: ErrorStateWidget(),
                      onRetry: () {
                        page = 1;
                        appStore.setLoading(true);

                        fetchAllServiceData(flag: true);
                      },
                    ).paddingTop(120).center();
                  },
                  onSuccess: (servicesInfoListData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.height,
                        Text(locale.services, style: boldTextStyle()),
                        16.height,
                        AnimatedListView(
                          itemCount: servicesInfoListData.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          emptyWidget: NoDataWidget(
                            title: locale.noServicesFound,
                            imageWidget: EmptyStateWidget(),
                          ).paddingTop(searchServiceCont.text.isNotEmpty ? 0 : 120),
                          itemBuilder: (context, index) {
                            ServiceListData serviceData = servicesInfoListData[index];
                            serviceData.isServiceChecked = bookingRequestStore.selectedServiceList.any((element) => element.id.validate() == serviceData.id.validate());

                            return ServicesInfoListComponent(
                              serviceInfo: serviceData,
                              onPressed: () {
                                serviceData.isServiceChecked = !serviceData.isServiceChecked;

                                if (serviceData.isServiceChecked) {
                                  selectedService.add(serviceData);
                                } else {
                                  selectedService.removeWhere((element) => element.id.validate() == serviceData.id.validate());
                                }

                                bookingRequestStore.setSelectedServiceListInRequest(selectedService);

                                setState(() {});
                              },
                            );
                          },
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (context) => CommonBottomPriceWidget(
                buttonText: locale.bookNow,
                title: bookingRequestStore.selectedServiceList.map((e) => e.name.validate()).toList().join(', '),
                price: bookingRequestStore.totalAmount,
                onTap: () {
                  hideKeyboard(context);

                  BookingScreen(services: selectedService).launch(context);
                },
              ).visible(selectedService.isNotEmpty),
            ),
          ),
        ],
      ),
    );
  }
}
