import '../model/stylist_evaluation_model.dart';

/// Dummy evaluation data for testing
StylistEvaluationData getDummyEvaluationData() {
  return StylistEvaluationData(
    title: 'Stylist Evaluation',
    subTitle:
        'Please share your experience with us. Your feedback helps us improve our service.',
    question1: Question1(
      title: 'How was the technique?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    question2: Question2(
      title: 'How was the communication?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    question3: Question3(
      title: 'How was the attitude?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    question4: Question4(
      title: 'Would you request this stylist again?',
      options: ['Yes', 'No', 'Maybe', 'Not sure'],
    ),
    question5: Question5(
      title: 'Stylist name (optional)',
      value: 'Enter stylist name',
    ),
    question6: Question6(
      title: 'Additional comments (optional)',
      value: 'Share your thoughts...',
    ),
  );
}
