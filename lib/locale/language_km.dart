import '../configs.dart';
import 'languages.dart';

class LanguageKm extends BaseLanguage {
  @override
  String get tokenExpired => 'Token បានផុតកំណត់';

  @override
  String get badRequest => '400: សំណើមិនល្អ';

  @override
  String get forbidden => '403: បានហាមឃាត់';

  @override
  String get pageNotFound => '404: រកមិនឃើញគេហទំព័រ';

  @override
  String get tooManyRequests => '429: មានសំណើច្រើនពេក';

  @override
  String get internalServerError => '500: កំហុសក្នុងម៉ាស៊ីនប្រតិបត្តិការ';

  @override
  String get badGateway => '502: ច្រកផ្លូវមិនល្អ';

  @override
  String get serviceUnavailable => '503: សេវាកម្មមិនអាចប្រើបាន';

  @override
  String get gatewayTimeout => '504: ច្រកផ្លូវត្រូវបានផុតកំណត់';

  @override
  String get hey => 'សួរស្តី';

  @override
  String get welcomeToGrowTokyo => 'សូមស្វាគមន៍មកកាន់ growTokyo!';

  @override
  String get createYourAccountFor =>
      'បង្កើតគណនីរបស់អ្នកសម្រាប់បទពិសោធន៍ល្អប្រចាំថ្ងៃ';

  @override
  String get firstName => 'គោត្ដនាម';

  @override
  String get lastName => 'នាមត្រកូល';

  @override
  String get dob => 'ថ្ងៃខែ​ឆ្នាំ​កំណើត';

  @override
  String get email => 'អ៊ីម៉ែល';

  @override
  String get thisFieldIsRequired => 'ចន្លោះ​នេះ​ត្រូវតែ​បំពេញ';

  @override
  String get contactNumber => 'លេខទំនាក់ទំនង';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get signUp => 'ចុះឈ្មោះ';

  @override
  String get alreadyHaveAnAccount => 'តើមានគណនីរួចហើយឬនៅ?';

  @override
  String get signIn => 'ចូល';

  @override
  String get welcomeBack => 'សូមស្វាគមន៍ម្តងទៀត!';

  @override
  String get pleaseLogin => 'សូមចូលដើម្បីចាប់ផ្ដើម';

  @override
  String get rememberMe => 'ចងចាំខ្ញុំ';

  @override
  String get forgotPassword => 'ភ្លេចពាក្យសម្ងាត់?';

  @override
  String get registerNow => 'ចុះឈ្មោះឥឡូវនេះ';

  @override
  String get or => 'ឬ';

  @override
  String get pleaseEnterValidOtp => 'សូមបញ្ចូល OTP ត្រឹមត្រូវ';

  @override
  String get otpVerification => 'ការផ្ទៀងផ្ទាត់ OTP';

  @override
  String get checkYourMailAnd =>
      'ពិនិត្យមើលសំបុត្ររបស់អ្នកហើយបញ្ចូលលេខកូដដែលអ្នកបានទទួលបាន';

  @override
  String get didNotGetTheOtp => 'មិនទាន់បានទទួល OTP?';

  @override
  String get resendOtp => 'ផ្ញើ​ OTP ម្ដងទៀត';

  @override
  String get verify => 'ផ្ទៀងផ្ទាត់';

  @override
  String get enterYourEmailAddress => 'បញ្ចូលអាសយដ្ឋានអ៊ីម៉ែលរបស់អ្នក';

  @override
  String get aResetPasswordLink =>
      'តំណភ្ជាប់ពាក្យសម្ងាត់កំណត់ឡើងវិញនឹងត្រូវបានផ្ញើទៅកាន់អាសយដ្ឋានអ៊ីមែលដែលបានបញ្ចូលខាងលើ';

  @override
  String get resetPassword => 'កំណត់ពាក្យសម្ងាត់ឡើងវិញ';

  @override
  String get areYouSureWantToPerformThisAction =>
      'តើអ្នកប្រាកដថាចង់អនុវត្តសកម្មភាពនេះទេ?';

  @override
  String get yes => 'បាទ/ចាស';

  @override
  String get no => 'ទេ';

  @override
  String get gallery => 'វិចិត្រសាល';

  @override
  String get camera => 'កាមេរ៉ា';

  @override
  String get editProfile => 'កែសម្រួលប្រវត្តិរូប';

  @override
  String get update => 'ធ្វើបច្ចុប្បន្នភាព';

  @override
  String get changePassword => 'ប្តូរពាក្យសម្ងាត់';

  @override
  String get newPasswordsMustBeDifferent =>
      'ពាក្យសម្ងាត់ថ្មីត្រូវតែខុសពីលេខសម្ងាត់ពីមុន';

  @override
  String get oldPassword => 'ពាក្យសម្ងាត់ចាស់';

  @override
  String get newPassword => 'ពាក្យសម្ងាត់ថ្មី';

  @override
  String get thePasswordDoesNotMatch => 'ពាក្យសម្ងាត់មិនត្រូវគ្នា';

  @override
  String get reEnterPassword => 'បញ្ចូលពាក្យសម្ងាត់ម្ដងទៀត';

  @override
  String get confirm => 'បញ្ជាក់';

  @override
  String get pleaseLoginAgain => 'សូមចូលម្តងទៀត';

