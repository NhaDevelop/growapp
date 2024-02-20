import '../../main.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';

class PaymentData {
  final String? id;
  final String? paymentMethod;
  final String? icon;
  final bool isSelected;

  PaymentData({
    this.id,
    this.paymentMethod,
    this.icon,
    this.isSelected = false,
  });
}

List<PaymentData> getPaymentList({bool includeCash = true}) {
  List<PaymentData> list = [];

  if (includeCash) list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_CASH, icon: ic_payment, paymentMethod: locale.cashAfterService));
  list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_RAZORPAY, icon: razorpay_logo, paymentMethod: locale.razorpay));
  list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_STRIPE, icon: stripe_logo, paymentMethod: locale.stripe));
  list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_PAYSTACK, icon: paystack_logo, paymentMethod: locale.paystack));
  list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_PAYPAL, icon: paypal_logo, paymentMethod: locale.paypal));
  list.add(PaymentData(id: PaymentMethods.PAYMENT_METHOD_FLUTTER_WAVE, icon: flutter_wave_logo, paymentMethod: locale.flutterwave));

  return list;
}
