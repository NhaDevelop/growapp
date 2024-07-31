import '../configs.dart';
import 'languages.dart';

class LanguageEn extends BaseLanguage {
  @override
  String get tokenExpired => 'Token Expired';

  @override
  String get badRequest => '400: Bad Request';

  @override
  String get forbidden => '403: Forbidden';

  @override
  String get pageNotFound => '404: Page Not Found';

  @override
  String get tooManyRequests => '429: Too Many Requests';

  @override
  String get internalServerError => '500: Internal Server Error';

  @override
  String get badGateway => '502: Bad Gateway';

  @override
  String get serviceUnavailable => '503: Service Unavailable';

  @override
  String get gatewayTimeout => '504: Gateway Timeout';

  @override
  String get hey => 'Hey';

  @override
  String get welcomeToGrowTokyo => 'Welcome to growTokyo!';

  @override
  String get createYourAccountFor =>
      'Create Your Account for Better Experience';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get dob => 'Date of Birth';

  @override
  String get email => 'Email';

  @override
  String get thisFieldIsRequired => 'This field is required';

  @override
  String get contactNumber => 'Contact Number';

  @override
  String get password => 'Password';

  @override
  String get signUp => 'Sign Up';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get signIn => 'Sign In';

  @override
  String get guestBookingMessage =>
      'Please sign in to save your booking or continue as a guest.';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get pleaseLogin => 'Please login to begin';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get or => 'OR';

  @override
  String get pleaseEnterValidOtp => 'Please enter Valid OTP';

  @override
  String get otpVerification => 'OTP Verification';

  @override
  String get checkYourMailAnd => 'Check Your Mail and enter the code you get';

  @override
  String get didNotGetTheOtp => 'Didn’t get the OTP?';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get verify => 'Verify';

  @override
  String get enterYourEmailAddress => 'Enter your email address';

  @override
  String get aResetPasswordLink =>
      'A reset password link will be sent to the above entered email address';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get areYouSureWantToPerformThisAction =>
      'Are you sure want to perform this action?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get update => 'Update';

  @override
  String get changePassword => 'Change Password';

  @override
  String get newPasswordsMustBeDifferent =>
      'New passwords must be different from previous ones';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get thePasswordDoesNotMatch => 'The password does not match';

  @override
  String get reEnterPassword => 'Re-enter Password';

  @override
  String get confirm => 'Confirm';

  @override
  String get pleaseLoginAgain => 'Please Login Again';

  @override
  String get loginSuccessfully => 'Login Successfully';

  @override
  String get noUserFound => 'No user found';

  @override
  String get otpInvalidMessage =>
      'The entered code is invalid, please try again';

  @override
  String get pleaseContactWithAdmin => 'Please contact with Admin';

  @override
  String get confirmOtp => 'Confirm OTP';

  @override
  String get verified => 'Verified';

  @override
  String get signInFailed => 'Sign in failed';

  @override
  String get appleSigInIsNotAvailable =>
      'Apple SignIn is not available for your device';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount =>
      'Email address is required. Please update Email in your Apple Account';

  @override
  String get yourPasswordReset => 'Your password reset';

  @override
  String get yourAccountIsReady =>
      'Your account is ready to use. Enjoy our specialist and our services';

  @override
  String get yourPassWorResetSuccessfully => 'Your password reset successfully';

  @override
  String get done => 'Done';

  @override
  String get specialist => 'Specialist';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get payment => 'Payment';

  @override
  String get noDetailsFound => 'No Details Found';

  @override
  String get reload => 'Reload';

  @override
  String get locationInformation => 'Location Information';

  @override
  String get name => 'Name';

  @override
  String get address => 'Address';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get points => 'Points';

  @override
  String get noTransactionFound => 'No Transaction Found';

  @override
  String usingXPoints(String x) => 'Using $x points';

  @override
  String youWillSave$X(String x) => 'You will save $x';

  @override
  String get membershipPoints => 'Membership Points';

  @override
  String equivalentToX(String x) => 'Equivalent to $x';

  @override
  String get referral => 'Referral';

  @override
  String get referralDiscount => 'Referral Discount';

  @override
  String get referralCode => 'Referral Code';

  @override
  String get yourReferralCode => 'Your Referral Code';

  @override
  String shareReferralCode(code, downloadUrl, discountPercentage) =>
      'Check out this awesome app. It has made booking a haircut so much easier! Download it here $downloadUrl and use my code $code to receive $discountPercentage% discount.';

  @override
  String get rewardHistory => 'Reward History';

  @override
  String get copyCode => 'Copy Code';

  @override
  String get copiedToClipboard => 'Copied to Clipboard';