  @override
  String get loginSuccessfully => 'ចូលដោយជោគជ័យ';

  @override
  String get noUserFound => 'រកមិនឃើញអ្នកប្រើប្រាស់ទេ';

  @override
  String get otpInvalidMessage =>
      'លេខកូដដែលបានបញ្ចូលគឺមិនត្រឹមត្រូវទេ, សូមព្យាយាមម្តងទៀត';

  @override
  String get pleaseContactWithAdmin => 'សូមទាក់ទងជាមួយអ្នកគ្រប់គ្រង';

  @override
  String get confirmOtp => 'បញ្ជាក់ OTP';

  @override
  String get verified => 'បានផ្ទៀងផ្ទាត់';

  @override
  String get signInFailed => 'ចូលបានបរាជ័យ';

  @override
  String get appleSigInIsNotAvailable =>
      'Apple SignIn មិនមានសម្រាប់ឧបកររបស់អ្នកទេ';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount =>
      'អាសយដ្ឋានអ៊ីម៉ែលត្រូវការ។ សូមធ្វើបច្ចុប្បន្នភាពអ៊ីម៉ែលរបស់អ្នកនៅក្នុងគណនី Apple របស់អ្នក';

  @override
  String get yourPasswordReset => 'កំណត់ពាក្យសម្ងាត់របស់អ្នកឡើងវិញ';

  @override
  String get yourAccountIsReady =>
      'គណនីរបស់អ្នករួចរាល់ក្នុងការប្រើប្រាស់។ សូមរីករាយជាមួយអ្នកឯកទេស និងសេវាកម្មរបស់យើង។';

  @override
  String get yourPassWorResetSuccessfully =>
      'កំណត់ពាក្យសម្ងាត់របស់អ្នកឡើងវិញដោយជោគជ័យ';

  @override
  String get done => 'បានរួចរាល់';

  @override
  String get specialist => 'អ្នកឯកទេស';

  @override
  String get date => 'កាលបរិច្ឆេទ';

  @override
  String get time => 'ម៉ោង';

  @override
  String get payment => 'ការបង់ប្រាក់';

  @override
  String get noDetailsFound => 'រកមិនឃើញព័ត៌មាន';

  @override
  String get reload => 'ទាញយកឡើងវិញ';

  @override
  String get locationInformation => 'ព័ត៌មានទីតាំង';

  @override
  String get name => 'ឈ្មោះ';

  @override
  String get address => 'អាស័យដ្ឋាន';

  @override
  String get bookAppointment => 'កក់ការណាត់ជួប';

  @override
  String get points => 'ពិន្ទុ';

  @override
  String get noTransactionFound => 'រកមិនឃើញប្រតិបត្តិការ';

  @override
  String usingXPoints(String x) => 'ប្រើប្រាស់ពិន្ទុ $x';

  @override
  String youWillSave$X(String x) => 'អ្នកនឹងរក្សាទុក $x';

  @override
  String get membershipPoints => 'ពិន្ទុសមាជិកភាព';

  @override
  String equivalentToX(String x) => 'ស្មើនឹង $x';

  @override
  String get referral => 'យោង';

  @override
  String get referralDiscount => 'ការបញ្ចុះតម្លៃយោង';

  @override
  String get referralCode => 'លេខកូដយោង';

  @override
  String get yourReferralCode => 'លេខកូដយោងរបស់អ្នក';

  @override
  String shareReferralCode(code, downloadUrl, discountPercentage) =>
      'ពិនិត្យមើលកម្មវិធីស្វែងរកនេះ។ វាបានធ្វើឲ្យការកក់កាតកាតល្បីល្បានជាងមុនហើយ! ទាញយកវានៅទីនេះ $downloadUrl និងប្រើលេខកូដរបស់ខ្ញុំ $code ដើម្បីទទួលបានបញ្ចុះតម្លៃ $discountPercentage%។';

  @override
  String get rewardHistory => 'ប្រវត្តិរង្វាន់';

  @override
  String get copyCode => 'ចម្លងកូដ';

  @override
  String get copiedToClipboard => 'បានចម្លងទៅក្ដារតម្បៀតខ្ទាស់';

  @override
  String get referralRewardMessage => 'អញ្ជើញអតិថិជនថ្មីដើម្បីទទួលបានពិន្ទុ';

  @override
  String get howItWorks => 'តើវា​ដំណើរការដូចម្តេច?';

  @override
  String get referralStep1 => 'ចែករំលែកលេខកូដណែនាំរបស់អ្នកទៅមិត្តរបស់អ្នក។';

  @override
  String get referralStep2 =>
      'មិត្តភ័ក្តិរបស់អ្នកធ្វើការកក់ការណាត់ជួប ហើយប្រើលេខកូដរបស់អ្នក ដើម្បីទទួលបានការបញ្ចុះតម្លៃ។';

  @override
  String get referralStep3 =>
      'បន្ទាប់ពីការកក់របស់មិត្តរបស់អ្នកត្រូវបានបញ្ចប់ អ្នកនឹងទទួលបានពិន្ទុជារង្វាន់។';

  @override
  String get referralStepNote =>
      'លេខកូដយោងអាចប្រើបានតែម្តងប៉ុណ្ណោះក្នុងមនុស្សម្នាក់';

