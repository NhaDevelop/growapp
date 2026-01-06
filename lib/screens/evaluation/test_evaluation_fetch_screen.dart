import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
// TODO: Uncomment when questionnaire/evaluation feature is finalized
// import 'package:grow_tokyo_app/screens/evaluation/evaluation_repository.dart';
// TODO: Uncomment when questionnaire/evaluation feature is finalized
// import 'package:grow_tokyo_app/screens/evaluation/view/stylist_evaluation_screen.dart';
// TODO: Uncomment when questionnaire/evaluation feature is finalized
// import 'package:nb_utils/nb_utils.dart';

/// Test screen to verify questionnaire fetching works
class TestEvaluationFetchScreen extends StatelessWidget {
  const TestEvaluationFetchScreen({super.key});

  // TODO: Uncomment when questionnaire/evaluation feature is finalized
  /*
  Future<void> _testFetchQuestionnaire(BuildContext context) async {
    try {
      // Show loading
      appStore.setLoading(true);
      
      log('🧪 TESTING QUESTIONNAIRE FETCH');
      log('Current language: ${appStore.selectedLanguageCode}');
      
      // Fetch the questionnaire
      final evaluationData = await fetchQuestionnaireContent();
      
      appStore.setLoading(false);
      
      log('✅ Test successful!');
      log('Title: ${evaluationData.title}');
      log('Subtitle: ${evaluationData.subTitle}');
      
      // Navigate to evaluation screen with fetched data
      StylistEvaluationScreen(
        evaluationData: evaluationData,
        bookingId: 0, // Test booking ID
      ).launch(context);
      
    } catch (e) {
      appStore.setLoading(false);
      log('❌ Test failed: $e');
      toast('Error: $e');
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Test Evaluation Fetch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Language: ${appStore.selectedLanguageCode}'),
            const SizedBox(height: 20),
            // TODO: Uncomment when questionnaire/evaluation feature is finalized
            /*
            ElevatedButton(
              onPressed: () => _testFetchQuestionnaire(context),
              child: const Text('Fetch Evaluation Form'),
            ),
            */
            ElevatedButton(
              onPressed: null, // Disabled
              child: const Text('Fetch Evaluation Form (Disabled)'),
            ),
            const SizedBox(height: 20),
            const Text(
                'This will fetch the questionnaire from API based on current language'),
          ],
        ),
      ),
    );
  }
}
