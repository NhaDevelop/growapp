import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frezka/paymentGateways/services/paypal_service.dart';
import 'package:frezka/store/booking_request_store.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/common_app_dialog.dart';
import '../../../components/common_bottom_price_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../configs.dart';
import '../../../main.dart';
import '../../../paymentGateways/models/payment_list_model.dart';
import '../../../paymentGateways/services/flutter_wave_service.dart';
import '../../../paymentGateways/services/paystack_service.dart';
import '../../../paymentGateways/services/razor_pay_service.dart';
import '../../../paymentGateways/services/stripe_service.dart';
import '../../../utils/app_common.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../branch/branch_repository.dart';
import '../model/booking_list_response.dart';

class CompletePaymentScreen extends StatefulWidget {
  final BookingListData booking;

  CompletePaymentScreen(this.booking);

  @override
  CompletePaymentScreenState createState() => CompletePaymentScreenState();
}

class CompletePaymentScreenState extends State<CompletePaymentScreen> {
  TextEditingController tipController = TextEditingController();

  FocusNode tipFocusNode = FocusNode();
  List<PaymentData> payments = getPaymentList(includeCash: false);

  late PaymentData selectedPayment;

  RazorPayService razorPayService = RazorPayService();
  StripeService stripeServices = StripeService();
  PayStackService paystackServices = PayStackService();
  PayPalService payPalServices = PayPalService();
  FlutterWaveService flutterWaveServices = FlutterWaveService();

  String paymentMethod = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    selectedPayment = payments.first;
    appStore.setLoading(true);

    bookingRequestStore.setSelectedServiceListInRequest(widget.booking.serviceList.validate());
    bookingRequestStore.setBookingIdInRequest(widget.booking.id.validate());
    bookingRequestStore.setTaxPercentageInRequest(branchConfigurationCached!.tax.validate());

    getBranchConfiguration(appStore.branchId).then((value) {
      appStore.setLoading(false);
      bookingRequestStore.setTaxPercentageInRequest(value.data!.tax.validate());

      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
//
    });
  }

  Future<void> savePayment() async {
    hideKeyboard(context);
    if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_RAZORPAY) {
      paymentMethod = PaymentMethods.PAYMENT_METHOD_RAZORPAY.capitalizeFirstLetter();
      appStore.setLoading(true);

      razorPayService.init(
        razorKey: RAZORPAY_TEST_KEY,
        totalAmount: bookingRequestStore.totalAmount,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (res) {
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      razorPayService.razorPayCheckout();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_STRIPE) {
      paymentMethod = PaymentMethods.PAYMENT_METHOD_STRIPE.capitalizeFirstLetter();
      appStore.setLoading(true);

      await stripeServices.init(
        stripePaymentPublishKey: STRIPE_TEST_PUBLIC_KEY,
        totalAmount: bookingRequestStore.totalAmount,
        bookingId: bookingRequestStore.bookingId.validate(),
        stripeURL: STRIPE_URL,
        stripePaymentKey: STRIPE_TEST_SECRET_KEY,
        isTest: true,
        discountAmount: 0,
        discountPercentage: 0,
        serviceTip: tipController.text.toDouble(),
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (res) {
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      stripeServices.stripePay().then((value) {
        appStore.setLoading(false);
        //
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_PAYSTACK) {
      paymentMethod = PaymentMethods.PAYMENT_METHOD_PAYSTACK.capitalizeFirstLetter();
      appStore.setLoading(true);

      await paystackServices.init(
        context: context,
        paystackPaymentPublicKey: PAYSTACK_TEST_PUBLIC_KEY,
        totalAmount: bookingRequestStore.totalAmount,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (p0) {
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      paystackServices.checkout();

    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_PAYPAL) {
      paymentMethod = PaymentMethods.PAYMENT_METHOD_PAYPAL.capitalizeFirstLetter();
      appStore.setLoading(true);

      await payPalServices.init(
        context: context,
        isTest: true,
        paypalClientId: PAYPAL_CLIENT_ID,
        secretKey: PAYPAL_TEST_SECRET_KEY,
        totalAmount: bookingRequestStore.totalAmount,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        taxData: bookingRequestStore.taxPercentage.validate(),
        serviceTip: tipController.text.toDouble(),
        onComplete: (p0) {
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);

      payPalServices.paypalCheckOut();
    } else if (selectedPayment.id == PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE) {
      paymentMethod = PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE.capitalizeFirstLetter();
      appStore.setLoading(true);

      flutterWaveServices.checkout(
        flutterWavePublicKey: FLUTTER_WAVE_TEST_PUBLIC_KEY,
        flutterWaveSecretKey: FLUTTER_WAVE_TEST_SECRET_KEY,
        totalAmount: bookingRequestStore.totalAmount,
        bookingId: bookingRequestStore.bookingId.validate(),
        discountAmount: 0,
        discountPercentage: 0,
        isTestMode: true,
        taxData: bookingRequestStore.taxPercentage.validate(),
        onComplete: (p0) {
          showBookingCompleteDialog();
        },
      );

      await 1.seconds.delay;
      appStore.setLoading(false);
    }
  }

  void showBookingCompleteDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => CommonAppDialog(
        title: '${locale.paymentSuccessful}',
        subTitle: '${locale.yourPaymentIsPaidSuccessfullyMessage} $paymentMethod',
        buttonText: locale.goToBookingDetail,
        onTap: () {
          finish(context);
          finish(context, true);
        },
      ),
    );
  }

  @override
  void dispose() {
    bookingRequestStore = BookingRequestStore();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.pay,
        appBarHeight: 60,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewAllLabel(label: locale.paymentMethod, isShowAll: false),
                AnimatedListView(
                  shrinkWrap: true,
                  itemCount: payments.length,
                  listAnimationType: ListAnimationType.None,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.cardColor),
                      margin: EdgeInsets.only(bottom: 16),
                      child: SettingItemWidget(
                        title: payments[index].paymentMethod.validate(),
                        titleTextStyle: boldTextStyle(size: 14),
                        padding: EdgeInsets.only(left: 16, bottom: 10, top: 10, right: 10),
                        leading: CachedImageWidget(url: payments[index].icon.validate(), height: 22, width: 22, fit: BoxFit.contain),
                        radius: radius(),
                        trailing: Radio<PaymentData>(
                          value: payments[index],
                          visualDensity: VisualDensity.compact,
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            selectedPayment = value!;
                            setState(() {});
                          },
                        ),
                        onTap: () {
                          selectedPayment = payments[index];
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
                8.height,
                Text(locale.optionalDetails, style: boldTextStyle()),
                AppTextField(
                  textFieldType: TextFieldType.NUMBER,
                  controller: tipController,
                  focus: tipFocusNode,
                  decoration: inputDecoration(context, label: locale.tip),
                  onChanged: (s) {
                    bookingRequestStore.setTip(s.toInt());
                    setState(() {});
                  },
                ).paddingTop(16),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (_) => CommonBottomPriceWidget(
                title: bookingRequestStore.selectedServiceList.validate().map((e) => e.serviceName.validate()).toList().join(', '),
                price: bookingRequestStore.totalAmount,
                buttonText: locale.confirm,
                onTap: () {
                  doIfLoggedIn(context, () async {
                    savePayment();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