  @override
  String get addReferralCode => 'បន្ថែមលេខកូដយោង';

  @override
  String get coupon => 'គូប៉ុង';

  @override
  String get couponDiscount => 'បញ្ចុះតម្លៃគូប៉ុង';

  @override
  String get validUntil => 'មាន​សុពលភាព​ដល់';

  @override
  String get addCoupon => 'បន្ថែមគូប៉ុង';

  @override
  String get fbEcSite => 'គេហទំព័រ FB EC';

  @override
  String get inquiry => 'ការសាកសួរ';

  @override
  String get inquiryMessage => 'សូមជ្រើសរើសកម្មវិធីដែលអ្នកចង់ជជែកមួយជាមួយយើង។';

  @override
  String get telegram => 'Telegram';

  @override
  String get messenger => 'Messenger';

  @override
  String get blog => 'ម៉ាក';

  @override
  String get service => 'សេវាកម្ម';

  @override
  String get total => 'សរុប';

  @override
  String get bookNow => 'កក់ឥឡូវនេះ';

  @override
  String get pleaseSelectService => 'សូមជ្រើសរើសសេវាកម្ម';

  @override
  String get confirmBooking => 'បញ្ជាក់ការកក់';

  @override
  String get doYouWantToConfirmBooking => 'តើអ្នកចង់បញ្ជាក់ការកក់នេះមែនដែរឬទេ?';

  @override
  String get yourInformation => 'ព័ត៌មានរបស់អ្នក';

  @override
  String get timeSlot => 'ពេលវេលា';

  @override
  String get stylist => 'ការរៀបចំ';

  @override
  String get addCode => 'បន្ថែមកូដ';

  @override
  String get paymentDetails => 'ព័ត៌មានលម្អិតអំពីការទូទាត់ប្រាក់';

  @override
  String get payAtSalon => 'បង់ប្រាក់នៅសាឡន';

  @override
  String get subtotal => 'សរុបរង';

  @override
  String get tip => 'ព័ត៌មានជំនួយ';

  @override
  String get discount => 'បញ្ចុះតម្លៃ';

  @override
  String get discountCode => 'កូដបញ្ចុះតម្លៃ';

  @override
  String get yourReview => 'ការពិនិត្យរបស់អ្នក';

  @override
  String get deleteReview => 'លុបការពិនិត្យឡើងវិញ';

  @override
  String get doYouWantToDeleteReview => 'តើអ្នកចង់លុបការពិនិត្យនេះឬទេ?';

  @override
  String get viewAll => 'មើលទាំងអស់';

  @override
  String get rate => 'វាយតម្លៃ';

  @override
  String get paymentMethod => 'វិធីបង់ប្រាក់';

  @override
  String get goToBookings => 'ចូលទៅកាន់ការកក់';

  @override
  String get bookingSuccessMessage => 'ការកក់របស់អ្នកត្រូវបានកក់ដោយជោគជ័យ';

  @override
  String get bookingSuccessful => 'ការកក់ដោយជោគជ័យ!';

  @override
  String get cashAfterService => 'សាច់ប្រាក់បន្ទាប់ពីសេវាកម្ម';

  @override
  String get razorpay => 'Razorpay';

  @override
  String get stripe => 'Stripe';

  @override
  String get doWantToBookAppointment => 'តើអ្នកចង់កក់ការណាត់ជួបនេះដែរឬទេ?';

  @override
  String get noTimeSlots => 'គ្មានជួរពេលវេលា';

  @override
  String get availableSlots => 'ជួរពេលវេលាដែលអាចប្រើបាន';

  @override
  String get next => 'បន្ទាប់';

  @override
  String get pleaseSelectDateFirst => 'សូមជ្រើសរើសកាលបរិច្ឆេទជាមុន';

  @override
  String get pleaseSelectTimeSlotFirst => 'សូមជ្រើសរើសជួរពេលវេលាជាមុន';

  @override
  String get chooseYourStylist => 'ជ្រើសរើសការរៀបចំរបស់អ្នក';

  @override
  String get viewSchedule => 'មើលកាលវិភាគ';

  @override
  String get pleaseChooseYourStylist => 'សូមជ្រើសរើសការរៀបចំរបស់អ្នកជាមុន';

  @override
  String get services => 'សេវាកម្ម';

  @override
  String get cancelAppointment => 'បោះបង់ការណាត់ជួប';

  @override
  String get doYouWantToCancelBooking => 'តើអ្នកចង់បោះបង់ការកក់នេះដែរឬទេ?';

  @override
  String get bookingInformation => 'ព័ត៌មាននៃការកក់';

  @override
  String get status => 'ស្ថានភាព';

  @override
  String get chooseBranch => 'ជ្រើសរើសសាខា';

  @override
  String get noBranchFound => 'រកមិនឃើញសាខា';

  @override
  String get nearbyBranches => 'សាខាដែលនៅជិត';

  @override
  String get about => 'អំពី';

  @override
  String get socialMedia => 'បណ្តាញសង្គម';

  @override
  String get instagram => 'Instagram';

  @override
  String get facebook => 'Facebook';

  @override
  String get details => 'ព័ត៌មានលម្អិត';

  @override
  String get reviews => 'ការពិនិត្យឡើងវិញ';

  @override
  String get staff => 'បុគ្គលិក';

