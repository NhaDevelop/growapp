import '../configs.dart';
import 'languages.dart';

class LanguageAr extends BaseLanguage {
  @override
  String get tokenExpired => 'انتهت صلاحية الرمز';

  @override
  String get badRequest => '400 طلب سىء';

  @override
  String get forbidden => '403 ممنوع';

  @override
  String get pageNotFound => '404: الصفحة لم يتم العثور عليها';

  @override
  String get tooManyRequests => '429: الكثير من الطلبات';

  @override
  String get internalServerError => '500: خطأ الخادم الداخلي';

  @override
  String get badGateway => '502 مدخل غير صالح';

  @override
  String get serviceUnavailable => '503 الخدمة غير متوفرة';

  @override
  String get gatewayTimeout => 'البوابة 504 انتهى الزمن';

  @override
  String get hey => 'يا';

  @override
  String get helloUser => 'مرحبا المستخدم!';

  @override
  String get createYourAccountFor => 'قم بإنشاء حسابك لتجربة أفضل';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get email => 'بريد إلكتروني';

  @override
  String get thisFieldIsRequired => 'هذه الخانة مطلوبه';

  @override
  String get contactNumber => 'رقم الاتصال';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signUp => 'اشتراك';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب؟';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get youHaveBeenMissed => 'لقد فاتتك لفترة طويلة';

  @override
  String get rememberMe => 'تذكرنى';

  @override
  String get forgotPassword => 'هل نسيت كلمة السر؟';

  @override
  String get registerNow => 'سجل الان';

  @override
  String get or => 'أو';

  @override
  String get pleaseEnterValidOtp => 'الرجاء إدخال OTP صالح';

  @override
  String get otpVerification => 'التحقق من OTP';

  @override
  String get checkYourMailAnd => 'تحقق من بريدك وأدخل الرمز الذي تحصل عليه';

  @override
  String get didNotGetTheOtp => 'لم تحصل على OTP؟';

  @override
  String get resendOtp => 'إعادة إرسال OTP';

  @override
  String get verify => 'يؤكد';

  @override
  String get enterYourEmailAddress => 'أدخل عنوان بريدك الالكتروني';

  @override
  String get aResetPasswordLink => 'سيتم إرسال رابط كلمة مرور إعادة تعيين إلى عنوان البريد الإلكتروني الذي تم إدخاله أعلاه';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get areYouSureWantToPerformThisAction => 'هل أنت متأكد من أن تنفيذ هذا الإجراء؟';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get gallery => 'صالة عرض';

  @override
  String get camera => 'آلة تصوير';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get update => 'تحديث';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get newPasswordsMustBeDifferent => 'يجب أن تكون كلمات المرور الجديدة مختلفة عن تلك السابقة';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get thePasswordDoesNotMatch => 'كلمة المرور لا تتطابق';

  @override
  String get reEnterPassword => 'إعادة إدخال كلمة المرور';

  @override
  String get confirm => 'يتأكد';

  @override
  String get pleaseLoginAgain => 'الرجاد الدخول على الحساب من جديد';

  @override
  String get loginSuccessfully => 'تسجيل الدخول بنجاح';

  @override
  String get noUserFound => 'لم يتم العثور على المستخدم';

  @override
  String get otpInvalidMessage => 'الرمز الذي تم إدخاله غير صالح ، يرجى المحاولة مرة أخرى';

  @override
  String get pleaseContactWithAdmin => 'يرجى الاتصال مع المسؤول';

  @override
  String get confirmOtp => 'تأكيد OTP';

  @override
  String get verified => 'تم التحقق';

  @override
  String get signInFailed => 'فشل تسجيل الدخول';

  @override
  String get appleSigInIsNotAvailable => 'علامة Apple غير متوفرة لجهازك';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'عنوان البريد الإلكتروني مطلوب. يرجى تحديث البريد الإلكتروني في حساب Apple الخاص بك';

  @override
  String get yourPasswordReset => 'إعادة تعيين كلمة المرور الخاصة بك';

  @override
  String get yourAccountIsReady => 'حسابك جاهز للاستخدام. استمتع بأخصائينا وخدماتنا';

