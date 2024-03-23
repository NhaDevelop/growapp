import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class DeletionConfirmDialog extends StatelessWidget {
  const DeletionConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFEB5757).withOpacity(.1),
              child: Image.asset(ic_profile_delete, height: 50),
            ),
            32.height,
            Text(
              locale.deleteAccountConfirmation,
              style: boldTextStyle(),
              textAlign: TextAlign.center,
            ),
            32.height,
            Row(
              children: [
                AppButton(
                  text: locale.cancel,
                  onTap: () => finish(context, false),
                ).expand(),
                16.width,
                AppButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  onTap: () => finish(context, true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.delete, color: Colors.white),
                      8.width,
                      Text(
                        locale.delete,
                        style: boldTextStyle(color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ).expand(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
