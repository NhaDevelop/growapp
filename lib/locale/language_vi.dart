import '../configs.dart';
import 'languages.dart';

class LanguageVi extends BaseLanguage {
  @override
  String get tokenExpired => 'Token Hết Hạn';

  @override
  String get badRequest => '400: Yêu Cầu Không Hợp Lệ';

  @override
  String get forbidden => '403: Bị Từ Chối';

  @override
  String get pageNotFound => '404: Không Tìm Thấy Trang';

  @override
  String get tooManyRequests => '429: Quá Nhiều Yêu Cầu';

  @override
  String get internalServerError => '500: Lỗi Máy Chủ';

  @override
  String get badGateway => '502: Cổng Không Hợp Lệ';

  @override
  String get serviceUnavailable => '503: Dịch Vụ Không Khả Dụng';

  @override
  String get gatewayTimeout => '504: Thời Gian Chờ Cổng';

  @override
  String get hey => 'Xin chào';

  @override
  String get welcomeToGrowTokyo => 'Chào mừng đến với growTokyo!';

  @override
  String get createYourAccountFor => 'Tạo Tài Khoản của Bạn để Trải Nghiệm Tốt Hơn';

  @override
  String get firstName => 'Tên';

  @override
  String get lastName => 'Họ';

  @override
  String get dob => 'Ngày Sinh';

  @override
  String get email => 'Email';

  @override
  String get thisFieldIsRequired => 'Trường bắt buộc';

  @override
  String get contactNumber => 'Số Điện Thoại Liên Hệ';

  @override
  String get password => 'Mật Khẩu';

  @override
  String get signUp => 'Đăng Ký';

  @override
  String get alreadyHaveAnAccount => 'Đã có tài khoản?';

  @override
  String get signIn => 'Đăng Nhập';

  @override
  String get guestBookingMessage => 'Đăng nhập để đặt lịch và nhận ưu đãi';

  @override
  String get continueAsGuest => 'Tiếp tục dưới dạng Khách';

  @override
  String get welcomeBack => 'Chào mừng trở lại!';

  @override
  String get pleaseLogin => 'Vui lòng đăng nhập để bắt đầu';

  @override
  String get rememberMe => 'Ghi nhớ';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get forgotPassword2 => 'Quên mật khẩu?';

  @override
  String get registerNow => 'Đăng ký ngay';

  @override
  String get or => 'HOẶC';

  @override
  String get pleaseEnterValidOtp => 'Vui lòng nhập mã OTP hợp lệ';

  @override
  String get otpVerification => 'Xác minh OTP';

  @override
  String get checkYourMailAnd => 'Kiểm tra Email của bạn và nhập mã bạn nhận được';

  @override
  String get didNotGetTheOtp => 'Không nhận được mã OTP?';

  @override
  String get resendOtp => 'Gửi lại OTP';

  @override
  String get verify => 'Xác minh';

  @override
  String get enterYourEmailAddress => 'Nhập địa chỉ email của bạn';

  @override
  String get aResetPasswordLink =>
      'Một liên kết đặt lại mật khẩu sẽ được gửi đến địa chỉ email đã nhập ở trên';

  @override
  String get resetPassword => 'Đặt lại mật khẩu';

  @override
  String get areYouSureWantToPerformThisAction => 'Bạn có chắc muốn thực hiện hành động này không?';

  @override
  String get yes => 'Có';

  @override
  String get no => 'Không';

  @override
  String get gallery => 'Bộ Sưu Tập';

  @override
  String get camera => 'Máy Ảnh';

  @override
  String get editProfile => 'Chỉnh Sửa Hồ Sơ';

  @override
  String get update => 'Cập Nhật';

  @override
  String get changePassword => 'Thay Đổi Mật Khẩu';

  @override
  String get newPasswordsMustBeDifferent => 'Mật khẩu mới phải khác với mật khẩu trước đó';

  @override
  String get oldPassword => 'Mật Khẩu Cũ';

  @override
  String get newPassword => 'Mật Khẩu Mới';

  @override
  String get thePasswordDoesNotMatch => 'Mật khẩu không khớp';

