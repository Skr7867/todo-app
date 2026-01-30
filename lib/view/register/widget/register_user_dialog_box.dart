import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/color/app_colors.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../view_models/controller/register/user_register_controller.dart';

class LoginOtpDialogBox extends StatefulWidget {
  const LoginOtpDialogBox({super.key});

  @override
  State<LoginOtpDialogBox> createState() => LoginOtpDialogBoxState();
}

class LoginOtpDialogBoxState extends State<LoginOtpDialogBox> {
  final UserRegisterController controller = Get.find<UserRegisterController>();

  final int otpLength = 6;
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;

  bool isVerifyEnabled = false;
  String otp = '';

  @override
  void initState() {
    super.initState();

    otpControllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  void _onOtpChanged() {
    otp = otpControllers.map((e) => e.text).join();

    setState(() {
      isVerifyEnabled = otp.length == otpLength;
    });
  }

  @override
  void dispose() {
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFEFF6FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    color: AppColors.blueColor,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'Verify Email OTP',
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.opensansRegular,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter 6 - digit Email OTP',
              style: TextStyle(
                fontSize: 13,
                fontFamily: AppFonts.opensansRegular,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 OTP BOXES
            LayoutBuilder(
              builder: (context, constraints) {
                final spacing = 10 * (otpLength - 1);
                final size = (constraints.maxWidth - spacing) / otpLength;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    otpLength,
                    (index) => SizedBox(
                      width: size,
                      height: size,
                      child: _otpBox(index),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            /// 🔹 VERIFY BUTTON
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: isVerifyEnabled && !controller.isVerifyingOtp.value
                      ? () {
                          controller.verifyOtp(otp: otp, context: context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    disabledBackgroundColor: AppColors.blueColor.withValues(
                      alpha: 0.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.isVerifyingOtp.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Verify',
                          style: TextStyle(
                            fontFamily: AppFonts.opensansRegular,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 SINGLE OTP BOX
  Widget _otpBox(int index) {
    return TextField(
      controller: otpControllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      maxLength: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.blueColor),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty && index < otpLength - 1) {
          focusNodes[index + 1].requestFocus();
        }
        if (value.isEmpty && index > 0) {
          focusNodes[index - 1].requestFocus();
        }
        _onOtpChanged();
      },
    );
  }
}
