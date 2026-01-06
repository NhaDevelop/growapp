import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/common_app_dialog.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/evaluation/evaluation_repository.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/stylist_evaluation_model.dart';

class StylistEvaluationScreen extends StatefulWidget {
  final StylistEvaluationData evaluationData;
  final int? bookingId;
  final int? submitStatus; // 0 = not submitted, 1 = already submitted

  const StylistEvaluationScreen({
    super.key,
    required this.evaluationData,
    this.bookingId,
    this.submitStatus,
  });

  @override
  State<StylistEvaluationScreen> createState() =>
      _StylistEvaluationScreenState();
}

class _StylistEvaluationScreenState extends State<StylistEvaluationScreen> {
  String? selectedTechnique;
  String? selectedCommunication;
  String? selectedAttitude;
  String? selectedRequestAgain;
  final TextEditingController stylistNameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // New state variables
  bool isLoading = true;
  bool isAlreadySubmitted = false;
  String evaluationStatus = 'Not Submitted';

  @override
  void initState() {
    super.initState();
    _checkEvaluationStatus();
  }

  Future<void> _checkEvaluationStatus() async {
    log('🔍 [EVAL STATUS] Starting status check...');
    log('🔍 [EVAL STATUS] submitStatus param: ${widget.submitStatus}');
    log('🔍 [EVAL STATUS] bookingId param: ${widget.bookingId}');

    // Check if submitStatus was passed from notification
    if (widget.submitStatus != null) {
      log('📊 Submit status from notification: ${widget.submitStatus}');
      final willShowForm = widget.submitStatus != 1;
      log('🔍 [EVAL STATUS] Will show form: $willShowForm (submitStatus=${widget.submitStatus})');

      setState(() {
        isAlreadySubmitted = widget.submitStatus == 1;
        isLoading = false;
      });

      if (isAlreadySubmitted) {
        log('✅ Evaluation already submitted (from notification data)');
      } else {
        log('📝 Showing evaluation form (submit_status = 0)');
      }
      return;
    }

    // Check local storage first to see if this evaluation was already submitted
    if (widget.bookingId != null) {
      final isSubmittedLocally =
          await isEvaluationSubmittedLocally(widget.bookingId!);

      if (isSubmittedLocally) {
        log('✅ Evaluation already submitted (found in local storage)');
        setState(() {
          isAlreadySubmitted = true;
          isLoading = false;
        });
        return;
      }
    }

    // IMPORTANT: The backend API check-questionnaire-status is unreliable
    // It returns "already submitted" even for new evaluations
    // Solution: Always show the form and let the submit API handle duplicates
    log('⚠️ Skipping API status check (unreliable backend API)');
    log('📝 Always showing form - submit API will handle duplicates');

    setState(() {
      isLoading = false;
      isAlreadySubmitted = false; // Always show form
    });

    /* DISABLED: Backend API is broken, returns wrong status
    // Fallback: check via API if no submitStatus provided
    if (widget.bookingId == null) {
      log('⚠️ No booking ID provided, showing form');
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      log('🔍 Checking evaluation status for booking ${widget.bookingId}...');
      final status = await checkEvaluationStatus(widget.bookingId!);
      log('📊 Received status: "$status"');
      log('🔍 [EVAL STATUS] Status uppercase: "${status.toUpperCase()}"');

      // Only treat as submitted if status is explicitly "Submitted" or "ALREADY_SUBMITTED"
      final isSubmitted = status.toUpperCase() == 'SUBMITTED' ||
          status.toUpperCase() == 'ALREADY_SUBMITTED';

      log('🔍 [EVAL STATUS] Is submitted check result: $isSubmitted');
      log('🔍 [EVAL STATUS] Will show form: ${!isSubmitted}');

      setState(() {
        evaluationStatus = status;
        isAlreadySubmitted = isSubmitted;
        isLoading = false;
      });

      if (isAlreadySubmitted) {
        log('✅ Evaluation already submitted for booking ${widget.bookingId}');
      } else {
        log('📝 Showing evaluation form (status: $status)');
      }
    } catch (e) {
      log('⚠️ Error checking evaluation status: $e');
      log('📝 Defaulting to show form due to error');
      setState(() {
        isLoading = false;
        isAlreadySubmitted = false; // Default to showing form on error
      });
    }
    */
  }