  @override
  String get reEnterPassword => 'Nhập lại Mật Khẩu';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get pleaseLoginAgain => 'Vui lòng đăng nhập lại';

  @override
  String get loginSuccessfully => 'Đăng nhập thành công';

  @override
  String get noUserFound => 'Không tìm thấy người dùng';

  @override
  String get otpInvalidMessage => 'Mã đã nhập không hợp lệ, vui lòng thử lại';

  @override
  String get pleaseContactWithAdmin => 'Vui lòng liên hệ Admin';

  @override
  String get confirmOtp => 'Xác nhận OTP';

  @override
  String get verified => 'Đã xác nhận';

  @override
  String get signInFailed => 'Đăng nhập thất bại';

  @override
  String get appleSigInIsNotAvailable => 'Apple SignIn không khả dụng cho thiết bị của bạn';

  @override
  String get emailAddressIsRequiredUpdateAppleAccount =>
      'Địa chỉ email là bắt buộc. Vui lòng cập nhật Email trong tài khoản Apple của bạn';

  @override
  String get yourPasswordReset => 'Thiết lập lại mật khẩu của bạn';

  @override
  String get yourAccountIsReady =>
      'Tài khoản của bạn đã sẵn sàng để sử dụng. Hãy thưởng thức dịch vụ của và chuyên gia của chúng tôi';

  @override
  String get yourPassWorResetSuccessfully => 'Thiết lập lại mật khẩu thành công';

  @override
  String get done => 'Hoàn tất';

  @override
  String get specialist => 'Chuyên gia';

  @override
  String get date => 'Ngày';

  @override
  String get time => 'Thời gian';

  @override
  String get payment => 'Thanh toán';

  @override
  String get noDetailsFound => 'Không tìm thấy chi tiết';

  @override
  String get reload => 'Tải lại';

  @override
  String get locationInformation => 'Thông tin vị trí';

  @override
  String get name => 'Tên';

  @override
  String get address => 'Địa chỉ';

  @override
  String get bookAppointment => 'Đặt lịch';

  @override
  String get points => 'Điểm';

  @override
  String get noTransactionFound => 'Không tìm thấy giao dịch';

  @override
  String usingXPoints(String x) => 'Sử dụng $x điểm';

  @override
  String youWillSave$X(String x) => 'Bạn sẽ tiết kiệm $x';

  @override
  String get membershipPoints => 'Điểm thành viên';

  @override
  String equivalentToX(String x) => 'Tương đương $x';

  @override
  String get referral => 'Giới thiệu';

  @override
  String get referralDiscount => 'Giảm giá giới thiệu';

  @override
  String get referralCode => 'Mã giới thiệu';

  @override
  String get yourReferralCode => 'Mã giới thiệu của bạn';

  @override
  String shareReferralCode(code, discountPercentage) =>
      'Check out this amazing app! It has made booking a haircut much easier. Use my code $code to receive $discountPercentage% discount.';

  @override
  String get rewardHistory => 'Lịch sử phần thưởng';

  @override
  String get copyCode => 'Sao chép mã';

  @override
  String get copiedToClipboard => 'Đã sao chép vào Bảng ghi tạm';

  @override
  String get referralRewardMessage => 'Mời khách hàng mới để nhận điểm thưởng';

  @override
  String get howItWorks => 'Hoạt động như thế nào?';

  @override
  String get referralStep1 => 'Chia sẻ mã giới thiệu của bạn với bạn bè.';

  @override
  String get referralStep2 => 'Bạn bè của bạn đặt lịch hẹn và áp dụng mã của bạn để nhận giảm giá.';

  @override
  String get referralStep3 =>
      'Sau khi đặt lịch của bạn bè hoàn thành, bạn sẽ nhận được điểm thưởng làm phần thưởng.';

  @override
  String get referralStepNote => 'Mỗi mã giới thiệu chỉ có thể sử dụng một lần cho mỗi người.';

  @override
  String get addReferralCode => 'Thêm Mã Giới Thiệu';

  @override
  String get coupon => 'Phiếu giảm giá';

  @override
  String get couponDiscount => 'Giảm giá từ phiếu giảm giá';

