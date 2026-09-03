import 'dart:convert';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../main.dart';
import 'model/stylist_evaluation_model.dart';

// ============================================================================
// LOCAL STORAGE HELPERS FOR TRACKING SUBMITTED EVALUATIONS
// ============================================================================

/// Check if an evaluation has been submitted locally
Future<bool> isEvaluationSubmittedLocally(int bookingId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final submittedIds = prefs.getStringList('submitted_evaluations') ?? [];
    final isSubmitted = submittedIds.contains(bookingId.toString());
    log('🔍 Checking local storage for booking $bookingId: ${isSubmitted ? "SUBMITTED" : "NOT SUBMITTED"}');
    return isSubmitted;
  } catch (e) {
    log('⚠️ Error checking local submission status: $e');
    return false;
  }
}

/// Mark an evaluation as submitted locally
Future<void> markEvaluationAsSubmittedLocally(int bookingId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final submittedIds = prefs.getStringList('submitted_evaluations') ?? [];

    if (!submittedIds.contains(bookingId.toString())) {
      submittedIds.add(bookingId.toString());
      await prefs.setStringList('submitted_evaluations', submittedIds);
      log('✅ Marked booking $bookingId as submitted locally');
    }
  } catch (e) {
    log('⚠️ Error saving submission status: $e');
  }
}

// ============================================================================
// API FUNCTIONS
// ============================================================================

// Fetch submitted evaluation data for a booking (not needed for new API — always returns null gracefully)
Future<Map<String, dynamic>?> fetchSubmittedEvaluationData(
    int bookingId) async {
  // The new feedback API (web-booking) does not expose submitted answers
  // We return null so the caller falls back to showing the form
  log('ℹ️ fetchSubmittedEvaluationData: new API does not support read-back, returning null');
  return null;
}

// Fetch staff name from CMS booking-detail API
Future<String?> fetchQuestionnaireStaffName(int bookingId) async {
  try {
    // Use CMS booking-detail to get the employee (staff) name
    final uri = Uri.parse('${BuildConfig.baseUrl}booking-detail?id=$bookingId');

    log('🔗 Fetching staff name from CMS for booking $bookingId');
    log('📍 API URL: $uri');

    final response = await http.get(
      uri,
      headers: buildHeaderTokens(),
    );

    log('📥 Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // CMS returns employee_name at top level of booking data
      final bookingData = data['data'];
      if (bookingData != null) {
        final staffName = bookingData['employee_name']?.toString();
        if (staffName != null && staffName.isNotEmpty) {
          log('✅ Staff name fetched: $staffName');
          return staffName;
        }
      }
    }
    log('⚠️ No staff name found for booking $bookingId');
    return null;
  } catch (e) {
    log('❌ Error fetching staff name: $e');
    return null; // Non-fatal — form will show without staff name pre-filled
  }
}

// Fetch questionnaire content from CMS based on user's app language
Future<StylistEvaluationData> fetchQuestionnaireContent(
    {int? bookingId}) async {
  try {
    final currentLanguage = appStore.selectedLanguageCode;
    final currentBranchId = appStore.branchId;

    // Build endpoint based on APP LANGUAGE (not branch selection)
    // If language is Vietnamese (vn), fetch Branch 6 questionnaire
    // Otherwise, use the current branch ID
    String endpoint;

    if (currentLanguage == 'vi') {
      endpoint = '${APIEndPoints.questionnaireContent}?branchId=6';
      log('📋 App language is VI → Fetching Vietnamese questionnaire (Branch 6)');
      log('   Current branch: $currentBranchId, Fetching from: Branch 6');
    } else {
      endpoint =
          '${APIEndPoints.questionnaireContent}?branchId=$currentBranchId';
      log('📋 App language is $currentLanguage → Fetching questionnaire for branch $currentBranchId');
    }

    final response =
        await buildHttpResponse(endpoint, method: HttpMethodType.GET);

    if (response.statusCode == 200) {
      final responseData = await handleResponse(response);

      // Extract evaluation data based on language
      Map<String, dynamic> evaluationJson;

      // For Vietnamese language, prioritize Vietnamese content
      if (currentLanguage == 'vi' && responseData.containsKey('json_data_vn')) {
        evaluationJson = responseData['json_data_vn'];
        log('✅ Using Vietnamese content (json_data_vn)');
      } else if (responseData.containsKey('json_data')) {
        evaluationJson = responseData['json_data'];
        log('✅ Using English content (json_data)');
      } else {
        evaluationJson = responseData;
        log('✅ Using default content');
      }

      final evaluationData = StylistEvaluationData.fromJson(evaluationJson);

      // Fetch staff name if booking ID is provided
      if (bookingId != null) {
        final staffName = await fetchQuestionnaireStaffName(bookingId);
        if (staffName != null) {
          // Create a new instance with staff name
          return StylistEvaluationData(
            title: evaluationData.title,
            subTitle: evaluationData.subTitle,
            question1: evaluationData.question1,
            question2: evaluationData.question2,
            question3: evaluationData.question3,
            question4: evaluationData.question4,
            question5: evaluationData.question5,
            question6: evaluationData.question6,
            staffName: staffName,
          );
        }
      }

      log('✅ Questionnaire fetched: ${evaluationData.title}');

      return evaluationData;
    } else {
      log('❌ Failed to fetch questionnaire: ${response.statusCode}');
      throw 'Failed to fetch evaluation form. Please try again.';
    }
  } catch (e, stackTrace) {
    log('❌ Error fetching questionnaire: $e');
    log('📋 Stack trace: $stackTrace');
    rethrow;
  }
}

