import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// Widget to display when evaluation has already been submitted
/// Shows a thank you message with an image
class EvaluationSubmittedWidget extends StatelessWidget {
  const EvaluationSubmittedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon/Image
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 120,
                color: context.primaryColor,
              ),
            ),
            32.height,
            // Thank you title
            Text(
              'Thank You!',
              style: boldTextStyle(size: 28, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            16.height,

            // Message
            Text(
              'Your evaluation has already been submitted.',
              style: secondaryTextStyle(size: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            8.height,
            Text(
              'We appreciate your feedback!',
              style: secondaryTextStyle(size: 14, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
            48.height,

            // Decorative stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 32,
                  ),
                ),
              ),
            ),
            32.height,

            // Close button
            AppButton(
              text: 'Close',
              width: context.width() * 0.6,
              onTap: () => finish(context),
              color: context.primaryColor,
              elevation: 2,
            ),
          ],
        ),
      ),
    );
  }
}