  @override
  String get validUntil => 'Hiệu lực đến';

  @override
  String get addCoupon => 'Thêm Phiếu giảm giá';

  @override
  String get fbEcSite => 'Trang FB EC';

  @override
  String get inquiry => 'Yêu cầu';

  @override
  String get inquiryMessage => 'Vui lòng chọn ứng dụng bạn muốn trò chuyện với chúng tôi.';

  @override
  String get telegram => 'Telegram';

  @override
  String get messenger => 'Messenger';

  @override
  String get blog => 'Blog';

  @override
  String get service => 'Dịch vụ';

  @override
  String get total => 'Tổng cộng';

  @override
  String get bookNow => 'Đặt Ngay';

  @override
  String get pleaseSelectService => 'Vui lòng chọn dịch vụ';

  @override
  String get confirmBooking => 'Xác nhận Đặt lịch';

  @override
  String get doYouWantToConfirmBooking => 'Bạn có muốn xác nhận đặt lịch này không?';

  @override
  String get yourInformation => 'Thông tin của bạn';

  @override
  String get timeSlot => 'Khoảng thời gian';

  @override
  String get stylist => 'Nhà tạo mẫu';

  @override
  String get addCode => 'Thêm mã';

  @override
  String get paymentDetails => 'Chi tiết thanh toán';

  @override
  String get payAtSalon => 'Thanh toán tại Salon';

  @override
  String get subtotal => 'Tổng thanh toán';

  @override
  String get tip => 'Tip';

  @override
  String get discount => 'Giảm giá';

  @override
  String get discountCode => 'Mã giảm giá';

  @override
  String get yourReview => 'Đánh giá của bạn';

  @override
  String get deleteReview => 'Xóa đánh giá';

  @override
  String get doYouWantToDeleteReview => 'Bạn có muốn xóa đánh giá này không?';

  @override
  String get viewAll => 'Xem tất cả';

  @override
  String get rate => 'Đánh giá';

  @override
  String get paymentMethod => 'Phương thức thanh toán';

  @override
  String get goToBookings => 'Đi đến Đặt lịch';

  @override
  String get bookingSuccessMessage => 'Đặt lịch của bạn đã được đặt thành công';

  @override
  String get bookingSuccessful => 'Đặt lịch thành công!';

  @override
  String get cashAfterService => 'Tiền mặt sau dịch vụ';

  @override
  String get razorpay => 'Razorpay';

  @override
  String get stripe => 'Stripe';

  @override
  String get doWantToBookAppointment => 'Bạn có muốn đặt cuộc hẹn này không?';

  @override
  String get noTimeSlots => 'Không có lịch trống';

  @override
  String get availableSlots => 'Các lịch trống';

  @override
  String get next => 'Tiếp theo';

  @override
  String get pleaseSelectDateFirst => 'Vui lòng chọn ngày trước';

  @override
  String get pleaseSelectTimeSlotFirst => 'Vui lòng chọn khung giờ trước';

  @override
  String get chooseYourStylist => 'Chọn nhà tạo mẫu của bạn';

  @override
  String get viewSchedule => 'Xem lịch trình';

  @override
  String get pleaseChooseYourStylist => 'Vui lòng chọn nhà tạo mẫu của bạn trước';

  @override
  String get services => 'Dịch vụ';

  @override
  String get cancelAppointment => 'Hủy cuộc hẹn';

  @override
  String get doYouWantToCancelBooking => 'Bạn có muốn hủy cuộc hẹn này không?';

  @override
  String get bookingInformation => 'Thông tin đặt lịch';

  @override
  String get status => 'Trạng thái';

  @override
  String get chooseBranch => 'Chọn Chi nhánh';

  @override
  String get noBranchFound => 'Không tìm thấy chi nhánh';

  @override
  String get nearbyBranches => 'Các chi nhánh gần đây';

  @override
  String get about => 'Giới thiệu';

  @override
  String get socialMedia => 'Mạng xã hội';

  @override
  String get instagram => 'Instagram';

  @override
  String get facebook => 'Facebook';

  @override
  String get details => 'Chi tiết';

  @override
  String get reviews => 'Đánh giá';