  @override
  String get referralRewardMessage => 'Invite new customers to get points';

  @override
  String get howItWorks => 'How it works?';

  @override
  String get referralStep1 => 'Share your referral code to your friends.';

  @override
  String get referralStep2 =>
      'Your friends booking an appointment and apply your code to receive a discount.';

  @override
  String get referralStep3 =>
      'After your friend\'s booking is completed, you will receive points as a reward.';

  @override
  String get referralStepNote =>
      'Each referral code can only be used once per people.';

  @override
  String get addReferralCode => 'Add Referral Code';

  @override
  String get coupon => 'Coupon';

  @override
  String get couponDiscount => 'Coupon Discount';

  @override
  String get validUntil => 'Valid until';

  @override
  String get addCoupon => 'Add Coupon';

  @override
  String get fbEcSite => 'FB EC Site';

  @override
  String get inquiry => 'Inquiry';

  @override
  String get inquiryMessage =>
      'Please select the app you want to chat with us.';

  @override
  String get telegram => 'Telegram';

  @override
  String get messenger => 'Messenger';

  @override
  String get blog => 'Blog';

  @override
  String get service => 'Service';

  @override
  String get total => 'Total';

  @override
  String get bookNow => 'Book Now';

  @override
  String get pleaseSelectService => 'Please select service';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String get doYouWantToConfirmBooking =>
      'Do you want to confirm this booking?';

  @override
  String get yourInformation => 'Your Information';

  @override
  String get timeSlot => 'Time Slot';

  @override
  String get stylist => 'Stylist';

  @override
  String get addCode => 'Add Code';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get payAtSalon => 'Pay at Salon';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tip => 'Tip';

  @override
  String get discount => 'Discount';

  @override
  String get discountCode => 'Discount Code';

  @override
  String get yourReview => 'Your Review';

  @override
  String get deleteReview => 'Delete Review';

  @override
  String get doYouWantToDeleteReview => 'Do you want to delete this review?';

  @override
  String get viewAll => 'View All';

  @override
  String get rate => 'Rate';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get goToBookings => 'Go to Bookings';

  @override
  String get bookingSuccessMessage =>
      'Your booking has been successfully booked';

  @override
  String get bookingSuccessful => 'Booking Successful!';

  @override
  String get cashAfterService => 'Cash After Service';

  @override
  String get razorpay => 'Razorpay';

  @override
  String get stripe => 'Stripe';

  @override
  String get doWantToBookAppointment => 'Do want to book this appointment?';

  @override
  String get noTimeSlots => 'No Time Slots';

  @override
  String get availableSlots => 'Available Slots';

  @override
  String get next => 'Next';

  @override
  String get pleaseSelectDateFirst => 'Please Select Date First';

  @override
  String get pleaseSelectTimeSlotFirst => 'Please Select Time Slot First';

  @override
  String get chooseYourStylist => 'Choose Your Stylist';

  @override
  String get viewSchedule => 'View Schedule';

  @override
  String get pleaseChooseYourStylist => 'Please Choose Your Stylist First';

  @override
  String get services => 'Services';

  @override
  String get cancelAppointment => 'Cancel Appointment';

  @override
  String get doYouWantToCancelBooking => 'Do you want to cancel this booking?';

  @override
  String get bookingInformation => 'Booking Information';

  @override
  String get status => 'Status';

  @override
  String get chooseBranch => 'Choose Branch';

  @override
  String get noBranchFound => 'No Branch Found';

  @override
  String get nearbyBranches => 'Nearby Branches';

  @override
  String get about => 'About';

  @override
  String get socialMedia => 'Social Media';

  @override
  String get instagram => 'Instagram';

  @override
  String get facebook => 'Facebook';

  @override
  String get details => 'Details';

  @override
  String get reviews => 'Reviews';

  @override
  String get staff => 'Staff';

  @override
  String get noServicesFound => 'No Services Found';

  @override
  String get noReviewsFound => 'No Reviews Found';

  @override
  String get yourReviewsWillBeAppearedHere =>
      'Your reviews will be appeared here';

  @override
  String get call => 'Call';

  @override
  String get direction => 'Direction';

  @override
  String get noGalleryFound => 'No Gallery Found';

  @override
  String get workingHours => 'Working Hours';

  @override
  String get ourCategory => 'Our Category';

  @override
  String get noCategoryFound => 'No Category Found';

  @override
  String get pressBackAgainToExitApp => 'Press back again to exit app';

  @override
  String get home => 'Home';

  @override
  String get myBooking => 'My Booking';

  @override
  String get notifications => 'Notifications';

