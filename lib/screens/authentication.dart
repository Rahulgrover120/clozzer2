// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard.dart';

enum VerificationState { SHOW_PHONE_NUMBER_STATE, SHOW_OTP_STATE }

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String text = '';
  String otp = '';
  String verificationId = '';

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  FirebaseAuth auth = FirebaseAuth.instance;
  VerificationState currentState = VerificationState.SHOW_PHONE_NUMBER_STATE;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.pushNamed(context, 'dashboard');
      }
    } on FirebaseAuthException catch (e) {
      // _scaffoldKey.currentState.sh
      // debugPrint(e);
    }
  }

  _onKeyboardTap(String value) {
    if (currentState == VerificationState.SHOW_PHONE_NUMBER_STATE) {
      setState(() {
        text = text + value;
      });
    } else {
      setState(() {
        otp = otp + value;
      });
    }
  }

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await _auth.signInWithCredential(credential);

        User user = result.user!;

        // if(user != null){
        Navigator.push(
            context,
            MaterialPageRoute(
                // builder: (context) => HomeScreen(user: user,)
                builder: (context) => Dashboard()));
        // }else{
        //   print("Error");
        // }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("OTP for Login"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(14.0),
                      // primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Cancel'),
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(14.0),
                      // primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      // _showToast('Next Page Button', context);

                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);

                      UserCredential result =
                          await _auth.signInWithCredential(credential);
                      User user = result.user!;

                      // _showToast('Before Navigation', context);

                      // if(user != null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => HomeScreen(user: user,) // Removed
                              builder: (context) => const Dashboard()));
                      // }else{
                      //   print("Error");
                      // }
                    },
                    child: const Text('Confirm'),
                  ),

                  // FlatButton(
                  //   child: const Text("Confirm"),
                  //   textColor: Colors.white,
                  //   color: Colors.blue,
                  //   onPressed: () async{
                  //     final code = _codeController.text.trim();
                  //     AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                  //
                  //     UserCredential result = await _auth.signInWithCredential(credential);
                  //
                  //     User user = result.user!;
                  //
                  //     // if(user != null){
                  //     Navigator.push(context, MaterialPageRoute(
                  //         // builder: (context) => HomeScreen(user: user,) // Removed
                  //        builder: (context) => const Dashboard()
                  //
                  //     ));
                  //     // }else{
                  //     //   print("Error");
                  //     // }
                  //   },
                  // )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(children: [
        Column(
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
                      currentState == VerificationState.SHOW_PHONE_NUMBER_STATE
                          ? Column(
                              children: const [
                                Text(
                                  'Enter your',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : Column(
                              children: const [
                                Text(
                                  'OTP is shared on your',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'mobile number',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 25,
                      ),
                      currentState == VerificationState.SHOW_PHONE_NUMBER_STATE
                          ? Row(
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0)),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(otp,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0)),
                              ],
                            ),
                      NumericKeyboard(
                        onKeyboardTap: _onKeyboardTap,
                        textColor: Colors.black,
                        rightButtonFn: () {
                          if (currentState ==
                              VerificationState.SHOW_PHONE_NUMBER_STATE) {
                            setState(() {
                              text = text.substring(0, text.length - 1);
                            });
                          } else {
                            setState(() {
                              otp = otp.substring(0, otp.length - 1);
                            });
                          }
                        },
                        rightIcon: Icon(
                          Icons.backspace,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      currentState == VerificationState.SHOW_PHONE_NUMBER_STATE
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70.0, vertical: 10.0),
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                // _showToast('button Pressed', context);
                                // Navigator.pushNamed(context, 'verifyOTP');

                                loginUser('+91$text', context);

                                // await auth.verifyPhoneNumber(
                                //   phoneNumber: '+91$text',
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
                                //     setState(() {
                                //       currentState =
                                //           VerificationState.SHOW_OTP_STATE;
                                //       this.verificationId = verificationId;
                                //     });
                                //   },
                                //   codeAutoRetrievalTimeout:
                                //       (String verificationId) {},
                                // );
                              },
                              child: const Text('Next'))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70.0, vertical: 10.0),
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                PhoneAuthCredential phoneAuthCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: otp);

                                signInWithPhoneAuthCredential(
                                    phoneAuthCredential);
                              },
                              child: const Text('Verify')),
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
      ]),
    );
  }

  void _showToast(String status, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(status),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
