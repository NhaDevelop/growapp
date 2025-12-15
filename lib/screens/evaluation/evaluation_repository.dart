
import 'package:nb_utils/nb_utils.dart';
import '../../../main.dart';
import '../../../network/network_utils.dart';

/// Submit stylist evaluation to backend - TESTING BOTH ENDPOINTS
Future<void> submitStylistEvaluation({
  required int bookingId,
  required String technique,
  required String communication,
  required String friendly,
  required String requestSameStylish,
  String? stylistName,
  String? message,
}) async {
  try {
    // Map the values to match API parameters
    final techniqueNum = _mapRatingToNumber(technique);
    final communicationNum = _mapRatingToNumber(communication);
    final friendlyNum = _mapRatingToNumber(friendly);
    final requestNum = _mapYesNoToNumber(requestSameStylish);

    // Debug: Log all input parameters
    log('═══════════════════════════════════════════════════════');
    log('📤 TESTING BOTH EVALUATION ENDPOINTS');
    log('═══════════════════════════════════════════════════════');
    log('📋 Input Parameters:');
    log('  - Booking ID: $bookingId');
    log('  - User ID: ${userStore.userId}');
    log('  - Technique: "$technique" → $techniqueNum');
    log('  - Communication: "$communication" → $communicationNum');
    log('  - Friendly: "$friendly" → $friendlyNum');
    log('  - Request Same Stylish: "$requestSameStylish" → $requestNum');
    log('  - Stylish Name: "${stylistName ?? '(empty)'}"');
    log('  - Message: "${message ?? '(empty)'}"');
    log('═══════════════════════════════════════════════════════');

    // ENDPOINT 1: booking_questionnair
    final url1 = 'https://api-project.camboinfo.com/'
        '?page=request'
        '&method=default'
        '&request_page=update'
        '&request_method=booking_questionnair'
        '&short_title=1'
        '&booking_id=$bookingId'
        '&technique=$techniqueNum'
        '&communication=$communicationNum'
        '&friendly=$friendlyNum'
        '&request_same_stylish=$requestNum'
        '&stylish_name=${Uri.encodeComponent(stylistName ?? '')}'
        '&message=${Uri.encodeComponent(message ?? '')}';

    log('🔵 ENDPOINT 1: booking_questionnair');
    log(url1);
    log('───────────────────────────────────────────────────────');

    try {
      final response1 =
          await buildHttpResponse(url1, method: HttpMethodType.POST);
      log('📥 Response 1: Status ${response1.statusCode}, Body: "${response1.body}"');

      if (response1.statusCode == 200) {
        log('✅ ENDPOINT 1 WORKS!');
        log('═══════════════════════════════════════════════════════');
        return;
      }
    } catch (e) {
      log('❌ Endpoint 1 failed: $e');
    }

    log('───────────────────────────────────────────────────────');

    // ENDPOINT 2: hair_grow_notification
    final url2 = 'https://api-project.camboinfo.com/'
        '?page=request'
        '&method=default'
        '&request_page=insert'
        '&request_method=hair_grow_notification'
        '&short_title=d-cms_hg'
        '&user_id=${userStore.userId}'
        '&booking_id=$bookingId';

    log('🟢 ENDPOINT 2: hair_grow_notification');
    log(url2);
    log('───────────────────────────────────────────────────────');

    try {
      final response2 =
          await buildHttpResponse(url2, method: HttpMethodType.POST);
      log('📥 Response 2: Status ${response2.statusCode}, Body: "${response2.body}"');

      if (response2.statusCode == 200) {
        log('✅ ENDPOINT 2 WORKS!');
        log('═══════════════════════════════════════════════════════');
        return;
      }
    } catch (e) {
      log('❌ Endpoint 2 failed: $e');
    }

    log('═══════════════════════════════════════════════════════');
    log('❌ BOTH ENDPOINTS FAILED');
    log('═══════════════════════════════════════════════════════');
    throw 'Both endpoints failed. Check logs above.';
  } catch (e) {
    log('❌ Error: $e');
    throw e;
  }
}

/// Map rating text to number (1-4)
int _mapRatingToNumber(String rating) {
  switch (rating.toLowerCase()) {
    case 'excellent':
      return 1;
    case 'good':
      return 2;
    case 'average':
    case 'ok':
      return 3;
    case 'poor':
    case 'needs work':
      return 4;
    default:
      return 3;
  }
}

/// Map Yes/No/Maybe to number (1-4 to match backend)
int _mapYesNoToNumber(String value) {
  switch (value.toLowerCase()) {
    case 'yes':
    case 'yes, definitely':
    case 'definitely':
      return 1;
    case 'maybe':
      return 2;
    case 'not sure':
      return 3;
    case 'no':
      return 4;
    default:
      return 3; // Default to "not sure"
  }
}