  @override
  String get happyBirthday => 'Happy Birthday';

  @override
  String get user => 'User';

  @override
  String get profile => 'Profile';

  @override
  String get setting => 'Setting';

  @override
  String get appLanguage => 'App Language';

  @override
  String get theme => 'Theme';

  @override
  String get aboutApp => 'About App';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get share => 'Share';

  @override
  String get help => 'Help';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get tC => 'T&C';

  @override
  String get logout => 'Logout';

  @override
  String get logoutYourAccount => 'Logout your account';

  @override
  String get ohNoYouAreLeaving => 'Oh No, You Are Leaving!';

  @override
  String get doYouWantToLogout => 'Do you want to logout?';

  @override
  String get noNotifications => 'No Notifications';

  @override
  String get weLlNotifyYouOnce =>
      "We'll notify you once we have something for you";

  @override
  String get searchForServices => 'Search For Services';

  @override
  String get searchServices => 'Search Services';

  @override
  String get searchBooking => 'Search Booking';

  @override
  String get topExperts => 'Top Experts';

  @override
  String get theUserHasDeniedSpeechRecognition =>
      'The user has denied the use of speech recognition';

  @override
  String get category => 'Category';

  @override
  String get kms => 'KMs';

  @override
  String get fromYourLocation => 'From Your Location';

  @override
  String get noBookingsFound => 'No Bookings Found';

  @override
  String get notAMember => 'Not a member?';

  @override
  String get noStaffFound => 'No Staff Found';

  @override
  String get contactInfo => 'Contact Info';

  @override
  String get noReviewsYetFor => 'No reviews yet for';

  @override
  String get language => 'Language';

  @override
  String get appTheme => 'App Theme';

  @override
  String get bySigningUpYouAgreeToOur => 'By signing up you agree to our';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get app => 'App';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get systemDefault => 'System Default';

  @override
  String get chooseTheme => 'Choose Theme';

  @override
  String get allServices => 'All Services';

  @override
  String get searchFor => 'Search for';

  @override
  String get subCategories => 'Sub Categories';

  @override
  String get clear => 'Clear';

  @override
  String get welcomeToThe => 'Welcome to the';

  @override
  String get salon => 'Salon';

  @override
  String get weProvideYouBestServiceMessage =>
      'We Provide You Best services and best';

  @override
  String get userExperience => 'user experience';

  @override
  String get createAccount => 'Create Account';

  @override
  String get pending => 'Pending';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get checkIn => 'Check In';

  @override
  String get checkOut => 'Check Out';

  @override
  String get completed => 'Completed';

  @override
  String get invalidUrl => 'Invalid URL';

  @override
  String get enterYourReviewOptional => 'Enter Your Review (Optional)';

  @override
  String get cancel => 'Cancel';

  @override
  String get submit => 'Submit';

  @override
  String get ratingIsRequired => 'Rating is required';

  @override
  String get timeSlotBookedMessage =>
      'is already booked! Please choose another timeslot';

  @override
  String get branchName => 'Branch Name';

  @override
  String get place => 'Place';

  @override
  String get basedOn => 'Based on';

  @override
  String get review => 'Review';

  @override
  String get s => 's';

  @override
  String get error => 'Error:';

  @override
  String get externalWallet => 'External Wallet:';

  @override
  String get userCancelled => 'User cancelled';

  @override
  String get userNotFound => 'User Not Found';

  @override
  String get dateIsRequired => 'Date is required';

  @override
  String get timeIsRequired => 'Time is required';

  @override
  String get bookAndManageYourBookings => 'Book & Manage your bookings';

  @override
  String get walkThrough1subTitle =>
      'Turn on notification and we\'ll remind you when your booking is coming';

  @override
  String get getCouponForDiscount => 'Get coupon for discount';

  @override
  String get walkThrough2subTitle =>
      ' Don\'t miss out on the chance to save big on your favorite services';

  @override
  String get earnPointsByCompletingServices =>
      'Earn Points by completing services';

  @override
  String get walkThrough3subTitle =>
      'Loyalty Points Program for Exclusive Discounts!';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get Started';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get signInYourAccount => 'Sign In your account';

  @override
  String get deleteAccountConfirmation =>
      'Your data will not be able to be restored after the deletion!';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get helloGuest => 'Hello, Guest';

  @override
  String get signInWith => 'Sign In With';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get termsConditionsMessage =>
      'I have read the disclaimer and agree upon the terms and conditions';

  @override
  String get pleaseAcceptTermsAndConditions =>
      'Please accept terms and conditions';

  @override
  String get description => 'Description';

  @override
  String get serviceNote => 'Service Note (optional)';

