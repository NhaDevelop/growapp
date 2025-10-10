import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/debug/firebase_debug_screen.dart';
import 'package:nb_utils/nb_utils.dart';

/// Floating Debug Button Widget
/// Add this to any screen to access Firebase Debug
class DebugFloatingButton extends StatelessWidget {
  const DebugFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {
          const FirebaseDebugScreen().launch(context);
        },
        backgroundColor: Colors.red[700],
        child: const Icon(
          Icons.bug_report,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Debug Button Widget (for adding to any screen)
class DebugButton extends StatelessWidget {
  const DebugButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        const FirebaseDebugScreen().launch(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      child: const Text('🔍 Firebase Debug'),
    );
  }
}

/// How to use these widgets:
/// 
/// 1. For Floating Button (add to any Scaffold):
/// ```dart
/// Scaffold(
///   body: YourContent(),
///   floatingActionButton: DebugFloatingButton(),
/// )
/// ```
/// 
/// 2. For Regular Button (add anywhere in your UI):
/// ```dart
/// Column(
///   children: [
///     YourOtherWidgets(),
///     DebugButton(),
///   ],
/// )
/// ```