  @override
  String get staff => 'Nhân viên';

  @override
  String get noServicesFound => 'Không tìm thấy dịch vụ';

  @override
  String get noReviewsFound => 'Không tìm thấy đánh giá';

  @override
  String get yourReviewsWillBeAppearedHere => 'Đánh giá của bạn sẽ xuất hiện ở đây';

  @override
  String get call => 'Gọi';

  @override
  String get direction => 'Chỉ đường';

  @override
  String get noGalleryFound => 'Không tìm thấy bộ sưu tập';

  @override
  String get workingHours => 'Giờ làm việc';

  @override
  String get ourCategory => 'Danh mục của chúng tôi';

  @override
  String get noCategoryFound => 'Không tìm thấy danh mục';

  @override
  String get pressBackAgainToExitApp => 'Nhấn back một lần nữa để thoát ứng dụng';

  @override
  String get home => 'Trang chủ';

  @override
  String get myBooking => 'Đặt lịch của tôi';

  @override
  String get notifications => 'Thông báo';

  @override
  String get happyBirthday => 'Chúc mừng sinh nhật';

  @override
  String get user => 'Người dùng';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get setting => 'Cài đặt';

  @override
  String get appLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get theme => 'Giao diện';

  @override
  String get aboutApp => 'Về ứng dụng';

  @override
  String get rateUs => 'Đánh giá chúng tôi';

  @override
  String get share => 'Chia sẻ';

  @override
  String get help => 'Trợ giúp';

  @override
  String get helpCenter => 'Trung tâm trợ giúp';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get tC => 'Điều khoản và điều kiện';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get logoutYourAccount => 'Đăng xuất tài khoản của bạn';

  @override
  String get ohNoYouAreLeaving => 'Ồ, bạn đang rời đi!';

  @override
  String get doYouWantToLogout => 'Bạn có muốn đăng xuất không?';

  @override
  String get noNotifications => 'Không có thông báo';

  @override
  String get weLlNotifyYouOnce => "Chúng tôi sẽ thông báo cho bạn khi có thông tin mới";

  @override
  String get searchForServices => 'Tìm kiếm dịch vụ';

  @override
  String get searchServices => 'Đang tìm kiếm dịch vụ';

  @override
  String get searchBooking => 'Tìm kiếm đặt lịch';

  @override
  String get topExperts => 'Các Chuyên Gia Hàng Đầu';

  @override
  String get theUserHasDeniedSpeechRecognition =>
      'Người dùng đã từ chối việc sử dụng nhận dạng giọng nói';

  @override
  String get category => 'Danh mục';

  @override
  String get kms => 'KMs';

  @override
  String get fromYourLocation => 'Từ Vị Trí Của Bạn';

  @override
  String get noBookingsFound => 'Không Tìm Thấy Đặt Lịch Nào';

  @override
  String get notAMember => 'Không phải là thành viên?';

  @override
  String get noStaffFound => 'Không Tìm Thấy Nhân Viên';

  @override
  String get contactInfo => 'Thông Tin Liên Hệ';

  @override
  String get noReviewsYetFor => 'Chưa có đánh giá cho';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get appTheme => 'Giao Diện Ứng Dụng';

  @override
  String get bySigningUpYouAgreeToOur => 'Bằng cách đăng ký bạn đồng ý với';

  @override
  String get termsConditions => 'Điều khoản & Điều kiện';

  @override
  String get app => 'Ứng dụng';

  @override
  String get light => 'Sáng';

  @override
  String get dark => 'Tối';

  @override
  String get systemDefault => 'Mặc định Hệ thống';

  @override
  String get chooseTheme => 'Chọn Giao Diện';

  @override
  String get allServices => 'Tất cả Dịch vụ';

  @override
  String get searchFor => 'Tìm kiếm';

  @override
  String get subCategories => 'Danh mục con';

  @override
  String get clear => 'Xóa';

  @override
  String get welcomeToThe => 'Chào mừng bạn đến với';

  @override
  String get salon => 'Salon';

  @override
  String get weProvideYouBestServiceMessage =>
      'Chúng tôi cung cấp cho bạn dịch vụ tốt nhất và trải nghiệm người dùng tốt nhất';