  @override
  String get yourPassWorResetSuccessfully => 'إعادة تعيين كلمة المرور الخاصة بك بنجاح!';

  @override
  String get done => 'منتهي';

  @override
  String get specialist => 'متخصص';

  @override
  String get date => 'تاريخ';

  @override
  String get time => 'وقت';

  @override
  String get payment => 'قسط';

  @override
  String get noDetailsFound => 'لم يتم العثور على تفاصيل';

  @override
  String get reload => 'إعادة تحميل';

  @override
  String get locationInformation => 'معلومات الموقع';

  @override
  String get name => 'اسم';

  @override
  String get address => 'عنوان';

  @override
  String get quickBookAppointment => 'موعد للكتاب السريع';

  @override
  String get service => 'خدمة';

  @override
  String get total => 'المجموع';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get pleaseSelectService => 'الرجاء تحديد الخدمة';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get doYouWantToConfirmBooking => 'هل تريد تأكيد هذا الحجز؟';

  @override
  String get paymentDetails => 'بيانات الدفع';

  @override
  String get subtotal => 'نطاق فرعي';

  @override
  String get tip => 'نصيحة';

  @override
  String get discount => 'تخفيض';

  @override
  String get yourReview => 'مراجعتك';

  @override
  String get deleteReview => 'حذف المراجعة';

  @override
  String get doYouWantToDeleteReview => 'هل تريد حذف هذا الاستعراض؟';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get rate => 'معدل';

  @override
  String get paymentMethod => 'طريقة الدفع او السداد';

  @override
  String get goToBookings => 'اذهب إلى الحجوزات';

  @override
  String get yourBookingFor => 'حجزك ل';

  @override
  String get bookingSuccessful => 'حجز ناجح!';

  @override
  String get cashAfterService => 'نقد بعد الخدمة';

  @override
  String get razorpay => 'رازورباي';

  @override
  String get stripe => 'شريط';

  @override
  String get doWantToBookAppointment => 'هل تريد حجز هذا الموعد؟';

  @override
  String get noTimeSlots => 'لا فتحات زمنية';

  @override
  String get availableSlots => 'فتحات متاحة';

  @override
  String get next => 'التالي';

  @override
  String get pleaseSelectTimeSlotFirst => 'الرجاء تحديد الفتحة الزمنية أولاً';

  @override
  String get chooseYourExpert => 'اختر خبيرك';

  @override
  String get pleaseChooseYourExpert => 'الرجاء اختيار خبيرك أولاً';

  @override
  String get services => 'خدمات';

  @override
  String get cancelAppointment => 'إلغاء التعيين';

  @override
  String get doYouWantToCancelBooking => 'هل تريد إلغاء هذا الحجز؟';

  @override
  String get bookingInformation => 'معلومات الحجز';

  @override
  String get status => 'حالة';

  @override
  String get chooseBranch => 'اختر الفرع';

  @override
  String get noBranchFound => 'لم يتم العثور على فرع';

  @override
  String get doYouWantExplore => 'هل تريد استكشاف';

  @override
  String get nearbyBranches => 'الفروع القريبة';

  @override
  String get about => 'عن';

  @override
  String get reviews => 'المراجعات';

  @override
  String get staff => 'طاقم عمل';

  @override
  String get noServicesFound => 'لم يتم العثور على خدمات';

  @override
  String get noReviewsFound => 'لم يتم العثور على مراجعات';

  @override
  String get yourReviewsWillBeAppearedHere => 'ستظهر مراجعاتك هنا';

  @override
  String get call => 'يتصل';

  @override
  String get direction => 'اتجاه';

  @override
  String get noGalleryFound => 'لم يتم العثور على معرض';

  @override
  String get workingHours => 'ساعات العمل';

  @override
  String get ourCategory => 'فئتنا';

  @override
  String get noCategoryFound => 'لم يتم العثور على فئة';

  @override
  String get pressBackAgainToExitApp => 'اضغط مرة أخرى للخروج من التطبيق';

  @override
  String get home => 'بيت';

  @override
  String get booking => 'الحجز';

