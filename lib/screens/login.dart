import 'package:flutter/material.dart';

import '../utils/commons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: getIntColor('0065ff'),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          children: [

            Image.asset(
              'assets/icons/app_icon_512.png',
              width: 100,
              height: 100,
            ),

            SizedBox(
              height: 25,
            ),

            TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: 'E-Mail',
                hintStyle: TextStyle(color: Colors.white38),
                prefixIcon: Icon(Icons.email, color: Colors.white,),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white38, width: 1.0, style: BorderStyle.solid)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid)
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            TextField(
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white38),
                  prefixIcon: Icon(Icons.key, color: Colors.white,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white38, width: 1.0, style: BorderStyle.solid)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid)
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      obscureText = !obscureText;
                    });
                  }, icon: Icon( obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.white, ))
              ),
            ),

            SizedBox(height: 16),

            MaterialButton(
              height: 50,
              color: Colors.white,
              textColor: getIntColor('0065ff'),
              onPressed: () => {

              },
              child: Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 16),

            Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
