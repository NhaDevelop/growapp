import 'package:flutter/cupertino.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:frezka/main.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../../configs.dart';
// import '../../../utils/app_common.dart';

class OrderPayStackService {
  late BuildContext ctx;
  // PaystackPlugin paystackPlugin = PaystackPlugin();
  num totalAmount = 0;
  String paystackPublicKey = "";
  String userEmail = "";
  late Function(dynamic) onComplete;

  init({
    required BuildContext context,
    required String paystackPaymentPublicKey,
    required num totalAmount,
    required Function(dynamic) onComplete,
  }) {
    // paystackPlugin.initialize(publicKey: paystackPaymentPublicKey);
    this.ctx = context;
    this.paystackPublicKey = paystackPaymentPublicKey;
    this.userEmail = productStore.customerEmail;
    this.totalAmount = totalAmount;
    this.onComplete = onComplete;
  }

  Future checkout() async {
    // int price = totalAmount.toInt() * 100;
    // Charge charge = Charge()
    //   ..amount = price
    //   ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
    //   ..email = userEmail
    //   ..currency = await isIqonicProduct ? PAYSTACK_CURRENCY_CODE : '${appStore.currencyCode}';

    // CheckoutResponse response = await paystackPlugin.checkout(
    //   ctx,
    //   method: CheckoutMethod.card,
    //   charge: charge,
    // );

    // log('Response: $response');

    // if (response.status == true) {
    //   log('Response $response');

    //   onComplete.call(response.reference);

    //   log('Payment was successful. Ref: ${response.reference}');
    // } else {
    //   toast(response.message, print: true);
    // }
  }
}