  @override
  String get notifications => 'إشعارات';

  @override
  String get user => 'مستخدم';

  @override
  String get profile => 'حساب تعريفي';

  @override
  String get setting => 'جلسة';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get theme => 'سمة';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get share => 'يشارك';

  @override
  String get help => 'يساعد';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get tC => 'T & C.';

  @override
  String get logout => 'تسجيل خروج';

  @override
  String get logoutYourAccount => 'سجل حسابك';

  @override
  String get ohNoYouAreLeaving => 'أوه لا ، أنت تغادر!';

  @override
  String get doYouWantToLogout => 'هل ترغب بالخروج؟';

  @override
  String get noNotifications => 'لا إشعارات';

  @override
  String get weLlNotifyYouOnce => 'سنقوم بإبلاغك بمجرد أن يكون لدينا شيء لك';

  @override
  String get searchForServices => 'البحث عن الخدمات';

  @override
  String get searchServices => 'خدمات البحث';

  @override
  String get searchBooking => 'بحث الحجز';

  @override
  String get topExperts => 'كبار الخبراء';

  @override
  String get theUserHasDeniedSpeechRecognition => 'نفى المستخدم استخدام التعرف على الكلام';

  @override
  String get category => 'فئة';

  @override
  String get kms => 'كيلومترات';

  @override
  String get fromYourLocation => 'من موقعك';

  @override
  String get noBookingsFound => 'لم يتم العثور على حجوزات';

  @override
  String get notAMember => 'ليس عضوا؟';

  @override
  String get noStaffFound => 'لم يتم العثور على موظفين';

  @override
  String get contactInfo => 'معلومات الاتصال';

  @override
  String get noReviewsYetFor => 'لا توجد مراجعات حتى الآن';

  @override
  String get language => 'لغة';

  @override
  String get appTheme => 'موضوع التطبيق';

  @override
  String get termsConditions => 'البنود و الظروف';

  @override
  String get app => 'برنامج';

  @override
  String get light => 'ضوء';

  @override
  String get dark => 'مظلم';

  @override
  String get systemDefault => 'النظام الافتراضي';

  @override
  String get chooseTheme => 'اختيار موضوع';

  @override
  String get allServices => 'جميع الخدمات';

  @override
  String get searchFor => 'بحث عن';

  @override
  String get subCategories => 'الفئات الفرعية';

  @override
  String get clear => 'واضح';

  @override
  String get welcomeToThe => 'أهلا بك في';

  @override
  String get salon => 'صالون';

  @override
  String get weProvideYouBestServiceMessage => 'نحن نقدم لك أفضل الخدمات وأفضل';

  @override
  String get userExperience => 'تجربة المستخدم';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get confirmed => 'مؤكد';

  @override
  String get cancelled => 'ألغيت';

  @override
  String get checkIn => 'تحقق في';

  @override
  String get checkOut => 'الدفع';

  @override
  String get completed => 'مكتمل';

  @override
  String get invalidUrl => 'URL غير صالح';

  @override
  String get enterYourReviewOptional => 'أدخل مراجعتك (اختياري)';

  @override
  String get cancel => 'يلغي';

  @override
  String get submit => 'يُقدِّم';

  @override
  String get ratingIsRequired => 'التصنيف مطلوب';

  @override
  String get timeSlotBookedMessage => 'تم حجزه بالفعل! الرجاء اختيار مرة أخرى';

  @override
  String get branchName => 'اسم الفرع';

  @override
  String get place => 'مكان';

  @override
  String get basedOn => 'مرتكز على';

  @override
  String get review => 'مراجعة';

  @override
  String get s => 'س';

  @override
  String get error => 'خطأ:';

  @override
  String get externalWallet => 'محفظة خارجية:';

  @override
  String get userCancelled => 'تم إلغاء المستخدم';

  @override
  String get userNotFound => 'لم يتم العثور على المستخدم';

  @override
  String get dateIsRequired => 'التاريخ مطلوب';

  @override
  String get timeIsRequired => 'الوقت مطلوب';

  @override
  String get findYourNearestSalon => 'ابحث عن أقرب صالون';