  @override
  String get noServicesFound => 'រកមិនឃើញសេវាកម្មទេ';

  @override
  String get noReviewsFound => 'រកមិនឃើញការពិនិត្យទេ';

  @override
  String get yourReviewsWillBeAppearedHere =>
      'ការពិនិត្យរបស់អ្នកនឹងត្រូវបានបង្ហាញនៅទីនេះ';

  @override
  String get call => 'ហៅ';

  @override
  String get direction => 'ទិសដៅ';

  @override
  String get noGalleryFound => 'រកមិនឃើញរូបភាព';

  @override
  String get workingHours => 'ម៉ោងធ្វើការ';

  @override
  String get ourCategory => 'ប្រភេទផលិតផលរបស់យើង';

  @override
  String get noCategoryFound => 'រកមិនឃើញប្រភេទផលិតផលរបស់យើងទេ';

  @override
  String get pressBackAgainToExitApp => 'ចុចប៊ូត្រង់ម្ដងទៀតដើម្បីចេញពីកម្មវិធី';

  @override
  String get home => 'ទំព័រដើម';

  @override
  String get myBooking => 'ការកក់របស់ខ្ញុំ';

  @override
  String get notifications => 'ការជូនដំណឹង';

  @override
  String get happyBirthday => 'រីករាយថ្ងៃកំណើត';

  @override
  String get user => 'អ្នកប្រើប្រាស់';

  @override
  String get profile => 'ប្រវត្តិរូប';

  @override
  String get setting => 'ការកំណត់';

  @override
  String get appLanguage => 'ភាសាកម្មវិធី';

  @override
  String get theme => 'ប្រធានបទ';

  @override
  String get aboutApp => 'អំពីកម្មវិធី';

  @override
  String get rateUs => 'វាយតម្លៃយើង';

  @override
  String get share => 'ចែករំលែក';

  @override
  String get help => 'ជំនួយ';

  @override
  String get helpCenter => 'មតិព័ត៌មានជំនួយ';

  @override
  String get privacyPolicy => 'គោលការណ៍​ភាព​ឯកជន';

  @override
  String get tC => 'T&C';

  @override
  String get logout => 'ចាកចេញ';

  @override
  String get logoutYourAccount => 'ចាកចេញពីប្រព័ន្ធរបស់អ្នក';

  @override
  String get ohNoYouAreLeaving => 'អូទេ អ្នកកំពុងចាកចេញ!';

  @override
  String get doYouWantToLogout => 'តើអ្នកចង់ចាកចេញពីប្រព័ន្ធទេ?';

  @override
  String get noNotifications => 'គ្មានការជូនដំណឹង';

  @override
  String get weLlNotifyYouOnce =>
      "យើងនឹងជូនដំណឹងដល់អ្នកនៅពេលដែលយើងមានអ្វីមួយសម្រាប់អ្នក";

  @override
  String get searchForServices => 'ស្វែងរកសេវាកម្ម';

  @override
  String get searchServices => 'ស្វែងរកសេវាកម្ម';

  @override
  String get searchBooking => 'ស្វែងរកការកក់';

  @override
  String get topExperts => 'អ្នកជំនាញកំពូល';

  @override
  String get theUserHasDeniedSpeechRecognition =>
      'អ្នកប្រើប្រាស់បានបដិសេធការប្រើប្រាស់ការសម្គាល់ការនិយាយ';

  @override
  String get category => 'ប្រភេទ';

  @override
  String get kms => 'គីឡូម៉ែត្រ';

  @override
  String get fromYourLocation => 'ចាប់ពីទីតាំងរបស់អ្នក';

  @override
  String get noBookingsFound => 'រកមិនឃើញការកក់';

  @override
  String get notAMember => 'មិនមែនជាសមាជិកទេ?';

  @override
  String get noStaffFound => 'រកមិនឃើញបុគ្គលិក';

  @override
  String get contactInfo => 'ព័ត៌មានទំនាក់ទំនង';

  @override
  String get noReviewsYetFor => 'មិនមានការពិនិត្យទេសម្រាប់';

  @override
  String get language => 'ភាសា';

  @override
  String get appTheme => 'ប្រព័ន្ធកម្មវិធី';

  @override
  String get bySigningUpYouAgreeToOur =>
      'សូមធ្វើការចុះឈ្មោះលោកអ្នកដែលមានន័យថាអ្នកយល់ព្រមលក្ខខណ្ឌរបស់យើង';

  @override
  String get termsConditions => 'លក្ខខណ្ឌនិងលិខិតទំនាក់ទំនង';

  @override
  String get app => 'កម្មវិធី';

  @override
  String get light => 'សូលុយស្តង់ដា';

  @override
  String get dark => 'ងងឹត';

  @override
  String get systemDefault => 'លំនាំដើមប្រព័ន្ធ';

  @override
  String get chooseTheme => 'ជ្រើសរើសប្រធានបទ';

  @override
  String get allServices => 'សេវាកម្មទាំងអស់';

  @override
  String get searchFor => 'ស្វែងរកសេវាកម្ម';

  @override
  String get subCategories => 'ប្រភេទរង';

  @override
  String get clear => 'លុបចោល';

  @override
  String get welcomeToThe => 'ស្វាគមន៍មកកាន់';

  @override
  String get salon => 'សាលណេត';

