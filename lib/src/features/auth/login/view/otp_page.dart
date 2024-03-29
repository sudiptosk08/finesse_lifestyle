import 'dart:async';

import 'package:finesse/components/appbar/k_app_bar.dart';
import 'package:finesse/components/button/k_button.dart';
import 'package:finesse/core/base/base_state.dart';
import 'package:finesse/src/features/auth/signup/controller/otp_controller.dart';
import 'package:finesse/styles/k_colors.dart';
import 'package:finesse/styles/k_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  final String? phoneNumber;
  final String? localName;

  const OtpPage({
    Key? key,
    this.phoneNumber,
    this.localName,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otp = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  // String? localName;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    // getData();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: KAppBar(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  widget.localName.toString(),
                  style: KTextStyle.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Phone Number Verification',
                  style: KTextStyle.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: "${widget.phoneNumber}",
                        style: KTextStyle.subtitle1,
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 80,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: KTextStyle.subtitle1,
                    length: 4,
                    obscureText: false,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 1,
                      fieldHeight: 50,
                      fieldWidth: 45,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 100),
                    enableActiveFill: false,
                    errorAnimationController: errorController,
                    controller: otp,
                    keyboardType: TextInputType.number,
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                    onChanged: (String value) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "Please fill up all the cells properly" : "",
                  style:
                      KTextStyle.subtitle1.copyWith(color: KColor.errorRedText),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: KTextStyle.dialog.copyWith(color: KColor.blackbg),
                  ),
                  Consumer(builder: (context, ref, _) {
                    final authState = ref.watch(otpProvider);
                    return TextButton(
                      onPressed: () {
                        if (authState is! LoadingState) {
                          if (_formKey.currentState!.validate()) {
                            ref.read(otpProvider.notifier).otpSendAgain(
                                  phone: widget.phoneNumber.toString(),
                                );
                          }
                        }
                      },
                      child: Text(
                        authState is LoadingState ? 'Please wait...' : 'Resend',
                        style: KTextStyle.subtitle1.copyWith(
                          color: KColor.blackbg,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(otpProvider);
                  return KButton(
                    title: authState is LoadingState
                        ? 'Please wait...'
                        : 'Active Account',
                    onTap: () {
                      if (authState is! LoadingState) {
                        if (_formKey.currentState!.validate()) {
                          ref.read(otpProvider.notifier).otpSend(
                                phone: widget.phoneNumber.toString(),
                                otp: otp.text,
                              );
                        }
                      }
                      Navigator.pushNamed(context, '/mainScreen');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