  @override
  String get userExperience => 'trải nghiệm người dùng';

  @override
  String get createAccount => 'Tạo Tài Khoản';

  @override
  String get pending => 'Đang chờ xử lý';

  @override
  String get confirmed => 'Đã xác nhận';

  @override
  String get cancelled => 'Đã hủy';

  @override
  String get checkIn => 'Check In';

  @override
  String get checkOut => 'Check Out';

  @override
  String get completed => 'Hoàn thành';

  @override
  String get invalidUrl => 'URL không hợp lệ';

  @override
  String get enterYourReviewOptional => 'Nhập Đánh Giá Của Bạn (Tùy chọn)';

  @override
  String get cancel => 'Hủy';

  @override
  String get submit => 'Gửi';

  @override
  String get ratingIsRequired => 'Đánh giá là bắt buộc';

  @override
  String get timeSlotBookedMessage => 'đã được đặt! Vui lòng chọn một khung giờ khác';

  @override
  String get branchName => 'Tên Chi Nhánh';

  @override
  String get place => 'Địa điểm';

  @override
  String get basedOn => 'Dựa trên';

  @override
  String get review => 'Đánh giá';

  @override
  String get s => 's';

  @override
  String get error => 'Lỗi:';

  @override
  String get externalWallet => 'Ví Ngoại:';

  @override
  String get userCancelled => 'Người dùng đã hủy';

  @override
  String get userNotFound => 'Người dùng Không Tìm Thấy';

  @override
  String get dateIsRequired => 'Ngày là bắt buộc';

  @override
  String get timeIsRequired => 'Thời gian là bắt buộc';

  @override
  String get bookAndManageYourBookings => 'Đặt & Quản lý đặt chỗ của bạn';

  @override
  String get walkThrough1subTitle =>
      'Bật thông báo và chúng tôi sẽ nhắc bạn khi đến lịch đặt của bạn';

  @override
  String get getCouponForDiscount => 'Nhận mã giảm giá';

  @override
  String get walkThrough2subTitle =>
      ' Đừng bỏ lỡ cơ hội để tiết kiệm lớn cho các dịch vụ yêu thích của bạn';

  @override
  String get earnPointsByCompletingServices => 'Kiếm điểm bằng cách hoàn thành dịch vụ';

  @override
  String get walkThrough3subTitle => 'Chương trình điểm thưởng cho Ưu đãi Độc quyền!';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteAccount => 'Xóa Tài Khoản';

  @override
  String get signInYourAccount => 'Đăng nhập vào tài khoản của bạn';

  @override
  String get deleteAccountConfirmation =>
      'Dữ liệu của bạn sẽ không thể khôi phục được sau khi xóa!';

  @override
  String get dangerZone => 'Vùng Nguy Hiểm';

  @override
  String get helloGuest => 'Xin chào bạn';

  @override
  String get signInWith => 'Đăng nhập bằng';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get termsConditionsMessage =>
      'Tôi đã đọc phần miễn trừ trách nhiệm và đồng ý với các điều khoản và điều kiện';

  @override
  String get pleaseAcceptTermsAndConditions => 'Vui lòng chấp nhận các điều khoản và điều kiện';

  @override
  String get description => 'Mô tả';

  @override
  String get serviceNote => 'Ghi Chú Dịch Vụ (tùy chọn)';

  @override
  String get optional => '(tùy chọn)';

  @override
  String get priceMayBeUpdated => 'Giá có thể được cập nhật';

  @override
  String get optionalDetails => 'Chi Tiết Tùy Chọn';

  @override
  String get reschedule => 'Đổi lịch';

  @override
  String get priceDetails => 'Chi Tiết Giá';

  @override
  String get transactionId => 'ID Giao Dịch';

  @override
  String get paymentStatus => 'Trạng Thái Thanh Toán';

  @override
  String get paid => 'Đã Thanh Toán';

  @override
  String get goBack => 'Quay Lại';

  @override
  String get noStaffAvailableForBranchMessage =>
      'Không có nhân viên nào phù hợp với dịch vụ được chọn!';