  @override
  String get weProvideYouBestServiceMessage =>
      'យើងផ្ដល់សេវាកម្មល្អបំផុតសម្រាប់អ្នក';

  @override
  String get userExperience => 'បទពិសោធន៍អ្នកប្រើប្រាស់';

  @override
  String get createAccount => 'បង្កើតគណនី';

  @override
  String get pending => 'កំពុងរង់ចាំ';

  @override
  String get confirmed => 'បានបញ្ជាក់';

  @override
  String get cancelled => 'បោះបង់';

  @override
  String get checkIn => 'ចូលមើល';

  @override
  String get checkOut => 'ចាកចេញ';

  @override
  String get completed => 'បានបញ្ចប់';

  @override
  String get invalidUrl => 'URL មិនត្រឹមត្រូវ';

  @override
  String get enterYourReviewOptional => 'បញ្ចូលការពិនិត្យរបស់អ្នក (ជាក់ស្តែង)';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get submit => 'ដាក់ស្នើ';

  @override
  String get ratingIsRequired => 'ការវាយតម្លៃត្រូវបានទាមទារ';

  @override
  String get timeSlotBookedMessage =>
      'តើបានកក់រួចហើយ! សូមជ្រើសរើសពេលផ្សាយមួយផ្សេងទៀត';

  @override
  String get branchName => 'ឈ្មោះសាខា';

  @override
  String get place => 'ទីតាំង';

  @override
  String get basedOn => 'ផ្អែកលើ';

  @override
  String get review => 'ពិនិត្យ';

  @override
  String get s => 'ក';

  @override
  String get error => 'កំហុស:';

  @override
  String get externalWallet => 'កាបូបបណ្ដាញខាងក្រៅ:';

  @override
  String get userCancelled => 'អ្នកប្រើប្រាស់បានបោះបង់';

  @override
  String get userNotFound => 'រកមិនឃើញអ្នកប្រើប្រាស់';

  @override
  String get dateIsRequired => 'ថ្ងៃត្រូវការ';

  @override
  String get timeIsRequired => 'ម៉ោងត្រូវការ';

  @override
  String get bookAndManageYourBookings => 'កក់និងគ្រប់គ្រងការកក់របស់អ្នក';

  @override
  String get walkThrough1subTitle =>
      'បើកការជូនដំណឹងហើយ យើងនឹងជូនដំណឹងអ្នកពេលដែលការកក់របស់អ្នកមក';

  @override
  String get getCouponForDiscount => 'ទទួលបានកូដប័ណ្ណសម្រាប់ការបញ្ចុះតម្លៃ';

  @override
  String get walkThrough2subTitle =>
      'កុំបាត់ការទិញដើម្បីចុងក្រោយនោះយើងនឹងប្រាប់អ្នកទៅចូលចិត្តលើសេវាកម្មដែលអ្នកពេញចិត្ត';

  @override
  String get earnPointsByCompletingServices => 'រង្វាន់ពិន្ទុដោយបញ្ចប់សេវាកម្ម';

  @override
  String get walkThrough3subTitle =>
      'កម្មវិធីស្មាតហ្វូងចង្អការបញ្ចុះតម្លៃប្រកបដោយពិន្ទុផ្ទាល់ខ្លួន!';

  @override
  String get skip => 'រំលង';

  @override
  String get getStarted => 'ចាប់ផ្ដើម';

  @override
  String get delete => 'លុប';

  @override
  String get deleteAccount => 'លុបគណនី';

  @override
  String get signInYourAccount => 'ចូលគណនីរបស់អ្នក';

  @override
  String get deleteAccountConfirmation =>
      'ទិន្នន័យរបស់អ្នកនឹងមិនអាចត្រឡប់បានវិញបន្ទាប់ពីលុបទំនាក់ទំនងឡើយ!';

  @override
  String get dangerZone => 'តំបន់ភ្លែត្រី';

  @override
  String get helloGuest => 'សួស្តី, ភ្ញៀវ';

  @override
  String get signInWith => 'ចូលជាមួយ';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get termsConditionsMessage =>
      'ខ្ញុំបានអានលក្ខខណ្ឌលការណ៍និងយល់ព្រមលក្ខខណ្ឌ';

  @override
  String get pleaseAcceptTermsAndConditions => 'សូមទទួលយកលក្ខខណ្ឌនិងលក្ខណៈ';

  @override
  String get description => 'ការពិពណ៌នា';

  @override
  String get serviceNote => 'កំណត់ចំណាំសេវាកម្ម (ជាក់ស្តែង)';

  @override
  String get optional => '(ជាក់ស្តែង)';

  @override
  String get priceMayBeUpdated => 'តម្លៃអាចត្រូវបានធ្វើកែប្រែ';

  @override
  String get optionalDetails => 'ព័ត៌មានជាក់ស្តែង';

  @override
  String get reschedule => 'រៀបចំកាលវិភាគឡើងវិញ';

  @override
  String get priceDetails => 'ព័ត៌មានតម្លៃ';

  @override
  String get transactionId => 'លេខសំគាល់ប្រតិបត្តិការ';

  @override
  String get paymentStatus => 'ស្ថានភាពការទូទាត់';

  @override
  String get paid => 'បានបង់ប្រាក់';