  @override
  void dispose() {
    stylistNameController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> submitEvaluation() async {
    if (selectedTechnique == null ||
        selectedCommunication == null ||
        selectedAttitude == null ||
        selectedRequestAgain == null) {
      toast('Please answer all questions');
      return;
    }

    // Show loading
    appStore.setLoading(true);

    try {
      final status = await submitStylistEvaluation(
        bookingId: widget.bookingId ?? 0,
        technique: selectedTechnique!,
        communication: selectedCommunication!,
        friendly: selectedAttitude!,
        requestSameStylish: selectedRequestAgain!,
        stylistName: stylistNameController.text.trim(),
        message: messageController.text.trim(),
      );

      appStore.setLoading(false);

      // Handle different statuses
      if (status.toLowerCase().contains('success')) {
        // Save to local storage
        if (widget.bookingId != null) {
          await markEvaluationAsSubmittedLocally(widget.bookingId!);
          log('💾 Saved submission status to local storage');
        }

        // Show success dialog popup (like booking confirmation)
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (BuildContext context) => CommonAppDialog(
            title: _getThankYouTitle(),
            icon: ic_booking_success,
            subTitle: _getSuccessMessage(),
            buttonText: _getDoneButtonText(),
            onTap: () {
              finish(context); // Close dialog
              finish(context); // Close evaluation screen
            },
          ),
        );
      } else if (status.toLowerCase().contains('submitted')) {
        toast('You have already submitted this evaluation');
        setState(() {
          isAlreadySubmitted = true;
        });
      } else if (status.toLowerCase().contains('payment')) {
        toast('Payment has not been confirmed yet');
      } else {
        toast('Failed to submit evaluation. Please try again.');
      }
    } catch (e) {
      appStore.setLoading(false);
      toast('Failed to submit evaluation. Please try again.');
      log('❌ Error submitting evaluation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Debug log to see what's being rendered
    if (!isLoading) {
      log('🎨 [EVAL RENDER] isAlreadySubmitted: $isAlreadySubmitted, showing: ${isAlreadySubmitted ? "Thank You" : "Form"}');
    }

    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: widget.bookingId != null
            ? '#${widget.bookingId} ${widget.evaluationData.title} '
            : widget.evaluationData.title,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isAlreadySubmitted
              ? _buildThankYouWidget()
              : _buildEvaluationForm(),
    );
  }

  /// Build thank you widget when evaluation is already submitted
  Widget _buildThankYouWidget() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            60.height,

            // Success Icon with elevated card design (matching app pattern)
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // Main card
                Container(
                  width: context.width() - 48,
                  padding: const EdgeInsets.only(
                    left: 24,
                    top: 70,
                    right: 24,
                    bottom: 32,
                  ),
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: radius(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Thank you title
                      Text(
                        _getThankYouTitle(),
                        style: boldTextStyle(
                          size: 24,
                          color: context.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      12.height,

                      // Subtitle
                      Text(
                        _getFeedbackMattersText(),
                        style: boldTextStyle(
                          size: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      16.height,

                      // Message
                      Text(
                        _getAlreadySubmittedText(),
                        style: secondaryTextStyle(
                          size: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      8.height,
                      Text(
                        _getAppreciationText(),
                        style: secondaryTextStyle(
                          size: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      32.height,

                      // Decorative stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Icon(
                              Icons.star,
                              color: ratingBarColor,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      32.height,

                      // Divider
                      Container(
                        height: 1,
                        color: borderColor,
                      ),
                      20.height,

                      // Info text
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: scaffoldPrimaryLight,
                          borderRadius: radius(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: context.primaryColor,
                            ),
                            12.width,
                            Expanded(
                              child: Text(
                                _getInfoText(),
                                style: secondaryTextStyle(
                                  size: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.height,

                      // Close button
                      AppButton(
                        text: _getCloseButtonText(),
                        width: context.width(),
                        onTap: () => finish(context),
                        color: context.primaryColor,
                        elevation: 2,
                        textStyle: boldTextStyle(color: white),
                      ),
                    ],
                  ),
                ),

                // Floating icon (matching success dialog pattern)
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 8,
                          blurStyle: BlurStyle.normal,
                          offset: const Offset(0, 2),
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      ic_confetti_ball,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build the evaluation form
  Widget _buildEvaluationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rate_review, color: context.primaryColor, size: 20),
              8.width,
              Expanded(
                child: Text(
                  widget.evaluationData.subTitle,
                  style: secondaryTextStyle(size: 14),
                ),
              ),
            ],
          ),
          24.height,
          _buildModernQuestionCard(
            questionNumber: 1,
            title: widget.evaluationData.question1.title,
            options: widget.evaluationData.question1.options,
            selectedValue: selectedTechnique,
            onChanged: (value) => setState(() => selectedTechnique = value),
          ),
          20.height,
          _buildModernQuestionCard(
            questionNumber: 2,
            title: widget.evaluationData.question2.title,
            options: widget.evaluationData.question2.options,
            selectedValue: selectedCommunication,
            onChanged: (value) => setState(() => selectedCommunication = value),
          ),
          20.height,
          _buildModernQuestionCard(
            questionNumber: 3,
            title: widget.evaluationData.question3.title,
            options: widget.evaluationData.question3.options,
            selectedValue: selectedAttitude,
            onChanged: (value) => setState(() => selectedAttitude = value),
          ),
          20.height,
          _buildModernQuestionCard(
            questionNumber: 4,
            title: widget.evaluationData.question4.title,
            options: widget.evaluationData.question4.options,
            selectedValue: selectedRequestAgain,
            onChanged: (value) => setState(() => selectedRequestAgain = value),
          ),
          20.height,
          _buildModernTextFieldCard(
            questionNumber: 5,
            title: widget.evaluationData.question5.title,
            hint: widget.evaluationData.question5.value,
            controller: stylistNameController,
            icon: Icons.person_outline,
          ),
          20.height,
          _buildModernTextFieldCard(
            questionNumber: 6,
            title: widget.evaluationData.question6.title,
            hint: widget.evaluationData.question6.value,
            controller: messageController,
            maxLines: 4,
            icon: Icons.message_outlined,
          ),
          32.height,
          AppButton(
            text: 'Submit Evaluation',
            width: context.width(),
            onTap: submitEvaluation,
            elevation: 2,
          ),
          24.height,
        ],
      ),
    );
  }

  Widget _buildModernQuestionCard({
    required int questionNumber,
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with number and title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$questionNumber',
                    style: boldTextStyle(
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                12.width,
                Expanded(
                  child: Text(
                    title,
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.1),
          ),

          // Horizontal options with equal spacing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map((option) {
                final isSelected = selectedValue == option;
                final emoji = _getEmojiForOption(option);

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(option),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          // Emoji container
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.primaryColor.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.08),
                              borderRadius: radius(12),
                              border: Border.all(
                                color: isSelected
                                    ? context.primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                          8.height,
                          // Option text
                          Text(
                            option,
                            textAlign: TextAlign.center,
                            style: boldTextStyle(
                              size: 11,
                              color: isSelected
                                  ? context.primaryColor
                                  : Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getEmojiForOption(String option) {
    final lowerOption = option.toLowerCase();

    if (lowerOption.contains('excellent')) return '⭐';
    if (lowerOption.contains('good')) return '😊';
    if (lowerOption.contains('average') || lowerOption.contains('ok')) {
      return '😐';
    }
    if (lowerOption.contains('poor') || lowerOption.contains('needs work')) {
      return '⚠️';
    }
    if (lowerOption == 'yes' || lowerOption.contains('definitely')) return '✅';
    if (lowerOption == 'no') return '🚫';
    if (lowerOption.contains('maybe') || lowerOption.contains('not sure')) {
      return '🤔';
    }
    if (lowerOption.contains('so kind')) return '❤️';
    if (lowerOption.contains('kind')) return '😊';
    if (lowerOption.contains('normal')) return '😐';
    if (lowerOption.contains('not friendly')) return '😞';

    return '';
  }

  Widget _buildModernTextFieldCard({
    required int questionNumber,
    required String title,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$questionNumber',
                    style: boldTextStyle(
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                12.width,
                Icon(icon, size: 18, color: context.primaryColor),
                8.width,
                Expanded(
                  child: Text(
                    title,
                    style: boldTextStyle(
                      size: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.1),
          ),

          // Text field
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              controller: controller,
              textFieldType: TextFieldType.OTHER,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: secondaryTextStyle(size: 13, color: Colors.black38),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: radius(8),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: radius(8),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: radius(8),
                  borderSide: BorderSide(
                    color: context.primaryColor,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
  }

  // Translation helper methods
  String _getThankYouTitle() {
    return appStore.selectedLanguageCode == 'vi' ? 'Cảm ơn bạn!' : 'Thank You!';
  }

  String _getSuccessMessage() {
    return appStore.selectedLanguageCode == 'vi'
        ? 'Phản hồi của bạn đã được gửi thành công.'
        : 'Your feedback has been submitted successfully.';
  }

  String _getDoneButtonText() {
    return appStore.selectedLanguageCode == 'vi' ? 'Hoàn tất' : 'Done';
  }

  String _getFeedbackMattersText() {
    return appStore.selectedLanguageCode == 'vi'
        ? 'Phản hồi của bạn rất quan trọng'
        : 'Your Feedback Matters';
  }

  String _getAlreadySubmittedText() {
    return appStore.selectedLanguageCode == 'vi'
        ? 'Đánh giá của bạn đã được gửi.'
        : 'Your evaluation has already been submitted.';
  }

  String _getAppreciationText() {
    return appStore.selectedLanguageCode == 'vi'
        ? 'Chúng tôi đánh giá cao phản hồi quý báu của bạn!'
        : 'We appreciate your valuable feedback!';
  }

  String _getInfoText() {
    return appStore.selectedLanguageCode == 'vi'
        ? 'Phản hồi của bạn giúp chúng tôi cải thiện dịch vụ'
        : 'Your feedback helps us improve our services';
  }

  String _getCloseButtonText() {
    return appStore.selectedLanguageCode == 'vi' ? 'Đóng' : 'Close';
  }
}