  @override
  String get tryToChangeYourService => 'Hãy Thử Đổi Dịch Vụ Của Bạn';

  @override
  String get pay => 'Thanh Toán';

  @override
  String get open => 'Mở cửa';

  @override
  String get closed => 'Đóng cửa';

  @override
  String get selectEmployeeFirst => 'Chọn Nhân Viên Trước';

  @override
  String get yourBookingForHairBookingMessage =>
      'Đặt chỗ của bạn cho việc cắt tóc đã được đặt thành công';

  @override
  String get back => 'Quay lại';

  @override
  String get taxIncluded => 'đã bao gồm thuế';

  @override
  String get demoUserCannotBeGrantedForThis =>
      'Người dùng demo không thể được cấp quyền cho hành động này';

  @override
  String get payNow => 'Thanh Toán Ngay';

  @override
  String get pleaseTryAgain => 'Vui lòng thử lại';

  @override
  String get somethingWentWrong => 'Đã Xảy Ra Lỗi';

  @override
  String get yourInternetIsNotWorking => 'Kết nối Internet của bạn không hoạt động';

  @override
  String get slotUnavailable => 'Khoảng thời gian này không khả dụng';

  @override
  String get galleryWillBeAppearedHere => 'Thư viện sẽ xuất hiện ở đây';

  @override
  String get goToBookingDetail => 'Đi đến Chi Tiết Đặt Chỗ';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage =>
      'Thanh toán của bạn đã được thực hiện thành công với';

  @override
  String get paymentSuccessful => 'Thanh toán thành công!';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get bookingTimeSlotChangeMessage =>
      'Bạn có muốn thay đổi Khoảng thời gian của đặt chỗ này không?';

  @override
  String get change => 'Thay đổi';

  @override
  String get pleaseUpdateYourProfile => 'Vui lòng cập nhật hồ sơ của bạn';

  @override
  String get profileUpdatedSuccessfully => 'Cập nhật hồ sơ thành công';

  @override
  String get oldPasswordDoesNotMatchMessage => "Mật khẩu cũ của bạn không đúng!";

  @override
  String get bookingSuccessfullyUpdateMessage => 'Đặt chỗ đã được cập nhật thành công';

  @override
  String get newUpdate => 'Cập nhật mới';

  @override
  String get anUpdateToIs =>
      'Một cập nhật đến $APP_NAME đã có sẵn. Truy cập Play Store và Tải về Phiên Bản Mới của Ứng Dụng.';

  @override
  String get closeApp => 'Đóng ứng dụng';

  @override
  String get paystack => 'Paystack';

  @override
  String get paypal => 'Paypal';

  @override
  String get male => 'Nam';

  @override
  String get female => 'Nữ';

  @override
  String get other => 'Khác';

  @override
  String get gender => 'Giới tính';

  @override
  String get pleaseSelectTheDateFirst => 'Vui lòng chọn ngày trước';

  @override
  String get thereAreNoBookings =>
      'Hiện tại không có đặt chỗ nào được liệt kê. Theo dõi đặt chỗ của bạn ở đây.';

  @override
  String get payWithFlutterwave => 'Thanh toán với Flutterwave';

  @override
  String get transactionFailed => 'Giao dịch thất bại';

  @override
  String get transactionCancelled => 'Giao dịch đã bị hủy';

  @override
  String get flutterwave => 'Flutterwave';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'Bạn có chắc muốn xóa mục này không';

  @override
  String get remove => 'Xóa';

  @override
  String get you => 'Bạn';

  @override
  String get veChanged => 'đã thay đổi';

  @override
  String get quantityTo => 'SỐ LƯỢNG đến';

  @override
  String get editAddress => 'Chỉnh sửa Địa chỉ';

  @override
  String get addNewAddress => 'Thêm Địa chỉ Mới';

  @override
  String get country => 'Quốc gia';

  @override
  String get nationality => 'Quốc tịch';

  @override
  String get selectCountry => 'Chọn Quốc gia';

  @override
  String get selectState => 'Chọn Tỉnh/Thành phố';

  @override
  String get selectCity => 'Chọn Thành phố';

  @override
  String get pincode => 'Mã bưu chính';