  @override
  String get walkThrough1subTitle => 'يمكنك أن تجد بسهولة بالقرب منك أفضل حلاق وصالون والاستمتاع بأفضل تجربة خدمة';

  @override
  String get pickAService => 'اختر خدمة';

  @override
  String get walkThrough2subTitle => 'يمكنك اختيار خدمتك واختيار أخصائيك والحصول على الحجز السريع';

  @override
  String get quickBooking => 'الحجز السريع';

  @override
  String get walkThrough3subTitle => 'تحصل على أفضل الخدمات وأفضل أخصائي لخدماتك';

  @override
  String get skip => 'يتخطى';

  @override
  String get getStarted => 'البدء';

  @override
  String get delete => 'يمسح';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get signInYourAccount => 'تسجيل الدخول في حسابك';

  @override
  String get deleteAccountConfirmation => 'سيتم حذف حسابك بشكل دائم. لن تتم استعادة بياناتك مرة أخرى.';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get helloGuest => 'مرحبا ضيف';

  @override
  String get signInWith => 'تسجيل الدخول ب';

  @override
  String get google => 'جوجل';

  @override
  String get apple => 'تفاحة';

  @override
  String get termsConditionsMessage => 'لقد قرأت إخلاء المسئولية وأتفق على الشروط والأحكام';

  @override
  String get pleaseAcceptTermsAndConditions => 'يرجى قبول الشروط والأحكام';

  @override
  String get description => 'وصف';

  @override
  String get serviceNote => 'ملاحظة الخدمة';

  @override
  String get priceMayBeUpdated => 'قد يتم تحديث السعر';

  @override
  String get optionalDetails => 'التفاصيل الاختيارية';

  @override
  String get reschedule => 'إعادة جدولة';

  @override
  String get priceDetails => 'تفاصيل السعر';

  @override
  String get transactionId => 'رقم المعاملة';

  @override
  String get paymentStatus => 'حالة السداد';

  @override
  String get paid => 'مدفوع';

  @override
  String get goBack => 'عُد';

  @override
  String get noStaffAvailableForBranchMessage => 'لا يوجد موظفون متاحون للخدمة المختارة!';

  @override
  String get tryToChangeYourService => 'حاول تغيير خدمتك';

  @override
  String get pay => 'يدفع';

  @override
  String get open => 'يفتح';

  @override
  String get closed => 'مغلق';

  @override
  String get selectEmployeeFirst => 'حدد الموظف أولاً';

  @override
  String get yourBookingForHairBookingMessage => 'تم حجز حجزك لقطع الشعر بنجاح';

  @override
  String get back => 'خلف';

  @override
  String get taxIncluded => 'شامل الضريبة';

  @override
  String get demoUserCannotBeGrantedForThis => 'لا يمكن منح المستخدم التجريبي لهذا الإجراء';

  @override
  String get payNow => 'ادفع الآن';

  @override
  String get pleaseTryAgain => 'حاول مرة اخرى';

  @override
  String get somethingWentWrong => 'هناك خطأ ما';

  @override
  String get yourInternetIsNotWorking => 'الإنترنت الخاص بك لا يعمل';

  @override
  String get youCannotBookPrevious => 'لا يمكنك حجز فتحات سابقة';

  @override
  String get galleryWillBeAppearedHere => 'سيظهر المعرض هنا';

  @override
  String get goToBookingDetail => 'انتقل إلى تفاصيل الحجز';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'يتم دفع دفعتك بنجاح مع';

  @override
  String get paymentSuccessful => 'الدفع ناجح!';

  @override
  String get edit => 'يحرر';

  @override
  String get bookingTimeSlotChangeMessage => 'هل تريد تغيير الفتحة الزمنية لهذا الحجز؟';

  @override
  String get change => 'يتغير';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get oldPasswordDoesNotMatchMessage => 'كلمة المرور القديمة الخاصة بك غير صحيحة!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'تم تحديث الحجز بنجاح';

  @override
  String get newUpdate => 'تحديث جديد';

