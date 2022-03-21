// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String text = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: size.height / 3,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 100,
                  child: Container(
                    height: 300,
                    width: 300,
                    // padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/Icon.png',
                      width: 180,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(30.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Column(
                  children: [
                    const Text(
                      'OTP is shared on your',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'mobile number',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('+91',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Color(0xFF989898))),
                        const SizedBox(width: 10),
                        Text(text,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0)),
                      ],
                    ),
                    NumericKeyboard(
                      onKeyboardTap: _onKeyboardTap,
                      textColor: Colors.black,
                      rightButtonFn: () {
                        setState(() {
                          text = text.substring(0, text.length - 1);
                        });
                      },
                      rightIcon: Icon(
                        Icons.backspace,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 10.0),
                          primary: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          debugPrint('left button clicked');
                          Navigator.pushNamed(context, 'dashboard');
                          // await auth.verifyPhoneNumber(
                          //   phoneNumber: '+919168689228',
                          //   verificationCompleted:
                          //       (PhoneAuthCredential credential) {},
                          //   verificationFailed: (FirebaseAuthException e) {
                          //     debugPrint('error printing...');
                          //     // debugPrint(e);
                          //   },
                          //   codeSent:
                          //       (String verificationId, int? resendToken) {
                          //     debugPrint('code sent...');
                          //     debugPrint(verificationId);
                          //   },
                          //   codeAutoRetrievalTimeout:
                          //       (String verificationId) {},
                          // );
                        },
                        child: const Text('Next')),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'By Creating passcode you agree with our',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Text('Terms & Conditions and Privacy Policy')
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