  @override
  String get addressLine => 'Địa chỉ';

  @override
  String get writeAddressHere => 'Nhập địa chỉ ở đây';

  @override
  String get writeLandmarkHere => 'Nhập điểm đặc biệt ở đây';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get save => 'Lưu';

  @override
  String get cart => 'Giỏ hàng';

  @override
  String get yourCartIsEmpty => 'Giỏ hàng của bạn đang trống';

  @override
  String get thereAreCurrentlyNoItems =>
      'Hiện không có sản phẩm nào trong giỏ hàng của bạn. Hãy bắt đầu mua sắm và thêm sản phẩm vào giỏ hàng của bạn.';

  @override
  String get productPriceDetails => 'Chi tiết giá sản phẩm';

  @override
  String get totalAmount => 'Tổng số tiền';

  @override
  String get select => 'Chọn';

  @override
  String get selectAddress => 'Chọn Địa chỉ';

  @override
  String get opps => 'Opps';

  @override
  String get looksLikeYouHave => 'Có vẻ như bạn chưa thêm bất kỳ địa chỉ nào.';

  @override
  String get primary => 'Chính';

  @override
  String get deliverHere => 'Giao hàng tại đây';

  @override
  String get areYouSureYouWantToDelete => 'Bạn có chắc chắn muốn xóa địa chỉ này không';

  @override
  String get addressDeleteSuccessfully => 'Xóa địa chỉ thành công';

  @override
  String get weAreNotShipping => 'Chúng tôi hiện không giao hàng đến thành phố của bạn';

  @override
  String get deliveryCharge => 'Phí giao hàng';

  @override
  String get orders => 'Đơn hàng';

  @override
  String get seeYourOrders => 'Xem đơn hàng của bạn';

  @override
  String get myAddresses => 'Địa chỉ của tôi';

  @override
  String get manageYourAddresses => 'Quản lý địa chỉ của bạn';

  @override
  String get shop => 'Mua sắm';

  @override
  String get aboutProduct => 'Về Sản phẩm';

  @override
  String get qty => 'Số lượng';

  @override
  String get orderDetail => 'Chi tiết đơn hàng';

  @override
  String get orderDate => 'Ngày đặt hàng';

  @override
  String get deliveredOn => 'Giao vào';

  @override
  String get deliveryStatus => 'Trạng thái giao hàng';

  @override
  String get cancelOrder => 'Hủy đơn hàng';

  @override
  String get doYouWantToCancel => 'Bạn có muốn hủy đơn hàng này không';

  @override
  String get theOrderHasBeenCancelled => 'Đơn hàng đã được hủy thành công.';

  @override
  String get noOrdersFound => 'Không có đơn hàng nào';

  @override
  String get thereAreNoOrders =>
      'Hiện không có đơn hàng nào được liệt kê. Theo dõi đơn hàng của bạn ở đây.';

  @override
  String get tax => 'Thuế';

  @override
  String get shippingDetail => 'Chi tiết giao hàng';

  @override
  String get alternativeContactNumber => 'Số liên hệ thay thế:';

  @override
  String get addReview => 'Thêm Đánh giá';

  @override
  String get thanksYouForReview => 'Cảm ơn bạn đã đánh giá!';

  @override
  String get selectUpToThreeImages => 'Chọn tối đa ba hình ảnh!';

  @override
  String get doYouWantToRemove => 'Bạn có muốn xóa hình ảnh này không';

  @override
  String get addPhoto => 'Thêm Ảnh';

  @override
  String get customerDetail => 'Chi tiết Khách hàng';

  @override
  String get fullName => 'Họ và tên đầy đủ';

  @override
  String get alternateContactNumber => 'Số liên hệ thay thế';

  @override
  String get orderSummary => 'Tóm tắt đơn hàng';

  @override
  String get shippingAddress => 'Địa chỉ giao hàng';

  @override
  String get off => 'Nghỉ';

  @override
  String get discountedAmount => 'Số tiền giảm giá';

  @override
  String get proceed => 'Tiếp tục';

  @override
  String get productReviews => 'Đánh giá Sản phẩm';

  @override
  String get thanksForVoting => 'Cảm ơn bạn đã bình chọn';

