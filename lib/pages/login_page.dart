import 'package:flutter/material.dart';

import '../services/connector.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/img.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: loginController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Login',
                    fillColor: Colors.grey.shade200,
                    filled: true),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password',
                    fillColor: Colors.grey.shade200,
                    filled: true),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  var loginText = loginController.value.text;
                  var passwordText = passwordController.value.text;

                  login(loginText, passwordText).then((value) => {
                    setState(() {
                      Navigator.pushReplacementNamed(context, 'home');
                    })
                  }).onError((error, stackTrace) =>
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: const Text('Error occurred. Try again'),
                        action: SnackBarAction(
                          label: 'Hide',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    )
                  });

                },
                child: Text(
                  'Login',
                  style: getTextStyleButton25(),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text(
              "Don't have account?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text(
                  'Create account',
                  style: getTextStyleButton25(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
