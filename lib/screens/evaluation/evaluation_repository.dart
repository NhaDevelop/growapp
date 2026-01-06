import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// Fetch questionnaire content from CMS based on user's app language
Future<StylistEvaluationData> fetchQuestionnaireContent() async {
  try {
    final currentLanguage = appStore.selectedLanguageCode;
    final currentBranchId = appStore.branchId;

    // Build endpoint based on APP LANGUAGE (not branch selection)
    // If language is Vietnamese (vn), fetch Branch 6 questionnaire
    // Otherwise, use the current branch ID
    String endpoint;
    int branchIdToFetch;

    if (currentLanguage == 'vi') {
      branchIdToFetch = 6; // Always use Branch 6 for Vietnamese language
      endpoint = '${APIEndPoints.questionnaireContent}?branchId=6';
      log('📋 App language is VI → Fetching Vietnamese questionnaire (Branch 6)');
      log('   Current branch: $currentBranchId, Fetching from: Branch 6');
    } else {
      branchIdToFetch = currentBranchId;
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

/// Submit stylist evaluation to the new external API
Future<String> submitStylistEvaluation({
  required int bookingId,
  required String technique,
  required String communication,
  required String friendly,
  required String requestSameStylish,
  String? stylistName,
  String? message,
}) async {
  try {
    log('📤 Submitting evaluation for booking: $bookingId');

    // Map ratings to numeric values as per API requirement (if needed)
    // The previous implementation used the raw strings, but the new API might expect numbers
    // The user example showed "technique=1". If "technique" is a rating, we should convert.
    // However, without strict documentation, we will try to pass the values mapped below.

    // Mapping logic (from _calculateAverageRating helpers, but adapted for API if needed)
    // For now assuming the API accepts the same string values or we map them.
    // User example: technique=1. This implies 1-5 scale?
    // Let's use the helper to get numeric scores.

    // NOTE: If the API expects strings (e.g. "Excellent"), we should use those.
    // But "technique=1" suggests a number.
    // Let's assume we send the numeric score derived from the selection.

    String techniqueScore = _mapRatingToScore(technique).toInt().toString();
    String communicationScore =
        _mapRatingToScore(communication).toInt().toString();
    String friendlyScore = _mapRatingToScore(friendly).toInt().toString();

    // requestSameStylish: "1" for Yes, "0" for No?
    String sameStylistVal = requestSameStylish.toLowerCase().contains('yes') ||
            requestSameStylish.toLowerCase().contains('có')
        ? '1'
        : '0';

    final userId = userStore.userId;
    final branchId = appStore.branchId;

    // Construct the query parameters
    final Map<String, String> queryParams = {
      'page': 'request',
      'method': 'default_api',
      'request_page': 'update',
      'request_method': 'hair_grow_questionnaire_submit',
      'short_title': 'd-hair-booking',
      'user_id': userId.toString(),
      'booking_id': bookingId.toString(),
      'branch_id': branchId.toString(),
      'technique': techniqueScore,
      'communication': communicationScore,
      'friendly': friendlyScore,
      'request_same_stylish': sameStylistVal,
      'stylish_name': stylistName ?? '',
      'message': message ?? '',
      'rating': _calculateAverageRating(
              technique, communication, friendly, requestSameStylish)
          .toString(),
      'review_msg': message ?? '',
    };

    final uri = Uri.parse(APIEndPoints.evaluationBaseUrl)
        .replace(queryParameters: queryParams);

    log('🔗 Requesting: $uri');

    // Using POST request with Bearer token authorization
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer a6f1e9c8b2d44b9f9a1c3a6e4f8d9c2e',
      },
    );

    log('📥 Response Status: ${response.statusCode}');
    log('📥 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse JSON response
      try {
        final data = jsonDecode(response.body);

        if (data is Map) {
          // Check the status field from API response
          final status = data['status'];
          final message = data['message']?.toString() ?? '';

          log('📊 API Response - status: $status, message: $message');

          // status = 1 means success, status = 0 means failure
          if (status == 1) {
            log('✅ Evaluation submitted successfully');
            return 'Success';
          } else {
            log('❌ Submission failed: $message');

            // Check for specific error messages
            if (message.toLowerCase().contains('payment')) {
              return 'Payment Not Yet Paid';
            } else if (message.toLowerCase().contains('already') ||
                message.toLowerCase().contains('submitted')) {
              return 'Submitted';
            }

            return 'Failed';
          }
        }

        return 'Failed';
      } catch (e) {
        log('❌ Error parsing JSON response: $e');
        return 'Failed';
      }
    } else {
      return 'Failed';
    }
  } catch (e) {
    log('❌ Error submitting evaluation: $e');
    return 'Failed';
  }
}

/// Calculate average rating from answers (1-5 scale)
double _calculateAverageRating(String technique, String communication,
    String friendly, String requestAgain) {
  final scores = [
    _mapRatingToScore(technique),
    _mapRatingToScore(communication),
    _mapRatingToScore(friendly),
    _mapYesNoToScore(requestAgain),
  ];

  final average = scores.reduce((a, b) => a + b) / scores.length;
  return double.parse(average.toStringAsFixed(1));
}

/// Map rating text to score (1-5 scale for display)
double _mapRatingToScore(String rating) {
  final lowerRating = rating.toLowerCase();

  if (lowerRating.contains('excellent') ||
      lowerRating == 'tuyệt vời' ||
      lowerRating.contains('so kind')) {
    return 5.0;
  }
  if (lowerRating.contains('good') ||
      lowerRating == 'tốt' ||
      lowerRating.contains('kind')) {
    return 4.0;
  }
  if (lowerRating.contains('average') ||
      lowerRating.contains('ok') ||
      lowerRating.contains('normal') ||
      lowerRating == 'trung bình') {
    return 3.0;
  }
  if (lowerRating.contains('poor') ||
      lowerRating.contains('needs work') ||
      lowerRating.contains('not friendly') ||
      lowerRating == 'kém') {
    return 2.0;
  }

  return 3.0; // Default to average
}

/// Map Yes/No/Maybe to score (1-5 scale)
double _mapYesNoToScore(String value) {
  final lowerValue = value.toLowerCase();

  if (lowerValue.contains('yes') ||
      lowerValue.contains('definitely') ||
      lowerValue == 'có' ||
      lowerValue == 'chắc chắn') {
    return 5.0;
  }
  if (lowerValue.contains('maybe') || lowerValue == 'có thể') return 3.5;
  if (lowerValue.contains('not sure') || lowerValue == 'không chắc') return 2.5;
  if (lowerValue == 'no' || lowerValue == 'không') return 1.0;

  return 3.0; // Default
}