  @override
  String get bestSellerProduct => 'Sản phẩm bán chạy nhất';

  @override
  String get dealsForYou => 'Ưu đãi dành cho bạn';

  @override
  String get noProductsFound => 'Không tìm thấy sản phẩm';

  @override
  String get featured => 'Nổi bật';

  @override
  String get readMore => 'Đọc thêm';

  @override
  String get readLess => 'Thu gọn';

  @override
  String get brand => 'Thương hiệu';

  @override
  String get inclusiveOfAllTaxes => 'Bao gồm tất cả các loại thuế';

  @override
  String get outOfStock => 'Hết hàng';

  @override
  String get productSize => 'Kích thước sản phẩm';

  @override
  String get quantity => 'Số lượng';

  @override
  String get noRatingsYet => 'Chưa có đánh giá';

  @override
  String get ratingAndReviews => 'Đánh giá và Nhận xét';

  @override
  String get totalReviewsAndRatings => 'Tổng số đánh giá và xếp hạng';

  @override
  String get ourMostLoveChewTreats => 'Những món ăn ngon nhất của chúng tôi';

  @override
  String get allCategories => 'Tất cả danh mục';

  @override
  String get thereAreNoCategories =>
      'Hiện không có danh mục nào. Theo dõi các danh mục của bạn ở đây.';

  @override
  String get searchForProduct => 'Tìm kiếm sản phẩm';

  @override
  String get atThisTimeThere => 'Hiện tại, không có sản phẩm hoặc danh mục nào';

  @override
  String get goToCart => 'ĐI ĐẾN GIỎ HÀNG';

  @override
  String get addToCart => 'THÊM VÀO GIỎ HÀNG';

  @override
  String get orderSuccessfullyPlaced => 'Đặt hàng thành công';

  @override
  String get yorOrderHasBeen => 'Đơn hàng của bạn đã được đặt thành công';

  @override
  String get goToOrderList => 'Đi đến Danh sách Đơn hàng';

  @override
  String get choosePaymentMethod => 'Chọn phương thức thanh toán';

  @override
  String get chooseYourConvenientPayment => 'Chọn Phương Thức Thanh Toán Thuận Tiện Của Bạn.';

  @override
  String get placeOrder => 'Đặt hàng';

  @override
  String get confirmOrder => 'Xác nhận đơn hàng';

  @override
  String get doYouConfirmThisPayment => 'Bạn có xác nhận thanh toán này không';

  @override
  String get wishlist => 'Danh sách mong muốn';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist =>
      'Hiện không có sản phẩm nào trong danh sách mong muốn của bạn. Hãy bắt đầu thêm các mặt hàng bạn yêu thích để lưu chúng cho sau này.';

  @override
  String get price => 'Giá';

  @override
  String get productBrands => 'Thương hiệu sản phẩm';

  @override
  String get searchBrand => 'Tìm kiếm Thương hiệu';

  @override
  String get more => 'Thêm';

  @override
  String get rating => 'Xếp hạng';

  @override
  String get weight => 'Trọng lượng';

  @override
  String get clearFilter => 'Xóa bộ lọc';

  @override
  String get applyFilter => 'Áp dụng bộ lọc';

  @override
  String get orderPlaced => 'Đơn hàng được đặt';

  @override
  String get processing => 'Đang xử lý';

  @override
  String get delivered => 'Đã giao hàng';

  @override
  String get unpaid => 'Chưa thanh toán';

  @override
  String get parchasedProducts => 'Sản phẩm đã mua';

  @override
  String get productAmount => 'Tổng số sản phẩm';

  @override
  String get filterBy => 'Lọc theo';

  @override
  String get bookingStatus => 'Trạng thái đặt hàng';

  @override
  String get apply => 'Áp dụng';

  @override
  String get searchOrder => 'Tìm kiếm đơn hàng';

  @override
  String get zalo => "Zalo";

  @override
  String get product => "Sản phẩm";

  @override
  String get alreadyBookedNote => 'Nếu bạn đã đặt Grow trên web, vui lòng đặt lại mật khẩu bằng địa chỉ email của bạn.';

}