  @override
  String get optional => '(optional)';

  @override
  String get priceMayBeUpdated => 'Price may be updated';

  @override
  String get optionalDetails => 'Optional Details';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get priceDetails => 'Price Details';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get paymentStatus => 'Payment Status';

  @override
  String get paid => 'Paid';

  @override
  String get goBack => 'Go Back';

  @override
  String get noStaffAvailableForBranchMessage =>
      'No staff available for selected service!';

  @override
  String get tryToChangeYourService => 'Try to Change Your Service';

  @override
  String get pay => 'Pay';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String get selectEmployeeFirst => 'Select Employee First';

  @override
  String get yourBookingForHairBookingMessage =>
      'Your booking for hair cut has been successfully booked';

  @override
  String get back => 'Back';

  @override
  String get taxIncluded => 'tax included';

  @override
  String get demoUserCannotBeGrantedForThis =>
      'Demo user cannot be granted for this action';

  @override
  String get payNow => 'Pay Now';

  @override
  String get pleaseTryAgain => 'Please try again';

  @override
  String get somethingWentWrong => 'Something Went Wrong';

  @override
  String get yourInternetIsNotWorking => 'Your internet is not working';

  @override
  String get slotUnavailable => 'This slot is unavailable';

  @override
  String get galleryWillBeAppearedHere => 'Gallery will be appeared here';

  @override
  String get goToBookingDetail => 'Go To Booking Detail';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage =>
      'Your payment is paid successfully with';

  @override
  String get paymentSuccessful => 'Payment Successful!';

  @override
  String get edit => 'Edit';

  @override
  String get bookingTimeSlotChangeMessage =>
      'Do you want to change the Time Slot of this booking?';

  @override
  String get change => 'Change';

  @override
  String get pleaseUpdateYourProfile => 'Please update your profile';

  @override
  String get profileUpdatedSuccessfully => 'Profile Updated Successfully';

  @override
  String get oldPasswordDoesNotMatchMessage =>
      "Your old password doesn't correct!";

  @override
  String get bookingSuccessfullyUpdateMessage =>
      'The booking has been successfully updated';

  @override
  String get newUpdate => 'New Update';

  @override
  String get anUpdateToIs =>
      'An Update to $APP_NAME is available. Go to Play Store and Download the New Version of the App.';

  @override
  String get closeApp => 'Close App';

  @override
  String get paystack => 'Paystack';

  @override
  String get paypal => 'Paypal';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get gender => 'Gender';

  @override
  String get pleaseSelectTheDateFirst => 'Please Select the Date First';

  @override
  String get thereAreNoBookings =>
      'There are no bookings listed at the moment. Keep track of your bookings here.';

  @override
  String get payWithFlutterwave => 'Pay With Flutterwave';

  @override
  String get transactionFailed => 'Transaction Failed';

  @override
  String get transactionCancelled => 'Transaction cancelled';

  @override
  String get flutterwave => 'Flutterwave';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove =>
      'Are you sure you want to remove this item';

  @override
  String get remove => 'Remove';

  @override
  String get you => 'You';

  @override
  String get veChanged => 've changed';

  @override
  String get quantityTo => 'QUANTITY to';

  @override
  String get editAddress => 'Edit Address';

  @override
  String get addNewAddress => 'Add New Address';

  @override
  String get country => 'Country';

  @override
  String get nationality => 'Nationalily';

  @override
  String get selectCountry => 'Select Country';

  @override
  String get selectState => 'Select State';

  @override
  String get selectCity => 'Select City';

  @override
  String get pincode => 'PinCode';

  @override
  String get addressLine => 'Address Line';

  @override
  String get writeAddressHere => 'Write Address Here';

  @override
  String get writeLandmarkHere => 'Write Landmark Here';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get save => 'Save';

  @override
  String get cart => 'Cart';

  @override
  String get yourCartIsEmpty => 'Your Cart is empty';

  @override
  String get thereAreCurrentlyNoItems =>
      'There are currently no items in your cart. Start shopping and add items to your cart.';

  @override
  String get productPriceDetails => 'Product Price Details';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get select => 'Select';

  @override
  String get selectAddress => 'Select Address';

  @override
  String get opps => 'Opps';

  @override
  String get looksLikeYouHave =>
      'looks like you have not added any address yet.';

  @override
  String get primary => 'primary';

  @override
  String get deliverHere => 'Deliver Here';

  @override
  String get areYouSureYouWantToDelete =>
      'Are you sure you want to delete this address';

  @override
  String get addressDeleteSuccessfully => 'Address delete successfully';

  @override
  String get weAreNotShipping => 'We are not shipping to your city now';