  @override
  String get anUpdateToIs => ' يتوفر تحديث إلى $APP_NAME. انتقل إلى المتجر وتنزيل الإصدار الجديد من التطبيق.';

  @override
  String get closeApp => 'أغلق التطبيق';

  @override
  String get paystack => 'PayStack';

  @override
  String get paypal => 'PayPal';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get other => 'آخر';

  @override
  String get gender => 'جنس';

  @override
  String get pleaseSelectTheDateFirst => 'الرجاء تحديد التاريخ أولاً';

  @override
  String get thereAreNoBookings => 'لا توجد حجوزات مدرجة في الوقت الحالي. تتبع حجوزاتك هنا.';

  @override
  String get payWithFlutterwave => 'دفع مع Flutterwave';

  @override
  String get transactionFailed => 'فشل الاجراء';

  @override
  String get transactionCancelled => 'تم إلغاء المعاملة';

  @override
  String get flutterwave => 'Flutterwave';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'هل أنت متأكد أنك تريد إزالة هذا العنصر';

  @override
  String get remove => 'يزيل';

  @override
  String get you => 'أنت';

  @override
  String get veChanged => 'تغيرت';

  @override
  String get quantityTo => 'الكمية ل';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get addNewAddress => 'أضف عنوانًا جديدًا';

  @override
  String get selectCountry => 'حدد الدولة';

  @override
  String get selectState => 'اختر ولايه';

  @override
  String get selectCity => 'اختر مدينة';

  @override
  String get pincode => 'pincode';

  @override
  String get addressLine => 'خط عنوان';

  @override
  String get writeAddressHere => 'اكتب عنوان هنا';

  @override
  String get writeLandmarkHere => 'اكتب المعالم هنا';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get save => 'يحفظ';

  @override
  String get cart => 'عربة التسوق';

  @override
  String get yourCartIsEmpty => 'عربة التسوق فارغة';

  @override
  String get thereAreCurrentlyNoItems => 'لا يوجد حاليا أي عناصر في سلة التسوق الخاصة بك. ابدأ التسوق وإضافة عناصر إلى عربة التسوق الخاصة بك.';

  @override
  String get productPriceDetails => 'تفاصيل سعر المنتج';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String get selectAddress => 'حدد العنوان';

  @override
  String get opps => 'OPPS';

  @override
  String get looksLikeYouHave => 'يبدو أنك لم تضيف أي عنوان حتى الآن.';

  @override
  String get primary => 'أساسي';

  @override
  String get deliverHere => 'تسليم هنا';

  @override
  String get areYouSureYouWantToDelete => 'هل أنت متأكد أنك تريد حذف هذا العنوان';

  @override
  String get addressDeleteSuccessfully => 'العنوان حذف بنجاح';

  @override
  String get weAreNotShipping => 'نحن لا نشحن إلى مدينتك الآن';

  @override
  String get deliveryCharge => 'رسوم التوصيل';

  @override
  String get orders => 'طلبات';

  @override
  String get seeYourOrders => 'انظر أوامرك';

  @override
  String get myAddresses => 'عناويني';

  @override
  String get manageYourAddresses => 'إدارة عناوينك';

  @override
  String get shop => 'محل';

  @override
  String get aboutProduct => 'حول المنتج';

  @override
  String get qty => 'كتي';

  @override
  String get orderDetail => 'تفاصيل الطلب';

  @override
  String get orderDate => 'تاريخ الطلب';

  @override
  String get deliveredOn => 'تم التسليم';

  @override
  String get deliveryStatus => 'حالة التسليم';

  @override
  String get cancelOrder => 'الغاء الطلب';

  @override
  String get doYouWantToCancel => 'هل تريد إلغاء هذا الطلب';

  @override
  String get theOrderHasBeenCancelled => 'تم إلغاء الطلب بنجاح.';

  @override
  String get noOrdersFound => 'لم يتم العثور على أية طلبات';

  @override
  String get thereAreNoOrders => 'لا توجد أوامر مدرجة في الوقت الحالي. تتبع طلباتك هنا.';

  @override
  String get tax => 'ضريبة';

  @override
  String get shippingDetail => 'تفاصيل الشحن';

