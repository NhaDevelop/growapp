import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/modal_header.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

class AddReferralCodeModal extends StatelessWidget {
  const AddReferralCodeModal({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return SizedBox(
      height: context.height() * 0.5,
      child: Column(
        children: [
          ModalHeader(title: locale.addReferralCode),
          Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: locale.referralCode,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: textController,
              ).expand(),
              AppButton(
                text: locale.apply,
                width: context.width(),
                color: context.primaryColor,
                textColor: Colors.white,
                onTap: () => finish(context, textController.text),
              ),
            ],
          ).paddingSymmetric(horizontal: 16).expand(),
          48.height,
        ],
      ),
    );
  }
}