  @override
  String get deliveryCharge => 'Delivery Charge';

  @override
  String get orders => 'Orders';

  @override
  String get seeYourOrders => 'See your orders';

  @override
  String get myAddresses => 'My Addresses';

  @override
  String get manageYourAddresses => 'Manage your addresses ';

  @override
  String get shop => 'Shop';

  @override
  String get aboutProduct => 'About Product';

  @override
  String get qty => 'Qty';

  @override
  String get orderDetail => 'Order Detail';

  @override
  String get orderDate => 'Order Date';

  @override
  String get deliveredOn => 'Delivered On';

  @override
  String get deliveryStatus => 'Delivery Status';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String get doYouWantToCancel => 'Do you want to cancel this order';

  @override
  String get theOrderHasBeenCancelled =>
      'The order has been cancelled successfully.';

  @override
  String get noOrdersFound => 'No Orders Found';

  @override
  String get thereAreNoOrders =>
      'There are no orders listed at the moment. Keep track of your orders here.';

  @override
  String get tax => 'Tax';

  @override
  String get shippingDetail => 'Shipping Detail';

  @override
  String get alternativeContactNumber => 'Alternative Contact Number:';

  @override
  String get addReview => 'Add Review';

  @override
  String get thanksYouForReview => 'Thanks you for Review!';

  @override
  String get selectUpToThreeImages => 'Select up to three images!';

  @override
  String get doYouWantToRemove => 'Do you want to remove this image';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get customerDetail => 'Customer Detail';

  @override
  String get fullName => 'Full Name';

  @override
  String get alternateContactNumber => 'Alternate Contact Number';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get off => 'off';

  @override
  String get discountedAmount => 'Discounted Amount';

  @override
  String get proceed => 'Proceed';

  @override
  String get productReviews => 'Product Reviews';

  @override
  String get thanksForVoting => 'Thanks for Voting';

  @override
  String get bestSellerProduct => 'Best Seller Product';

  @override
  String get dealsForYou => 'Deals For You';

  @override
  String get noProductsFound => 'No products Found';

  @override
  String get featured => 'Featured';

  @override
  String get readMore => 'Read More';

  @override
  String get readLess => 'Read Less';

  @override
  String get brand => 'Brand';

  @override
  String get inclusiveOfAllTaxes => 'Inclusive Of All Taxes';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get productSize => 'Product Size';

  @override
  String get quantity => 'Quantity';

  @override
  String get noRatingsYet => 'No Ratings Yet';

  @override
  String get ratingAndReviews => 'Rating and Reviews';

  @override
  String get totalReviewsAndRatings => 'Total Reviews And Ratings';

  @override
  String get ourMostLoveChewTreats => 'Our Most Love Chew Treats';

  @override
  String get allCategories => 'All Categories';

  @override
  String get thereAreNoCategories =>
      'There are no categories at the moment. Keep track of your categories here.';

  @override
  String get searchForProduct => 'Search For Product';

  @override
  String get atThisTimeThere =>
      'At this time, there are no products or categories available';

  @override
  String get goToCart => 'GO TO CART';

  @override
  String get addToCart => 'ADD TO CART';

  @override
  String get orderSuccessfullyPlaced => 'Order Successfully Placed';

  @override
  String get yorOrderHasBeen => 'Yor Order has been successfully placed';

  @override
  String get goToOrderList => 'Go to Order List';

  @override
  String get choosePaymentMethod => 'Choose Payment Method';

  @override
  String get chooseYourConvenientPayment =>
      'Choose Your Convenient Payment Option.';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String get doYouConfirmThisPayment => 'Do you confirm this payment';

  @override
  String get wishlist => 'Wishlist';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist =>
      'There are currently no items in your wishlist. Start adding items you love to save them for later.';

  @override
  String get price => 'Price';

  @override
  String get productBrands => 'Product Brands';

  @override
  String get searchBrand => 'Search Brand';

  @override
  String get more => 'More';

  @override
  String get rating => 'Rating';

  @override
  String get weight => 'Weight';

  @override
  String get clearFilter => 'Clear Filter';

  @override
  String get applyFilter => 'Apply Filter';

  @override
  String get orderPlaced => 'Order Placed';

  @override
  String get processing => 'Processing';

  @override
  String get delivered => 'Delivered';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get parchasedProducts => 'Parchased Products';

  @override
  String get productAmount => 'Product Amount';

  @override
  String get filterBy => 'Filter By';

  @override
  String get bookingStatus => 'Booking Status';

  @override
  String get apply => 'Apply';

  @override
  String get searchOrder => 'Search Order';
}