  @override
  String get alternativeContactNumber => 'رقم الاتصال البديل:';

  @override
  String get addReview => 'إضافة مراجعة';

  @override
  String get thanksYouForReview => 'شكرا لك للمراجعة!';

  @override
  String get selectUpToThreeImages => 'حدد ما يصل إلى ثلاث صور!';

  @override
  String get doYouWantToRemove => 'هل تريد إزالة هذه الصورة';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get customerDetail => 'تفاصيل العميل';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get alternateContactNumber => 'رقم اتصال بديل';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get off => 'عن';

  @override
  String get discountedAmount => 'مبلغ مخفض';

  @override
  String get proceed => 'يتابع';

  @override
  String get productReviews => 'تعليقات المنتج';

  @override
  String get thanksForVoting => 'شكرا للتصويت';

  @override
  String get bestSellerProduct => 'أفضل بائع المنتج';

  @override
  String get dealsForYou => 'صفقات لك';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get featured => 'متميز';

  @override
  String get readMore => 'اقرأ أكثر';

  @override
  String get readLess => 'أقرأ أقل';

  @override
  String get brand => 'ماركة';

  @override
  String get inclusiveOfAllTaxes => 'شاملة لجميع الضرائب';

  @override
  String get outOfStock => 'إنتهى من المخزن';

  @override
  String get productSize => 'حجم المنتج';

  @override
  String get quantity => 'كمية';

  @override
  String get noRatingsYet => 'لا يوجد تقييم';

  @override
  String get ratingAndReviews => 'التقييم والمراجعات';

  @override
  String get totalReviewsAndRatings => 'إجمالي المراجعات والتقييمات';

  @override
  String get ourMostLoveChewTreats => 'يعاملنا مضغنا الأكثر';

  @override
  String get allCategories => 'جميع الفئات';

  @override
  String get thereAreNoCategories => 'لا توجد فئات في الوقت الحالي. تتبع فئاتك هنا.';

  @override
  String get searchForProduct => 'ابحث عن المنتج';

  @override
  String get atThisTimeThere => 'في هذا الوقت ، لا توجد منتجات أو فئات متاحة';

  @override
  String get goToCart => 'اذهب إلى العربة';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get orderSuccessfullyPlaced => 'طلب وضع بنجاح';

  @override
  String get yorOrderHasBeen => 'تم وضع طلب Yor بنجاح';

  @override
  String get goToOrderList => 'انتقل إلى قائمة الطلبات';

  @override
  String get choosePaymentMethod => 'اختر وسيلة الدفع';

  @override
  String get chooseYourConvenientPayment => 'اختر خيار الدفع المناسب الخاص بك.';

  @override
  String get placeOrder => 'مكان الامر';

  @override
  String get confirmOrder => 'أكد الطلب';

  @override
  String get doYouConfirmThisPayment => 'هل تؤكد هذه الدفعة';

  @override
  String get wishlist => 'قائمة الرغبات';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist => 'لا توجد حاليًا أي عناصر في قائمة الأمنيات الخاصة بك. ابدأ في إضافة عناصر تحب حفظها في وقت لاحق.';

  @override
  String get price => 'سعر';

  @override
  String get productBrands => 'العلامات التجارية للمنتجات';

  @override
  String get searchBrand => 'البحث العلامة التجارية';

  @override
  String get more => 'أكثر';

  @override
  String get rating => 'تقييم';

  @override
  String get weight => 'وزن';

  @override
  String get clearFilter => 'مرشح واضح';

  @override
  String get applyFilter => 'تطبيق المرشح';

  @override
  String get orderPlaced => 'تم الطلب';

  @override
  String get processing => 'يعالج';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get unpaid => 'غير مدفوع الأجر';

  @override
  String get parchasedProducts => 'المنتجات المزروعة';

  @override
  String get productAmount => 'المبلغ المنتج';

  @override
  String get filterBy => 'مصنف بواسطة';

  @override
  String get bookingStatus => 'وضع الحجز';

  @override
  String get apply => 'يتقدم';

  @override
  String get searchOrder => 'أمر البحث';
}
