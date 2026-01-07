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

    // Pre-fill stylist name if available from API
    if (widget.evaluationData.staffName != null) {
      stylistNameController.text = widget.evaluationData.staffName!;
      log('✅ Pre-filled stylist name: ${widget.evaluationData.staffName}');
    }

    _checkEvaluationStatus();
  }

  Future<void> _checkEvaluationStatus() async {
    // Check if submitStatus was passed from notification
    if (widget.submitStatus != null) {
      log('📊 Submit status from notification: ${widget.submitStatus}');

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
        // Load the submitted data to show in thank you screen
        await _loadSubmittedData();
        return;
      }
    }

    // Check backend for submitted data (for cross-device sync)
    if (widget.bookingId != null) {
      try {
        final data = await fetchSubmittedEvaluationData(widget.bookingId!);

        if (data != null) {
          log('✅ Evaluation already submitted, loading data for Thank You screen');
          // Sync local storage so notification icon updates
          await markEvaluationAsSubmittedLocally(widget.bookingId!);
          setState(() {
            isAlreadySubmitted = true;
            isLoading = false;
          });
          await _loadSubmittedData();
          return;
        }
      } catch (e) {
        log('⚠️ Backend check failed: $e - showing form');
      }
    }

    setState(() {
      isLoading = false;
      isAlreadySubmitted = false; // Show form
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
    // Validation check removed to allow partial submission
    if (selectedTechnique == null &&
        selectedCommunication == null &&
        selectedAttitude == null &&
        selectedRequestAgain == null) {
      toast('Please answer at least one question');
      return;
    }

    // Show loading
    appStore.setLoading(true);

    try {
      final status = await submitStylistEvaluation(
        bookingId: widget.bookingId ?? 0,
        technique: selectedTechnique,
        communication: selectedCommunication,
        friendly: selectedAttitude,
        requestSameStylish: selectedRequestAgain,
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
            16.height,

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

                      // Rich Rating Summary - 4 Columns
                      if (selectedTechnique != null ||
                          selectedCommunication != null ||
                          selectedAttitude != null ||
                          selectedRequestAgain != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. Technique
                              if (selectedTechnique != null)
                                Expanded(
                                  child: _buildRatingSummaryRow(
                                    label: 'Technique',
                                    value: selectedTechnique!,
                                  ),
                                ),

                              // 2. Communication
                              if (selectedCommunication != null)
                                Expanded(
                                  child: _buildRatingSummaryRow(
                                    label: 'Comm.',
                                    value: selectedCommunication!,
                                  ),
                                ),

                              // 3. Service
                              if (selectedAttitude != null)
                                Expanded(
                                  child: _buildRatingSummaryRow(
                                    label: 'Service',
                                    value: selectedAttitude!,
                                  ),
                                ),

                              // 4. Re-visit
                              if (selectedRequestAgain != null)
                                Expanded(
                                  child: _buildRatingSummaryRow(
                                    label: 'Re-visit',
                                    value: selectedRequestAgain!,
                                  ),
                                ),
                            ],
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

    // Technique & Communication
    if (lowerOption.contains('excellent') || lowerOption.contains('xuất sắc'))
      return '⭐';
    if (lowerOption.contains('good') || lowerOption.contains('tốt'))
      return '😊';
    if (lowerOption.contains('average') ||
        lowerOption.contains('ok') ||
        lowerOption.contains('trung bình')) {
      return '😐';
    }
    if (lowerOption.contains('poor') ||
        lowerOption.contains('needs work') ||
        lowerOption.contains('kém')) {
      return '😞';
    }

    // Request Again (Yes/No/Maybe) - CHECK MORE SPECIFIC FIRST
    if (lowerOption.contains('maybe') || lowerOption.contains('có thể')) {
      return '🤗';
    }
    if (lowerOption.contains('not sure') ||
        lowerOption.contains('không chắc')) {
      return '🤔';
    }
    // "Có" is very common, so check it last
    if (lowerOption == 'yes' ||
        lowerOption.contains('definitely') ||
        lowerOption.contains('có,') || // Check for comma "Có, chắc chắn"
        lowerOption.trim() == 'có') // Exact match
      return '✅';

    if (lowerOption == 'no' || lowerOption.contains('không(no)')) return '🚫';

    // Service / Friendliness
    if (lowerOption.contains('not friendly') ||
        lowerOption.contains('không thân thiện')) return '🚫';

    if (lowerOption.contains('so kind') ||
        lowerOption.contains('rất thân thiện')) // "Rất" first
      return '❤️';

    if (lowerOption.contains('kind') ||
        lowerOption.contains('thân thiện')) // Then just friendly
      return '😊'; // Using Smile for Kind/Friendly to differentiate from So Kind (Heart)

    if (lowerOption.contains('normal')) return '😐';

    return '';
  }

  String _generateRatingSummary() {
    List<String> summaryParts = [];

    if (selectedTechnique != null && selectedTechnique!.isNotEmpty) {
      final emoji = _getEmojiForOption(selectedTechnique!);
      summaryParts.add('$emoji $selectedTechnique');
    }

    if (selectedCommunication != null && selectedCommunication!.isNotEmpty) {
      final emoji = _getEmojiForOption(selectedCommunication!);
      summaryParts.add('$emoji $selectedCommunication');
    }

    if (selectedAttitude != null && selectedAttitude!.isNotEmpty) {
      final emoji = _getEmojiForOption(selectedAttitude!);
      summaryParts.add('$emoji $selectedAttitude');
    }

    if (selectedRequestAgain != null && selectedRequestAgain!.isNotEmpty) {
      final emoji = _getEmojiForOption(selectedRequestAgain!);
      summaryParts.add('$emoji $selectedRequestAgain');
    }

    return summaryParts.join(" • ");
  }

  Widget _buildRatingSummaryRow({
    required String label,
    required String value,
  }) {
    final emoji = _getEmojiForOption(value);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: secondaryTextStyle(size: 11, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        8.height,
        Text(
          emoji,
          style: const TextStyle(fontSize: 32), // Slightly adjusted for balance
        ),
        4.height,
        Text(
          value,
          style: boldTextStyle(size: 11, color: Colors.black87),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
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

  Future<void> _loadSubmittedData() async {
    if (widget.bookingId == null) return;

    try {
      log('🔄 Loading submitted data for booking ${widget.bookingId}...');
      final data = await fetchSubmittedEvaluationData(widget.bookingId!);

      log('📦 Fetched data: $data');

      if (data != null) {
        log('   technique: ${data['technique']} -> options: ${widget.evaluationData.question1.options}');
        log('   communication: ${data['communication']} -> options: ${widget.evaluationData.question2.options}');
        log('   friendly: ${data['friendly']} -> options: ${widget.evaluationData.question3.options}');
        log('   request_same_stylish: ${data['request_same_stylish']} -> options: ${widget.evaluationData.question4.options}');
        setState(() {
          // Map numeric scores to text options
          selectedTechnique = _mapScoreToOption(data['technique']?.toString(),
              widget.evaluationData.question1.options);
          selectedCommunication = _mapScoreToOption(
              data['communication']?.toString(),
              widget.evaluationData.question2.options);
          selectedAttitude = _mapScoreToOption(data['friendly']?.toString(),
              widget.evaluationData.question3.options);
          selectedRequestAgain = _mapScoreToOption(
              data['request_same_stylish']?.toString(),
              widget.evaluationData.question4.options);
        });
        log('✅ Mapped values:');
        log('   selectedTechnique: $selectedTechnique');
        log('   selectedCommunication: $selectedCommunication');
        log('   selectedAttitude: $selectedAttitude');
        log('   selectedRequestAgain: $selectedRequestAgain');
        log('✅ Loaded submitted data for thank you screen');
      } else {
        log('⚠️ No data returned from API');
      }
    } catch (e, stackTrace) {
      log('❌ Error loading submitted data: $e');
      log('📋 Stack trace: $stackTrace');
    }
  }

  String? _mapScoreToOption(String? score, List<String> options) {
    if (score == null) return null;

    final intScore = int.tryParse(score);
    if (intScore == null) return null;

    // Handle Yes/No question (Request same stylist)
    // Options usually: [Yes definitely, Maybe, Not sure, No]
    // Backend returns 1 (Yes) or 0 (No/Other) or 2 (Maybe - custom added)
    if (options.any((o) => o.toLowerCase().contains('yes'))) {
      if (intScore == 1) return options.first; // Yes

      // Handle "Maybe" (mapped to 2)
      if (intScore == 2) {
        return options.firstWhere(
          (o) =>
              o.toLowerCase().contains('maybe') ||
              o.toLowerCase().contains('có thể'),
          orElse: () => options.length > 1 ? options[1] : options.last,
        );
      }

      // Handle "Not sure" (mapped to 3)
      if (intScore == 3) {
        return options.firstWhere(
          (o) =>
              o.toLowerCase().contains('not sure') ||
              o.toLowerCase().contains('không chắc'),
          orElse: () => options.length > 2 ? options[2] : options.last,
        );
      }

      if (intScore == 0 && options.isNotEmpty)
        return options.last; // No (default for 0)
      return null;
    }

    // Handle Rating questions (5=Excellent/So kind, 1=Poor/Not friendly)
    // Map: 5->0, 4->1, 3->2, 2->3
    // We only use this mapping if the score is within valid rating range (2-5)
    // AND if the score is OUT of bounds for direct index mapping (e.g. score 5 for 4 options)
    // OR if we suspect it's a star rating.

    // Check if score works as direct index first (legacy) EXCEPT if it's 5 for 4 options
    bool directIndexWorks = intScore > 0 && intScore <= options.length;

    // If score is 5 and options length is 4, it's definitely a star rating mapping
    if (intScore == 5 && options.length == 4) {
      return options[0]; // 5 stars = 1st option (Best)
    }

    // If score is 4 and options length is 4, it could be "Needs work" (4th opt) OR "Good" (2nd opt, 4 stars)
    // But logs showed "technique: 4" -> displayed "Needs work".
    // This implies technique:4 IS treated as index 4.
    // So for 4, we should prefer direct index?
    // But friendly: 5.

    // Let's use a hybrid approach based on option content
    // If options start with "Excellent" or "So kind", it's a best-first list.
    bool offersBestFirst = options.first.toLowerCase().contains('excellent') ||
        options.first.toLowerCase().contains('so kind') ||
        options.first.toLowerCase().contains('tuyệt vời');

    if (offersBestFirst) {
      // If we have "Excellent" etc, we assume 5-star logic SHOULD apply
      // 5 -> Index 0
      // 4 -> Index 1
      // 3 -> Index 2
      // 2 -> Index 3
      if (intScore >= 2 && intScore <= 5) {
        final index = 5 - intScore;
        if (index >= 0 && index < options.length) {
          return options[index];
        }
      }
    }

    // Fallback to direct index mapping
    if (directIndexWorks) {
      return options[intScore - 1];
    }

    return null;
  }
}
