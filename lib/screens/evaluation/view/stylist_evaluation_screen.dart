import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/evaluation/evaluation_repository.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/stylist_evaluation_model.dart';

class StylistEvaluationScreen extends StatefulWidget {
  final StylistEvaluationData evaluationData;
  final int? bookingId;

  const StylistEvaluationScreen({
    super.key,
    required this.evaluationData,
    this.bookingId,
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
      await submitStylistEvaluation(
        bookingId: widget.bookingId ?? 0,
        technique: selectedTechnique!,
        communication: selectedCommunication!,
        friendly: selectedAttitude!,
        requestSameStylish: selectedRequestAgain!,
        stylistName: stylistNameController.text.trim(),
        message: messageController.text.trim(),
      );

      appStore.setLoading(false);
      toast('Thank you for your feedback!');
      finish(context);
    } catch (e) {
      appStore.setLoading(false);
      toast('Failed to submit evaluation. Please try again.');
      log('❌ Error submitting evaluation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: widget.evaluationData.title,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: SingleChildScrollView(
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
              onChanged: (value) =>
                  setState(() => selectedCommunication = value),
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
              onChanged: (value) =>
                  setState(() => selectedRequestAgain = value),
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
}