  @override
  String get goBack => 'ត្រឡប់ទៅក្រោយ';

  @override
  String get noStaffAvailableForBranchMessage =>
      'មិនមានបុគ្គលិកសម្រាប់សេវាកម្មដែលបានជ្រើសរើសទេ!';

  @override
  String get tryToChangeYourService => 'ព្យាយាមផ្លាស់ប្តូរសេវាកម្មរបស់អ្នក';

  @override
  String get pay => 'បង់ប្រាក់';

  @override
  String get open => 'បានបើក';

  @override
  String get closed => 'បានបិទ';

  @override
  String get selectEmployeeFirst => 'ជ្រើសរើសបុគ្គលិកជាមុន';

  @override
  String get yourBookingForHairBookingMessage =>
      'ការកក់របស់អ្នកសម្រាប់ការកាត់សក់បានកក់ដោយជោគជ័យ';

  @override
  String get back => 'ត្រឡប់ទៅក្រោយ';

  @override
  String get taxIncluded => 'បន្ថែមពន្ធនៅ';

  @override
  String get demoUserCannotBeGrantedForThis =>
      'មិនអាចអនុញ្ញាតឱ្យអ្នកប្រើប្រាស់ប្រព័ន្ធនេះបានទេ';

  @override
  String get payNow => 'បង់ប្រាក់ឥឡូវនេះ';

  @override
  String get pleaseTryAgain => 'សូមព្យាយាមម្តងទៀត';

  @override
  String get somethingWentWrong => 'មានអ្វីមួយមិនប្រក្រតី';

  @override
  String get yourInternetIsNotWorking => 'អ៊ីនធឺណិតរបស់អ្នកមិនដំណើរការ';

  @override
  String get slotUnavailable => 'ចូលទៅកាន់ព័ត៌មានលម្អិតនៃការកក់';

  @override
  String get galleryWillBeAppearedHere =>
      'សញ្ញា​ស​រៃ​រូបថត​នឹង​បង្ហាញ​នៅ​ទីនេះ';

  @override
  String get goToBookingDetail => 'ចូលទៅកាន់ព័ត៌មានការកក់';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage =>
      'ការបង់ប្រាក់របស់អ្នកបានបង់ដោយជោគជ័យដោយ';

  @override
  String get paymentSuccessful => 'ការបង់ប្រាក់បានជោគជ័យ!';

  @override
  String get edit => 'កែប្រែ';

  @override
  String get bookingTimeSlotChangeMessage =>
      'តើអ្នកចង់ផ្លាស់ប្តូររបៀបពេញនៃព័ត៌មានពេញនៃការកក់នេះទេ?';

  @override
  String get change => 'ផ្លាស់ប្តូរ';

  @override
  String get pleaseUpdateYourProfile =>
      'សូមធ្វើបច្ចុប្បន្នភាពប្រវត្តិរូបរបស់អ្នក';

  @override
  String get profileUpdatedSuccessfully =>
      'ប្រវត្តិរូបបានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ';

  @override
  String get oldPasswordDoesNotMatchMessage =>
      "លេខសម្ងាត់ចាស់របស់អ្នកមិនត្រូវគ្នាទេ!";

  @override
  String get bookingSuccessfullyUpdateMessage =>
      'ការកក់បានធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ';

  @override
  String get newUpdate => 'ធាតុថ្មី';

  @override
  String get anUpdateToIs =>
      'មានការធ្វើបច្ចុប្បន្នភាពទៅ $APP_NAME មួយនេះ។ ចូលទៅកាន់ Play Store ហើយទាញយកកំណែថ្មីនៃកម្មវិធី.';

  @override
  String get closeApp => 'បិទកម្មវិធី';

  @override
  String get paystack => 'Paystack';

  @override
  String get paypal => 'Paypal';

  @override
  String get male => 'ប្រុស';

  @override
  String get female => 'ស្រី';

  @override
  String get other => 'ផ្សេងៗ';

  @override
  String get gender => 'ភេទ';

  @override
  String get pleaseSelectTheDateFirst => 'សូមជ្រើសរើសកាលបរិច្ឆេទជាមុន';

  @override
  String get thereAreNoBookings =>
      'ពុំមានការកក់ទេនៅលើបញ្ជីបច្ចុប្បន្នលម្អិតនេះទេ។ បង្កើតការតាមដានការកក់របស់អ្នកនៅទីនេះ។';

  @override
  String get payWithFlutterwave => 'បង់ជាមួយជោគជ័យ';

  @override
  String get transactionFailed => 'ប្រតិបត្តិការបានបរាជ័យ';

  @override
  String get transactionCancelled => 'ប្រតិបត្តិការបានបោះបង់';

  @override
  String get flutterwave => 'Flutterwave';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'តើអ្នកប្រាកដថាអ្នកចង់ដកចេញធាតុនេះទេ';

  @override
  String get remove => 'ដកចេញ';

  @override
  String get you => 'អ្នក';

  @override
  String get veChanged => 'បានផ្លាស់ប្តូរ';

  @override
  String get quantityTo => 'បរិមាណទៅ';

  @override
  String get editAddress => 'កែប្រែអាសយដ្ឋាន';

  @override
  String get addNewAddress => 'បន្ថែមអាសយដ្ឋានថ្មី';

  @override
  String get country => 'ប្រទេស';