Future<String> checkEvaluationStatus(int bookingId) async {
  try {
    log('🔍 Checking evaluation status for booking: $bookingId');

    // For now, we assume not submitted as we don't have a reliable check API
    // The user flow is handled by submit returning 'Submitted' if duplicate
    return 'Not Submitted';

    /*
    final url = '${APIEndPoints.checkEvaluationStatus}?booking_id=$bookingId';
    final response = await buildHttpResponse(url, method: HttpMethodType.GET);

    if (response.statusCode == 200) {
      final responseData = await handleResponse(response);
      String status = 'Not Submitted';
      if (responseData is Map<String, dynamic>) {
        status = responseData['status']?.toString() ?? 'Not Submitted';
      } else if (responseData is String) {
        status = responseData;
      }
      return status;
    } else {
      return 'Not Submitted';
    }
    */
  } catch (e) {
    log('⚠️ Error checking evaluation status: $e');
    return 'Not Submitted';
  }
}

/// Submit stylist evaluation using the new feedback API
/// POST /web-booking/?page=feed_back&method=submit_stylist_feed_back_api
/// &booking_id={id}&user_id={id}
/// Body (form data): question_1..5
/// question_1..4: 1-based index of selected option (position in CMS options list)
/// question_5: free text
Future<String> submitStylistEvaluation({
  required int bookingId,
  int? q1Index,   // 1-based position of selected option for question 1
  int? q2Index,   // 1-based position of selected option for question 2
  int? q3Index,   // 1-based position of selected option for question 3
  int? q4Index,   // 1-based position of selected option for question 4
  String? message, // question_5: free-text comment
  // Legacy params kept for callers not yet updated (ignored)
  String? technique,
  String? communication,
  String? friendly,
  String? requestSameStylish,
  String? stylistName,
}) async {
  try {
    log('📤 Submitting feedback for booking: $bookingId (new API)');

    final userId = userStore.userId;

    // Use position indices directly — no text mapping needed
    final q1 = (q1Index ?? 0).toString();
    final q2 = (q2Index ?? 0).toString();
    final q3 = (q3Index ?? 0).toString();
    final q4 = (q4Index ?? 0).toString();
    final q5 = message?.trim() ?? '';

    final uri = Uri.parse(BuildConfig.webBookingBaseUrl).replace(queryParameters: {
      'page': 'feed_back',
      'method': 'submit_stylist_feed_back_api',
      'booking_id': bookingId.toString(),
      'user_id': userId.toString(),
    });

    log('🔗 Requesting: $uri');
    log('📝 Form data: q1=$q1, q2=$q2, q3=$q3, q4=$q4, q5=$q5');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'question_1': q1,
        'question_2': q2,
        'question_3': q3,
        'question_4': q4,
        'question_5': q5,
      },
    );

    log('📥 Response Status: ${response.statusCode}');
    log('📥 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data is Map) {
          final status = data['status'];
          final msg = data['message']?.toString() ?? '';
          log('📊 API Response - status: $status, message: $msg');

          if (status == 1) {
            log('✅ Feedback submitted successfully');
            return 'Success';
          } else if (msg.toLowerCase().contains('already') ||
              msg.toLowerCase().contains('submitted')) {
            log('⚠️ Already submitted');
            return 'Submitted';
          } else {
            log('❌ Submission failed: $msg');
            return 'Failed';
          }
        }
        return 'Failed';
      } catch (e) {
        log('❌ Error parsing response: $e');
        return 'Failed';
      }
    } else {
      log('❌ HTTP ${response.statusCode}');
      return 'Failed';
    }
  } catch (e) {
    log('❌ Error submitting feedback: $e');
    return 'Failed';
  }
}
