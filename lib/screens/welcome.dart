import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/welcome.png'),
                fit: BoxFit.fitWidth)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: const [
                SizedBox(
                  height: 100.0,
                ),
                Text(
                  'Hi Welcome to',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'CloZzr',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'All your health data at your fingertips.',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFEBEAEC),
                    ),
                    onPressed: () {
                      // _showToast(context);
                      Navigator.pushNamed(context, 'auth');
                    },
                    child: const Text('Get Started',
                        style: TextStyle(color: Colors.black))),
                const SizedBox(
                  height: 55.0,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