  @override
  String get nationality => 'សញ្ជរភាព';

  @override
  String get selectCountry => 'ជ្រើសរើសប្រទេស';

  @override
  String get selectState => 'ជ្រើសរើសរដ្ឋ';

  @override
  String get selectCity => 'ជ្រើសរើសទីក្រុង';

  @override
  String get pincode => 'លេខកូដ';

  @override
  String get addressLine => 'បន្ទាត់អាសយដ្ឋាន';

  @override
  String get writeAddressHere => 'សរសេរអាសយដ្ឋាននៅទីនេះ';

  @override
  String get writeLandmarkHere => 'សរសេរតន្ត្រីនៅទីនេះ';

  @override
  String get saveChanges => 'រក្សាទុកការផ្លាស់ប្ដូរ';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get cart => 'រទេះ';

  @override
  String get yourCartIsEmpty => 'រទេះរបស់អ្នកគឺទទេ';

  @override
  String get thereAreCurrentlyNoItems =>
      'បច្ចុប្បន្នឥវ៉ាន់របស់អ្នកនៅត្រូវការទេ។ ចាប់ផ្តើមទិញនូវឥវ៉ាន់ដោយប៉ុន្មាននេះ។';

  @override
  String get productPriceDetails => 'ព័ត៌មានតម្លៃផលិតផល';

  @override
  String get totalAmount => 'ចំនួនសរុប';

  @override
  String get select => 'ជ្រើសរើស';

  @override
  String get selectAddress => 'ជ្រើសរើសអាសយដ្ឋាន';

  @override
  String get opps => 'អីវិប្បា';

  @override
  String get looksLikeYouHave =>
      'ទាញយកដំណើរការទេនៅពេលបច្ចុប្បន្នអ្នកមានអាសយដ្ឋានទេ.';

  @override
  String get primary => 'ប្រទេសគីឡូ';

  @override
  String get deliverHere => 'បញ្ជូនទីនេះ';

  @override
  String get areYouSureYouWantToDelete =>
      'តើអ្នកប្រាកដថាអ្នកចង់លុបអាសយដ្ឋាននេះឬ';

  @override
  String get addressDeleteSuccessfully => 'អាសយដ្ឋានត្រូវបានលុបដោយជោគជ័យ';

  @override
  String get weAreNotShipping =>
      'យើងមិនផ្ញើផ្ទះទេទេនៅក្នុងទីកន្លែងរបស់អ្នកនេះទេ';

  @override
  String get deliveryCharge => 'ថ្លៃបញ្ជូនទៅផ្ទះ';

  @override
  String get orders => 'បញ្ជា';

  @override
  String get seeYourOrders => 'មើលការបញ្ជារបស់អ្នក';

  @override
  String get myAddresses => 'អាសយដ្ឋាន​របស់​ខ្ញុំ';

  @override
  String get manageYourAddresses => 'គ្រប់គ្រងអាសយដ្ឋានរបស់អ្នក';

  @override
  String get shop => 'ហាង';

  @override
  String get aboutProduct => 'អំពីផលិតផល';

  @override
  String get qty => 'បរិមាណ';

  @override
  String get orderDetail => 'ព័ត៌មានលម្អិតនៃការបញ្ជាទិញ';

  @override
  String get orderDate => 'កាលបរិច្ឆេទបញ្ជាទិញ';

  @override
  String get deliveredOn => 'បានដឹកជញ្ជូននៅ';

  @override
  String get deliveryStatus => 'ស្ថានភាពដឹកជញ្ជូន';

  @override
  String get cancelOrder => 'បោះបង់ការបញ្ជាទិញ';

  @override
  String get doYouWantToCancel => 'តើអ្នកចង់លុបការបញ្ជាទិញនេះមែនទេ';

  @override
  String get theOrderHasBeenCancelled => 'ការបញ្ជាទិញត្រូវបានលុបបានដោយជោគជ័យ';

  @override
  String get noOrdersFound => 'រកមិនឃើញការបញ្ជាទិញទេ';

  @override
  String get thereAreNoOrders =>
      'មិន​មាន​ការ​បញ្ជា​ទិញ​ក្នុង​បញ្ជី​នៅ​ពេល​នេះ​ទេ។ តាមដានការបញ្ជាទិញរបស់អ្នកនៅទីនេះ។';

  @override
  String get tax => 'ពន្ធ';

  @override
  String get shippingDetail => 'ព័ត៌មានអំពីការដឹកជញ្ជូន';

  @override
  String get alternativeContactNumber => 'លេខទំនាក់ទំនងជំនួស:';

  @override
  String get addReview => 'បន្ថែមការពិនិត្យឡើងវិញ';

  @override
  String get thanksYouForReview => 'សូមអរគុណចំពោះការពិនិត្យរបស់អ្នក!';

  @override
  String get selectUpToThreeImages => 'ជ្រើសរើសរូបភាពរហូតដល់បី!';

  @override
  String get doYouWantToRemove => 'តើអ្នកចង់លុបរូបភាពនេះឬទេ';

  @override
  String get addPhoto => 'បន្ថែមរូបភាព';

  @override
  String get customerDetail => 'ព័ត៌មានអតិថិជន';

  @override
  String get fullName => 'ឈ្មោះពេញ';

