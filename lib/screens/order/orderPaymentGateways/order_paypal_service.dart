import 'package:flutter/material.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
// import 'package:grow_tokyo_app/configs.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../../main.dart';
// import '../../../utils/app_common.dart';

class OrderPayPalService {
  late BuildContext ctx;
  num totalAmount = 0;
  String payPalClientId = "";
  String secretKey = "";
  bool isTest = false;
  late Function(dynamic) onComplete;

  init({
    required BuildContext context,
    required String paypalClientId,
    required String secretKey,
    required num totalAmount,
    required bool isTest,
    required Function(dynamic) onComplete,
  }) {
    ctx = context;
    payPalClientId = paypalClientId;
    this.secretKey = secretKey;
    this.totalAmount = totalAmount;
    this.isTest = isTest;
    this.onComplete = onComplete;
  }

  Future paypalCheckOut() async {
    // PaypalCheckout(
    //   sandboxMode: isTest,
    //   clientId: payPalClientId,
    //   secretKey: secretKey,
    //   returnURL: "junedr375.github.io/junedr375-payment/",
    //   cancelURL: "junedr375.github.io/junedr375-payment/error.html",
    //   transactions: [
    //     {
    //       "amount": {
    //         "total": totalAmount,
    //         "currency": await isIqonicProduct
    //             ? PAYPAL_CURRENCY_CODE
    //             : '${appStore.currencyCode}',
    //         "details": {
    //           "subtotal": totalAmount,
    //           "shipping": '0',
    //           "shipping_discount": 0
    //         }
    //       },
    //       "description":
    //           "Name: ${userStore.userName} - Email: ${userStore.userEmail}",
    //     }
    //   ],
    //   note: "Contact us for any questions on your order.",
    //   onSuccess: (Map params) async {
    //     log("onSuccess: $params");

    //     onComplete.call(params['data']['id']);
    //   },
    //   onError: (error) {
    //     log("onError: $error");
    //     toast("onError: $error");
    //     Navigator.pop(ctx);
    //   },
    //   onCancel: (params) {
    //     toast('cancelled');
    //   },
    // ).launch(ctx);
  }
}