  @override
  String get alternateContactNumber => 'លេខទំនាក់ទំនងជំនួស';

  @override
  String get orderSummary => 'សង្ខេបបញ្ជាទិញ';

  @override
  String get shippingAddress => 'អាសយដ្ឋានដឹកជញ្ជូន';

  @override
  String get off => 'បញ្ចុះតម្លៃ';

  @override
  String get discountedAmount => 'ចំនួនបញ្ចុះតម្លៃ';

  @override
  String get proceed => 'បន្ត';

  @override
  String get productReviews => 'ការវាយតម្លៃផលិតផល';

  @override
  String get thanksForVoting => 'សូមអរគុណចំពោះការបោះឆ្នោត';

  @override
  String get bestSellerProduct => 'ផលិតផលលក់ដាច់បំផុត';

  @override
  String get dealsForYou => 'ការផ្តល់ជូនសម្រាប់អ្នក';

  @override
  String get noProductsFound => 'រកមិនឃើញផលិតផលទេ';

  @override
  String get featured => 'លក្ខណៈពិសេស';

  @override
  String get readMore => 'អាន​បន្ថែម';

  @override
  String get readLess => 'អានតិចតួច';

  @override
  String get brand => 'ម៉ាក';

  @override
  String get inclusiveOfAllTaxes => 'រួមទាំងពន្ធ';

  @override
  String get outOfStock => 'អស់ពីស្តុក';

  @override
  String get productSize => 'ទំហំផលិតផល';

  @override
  String get quantity => 'បរិមាណ';

  @override
  String get noRatingsYet => 'មិនទាន់បានវាយតម្លៃនៅឡើយ';

  @override
  String get ratingAndReviews => 'ការវាយតម្លៃនិងការពិនិត្យ';

  @override
  String get totalReviewsAndRatings => 'សរុបការពិនិត្យបញ្ជាទិញនិងការវាយតម្លៃ';

  @override
  String get ourMostLoveChewTreats => 'Chew Treats ដែលស្រលាញ់បំផុតរបស់យើង';

  @override
  String get allCategories => 'ប្រភេទទាំងអស់';

  @override
  String get thereAreNoCategories =>
      'ឥឡូវនេះមិនមានប្រភេទទេ។ តាមដានប្រភេទរបស់អ្នកនៅទីនេះ។';

  @override
  String get searchForProduct => 'ស្វែងរកផលិតផល';

  @override
  String get atThisTimeThere => 'នៅពេលនេះមិនមានផលិតផលឬប្រភេទទេ';

  @override
  String get goToCart => 'ទៅក្នុងរទេះ';

  @override
  String get addToCart => 'បន្ថែមទៅរទេះ';

  @override
  String get orderSuccessfullyPlaced => 'បានដាក់បានជោគជ័យ';

  @override
  String get yorOrderHasBeen => 'ការបញ្ជាទិញរបស់អ្នកបានដាក់បានជោគជ័យ';

  @override
  String get goToOrderList => 'ទៅបញ្ជីបញ្ជាទិញ';

  @override
  String get choosePaymentMethod => 'ជ្រើសរើសវិធីសាស្រ្តទូទាត់ប្រាក់';

  @override
  String get chooseYourConvenientPayment =>
      'ជ្រើសរើសជម្រើសបង់ប្រាក់ងាយស្រួលរបស់អ្នក។';

  @override
  String get placeOrder => 'ដាក់បញ្ជាទិញ';

  @override
  String get confirmOrder => 'បញ្ជាទិញបញ្ជាក់';

  @override
  String get doYouConfirmThisPayment => 'តើអ្នកបញ្ជាក់ការបង់ប្រាក់នេះទេ?';

  @override
  String get wishlist => 'បញ្ជីចង់ទិញ';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist =>
      'ឥឡូវនេះមិនមានទំនិញនៅក្នុងបញ្ជីចង់ទិញរបស់អ្នកទេ។ ចាប់ផ្តើមបន្ថែមទំនិញដែលអ្នកស្រឡាញ់ដើម្បីរក្សាទុកពេលក្រោយ។.';

  @override
  String get price => 'តម្លៃ';

  @override
  String get productBrands => 'ម៉ាកផលិតផល';

  @override
  String get searchBrand => 'ស្វែងរកម៉ាក';

  @override
  String get more => 'ច្រើនទៀត';

  @override
  String get rating => 'ការវាយតម្លៃ';

  @override
  String get weight => 'ទម្ងន់';

  @override
  String get clearFilter => 'សម្អាតតម្រង';

  @override
  String get applyFilter => 'ដាក់តម្រង';

  @override
  String get orderPlaced => 'ការដាក់បញ្ជាទិញ';

  @override
  String get processing => 'ដំណើរការ';

  @override
  String get delivered => 'បានដឹកជញ្ជូន';

  @override
  String get unpaid => 'មិនទាន់បានបង់';

  @override
  String get parchasedProducts => 'ផលិតផលដែលបានទិញ';

  @override
  String get productAmount => 'ចំនួនផលិតផល';

  @override
  String get filterBy => 'តម្រងតាម';

  @override
  String get bookingStatus => 'ស្ថានភាពការកក់';

  @override
  String get apply => 'ដាក់តម្រង';

  @override
  String get searchOrder => 'ស្វែងរកការបញ្ជាទិញ';
}
