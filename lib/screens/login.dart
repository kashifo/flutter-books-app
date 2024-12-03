import 'package:books_app/utils/Enumz.dart';
import 'package:books_app/utils/shared_prefs_helper.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../utils/commons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  bool isSignupScreen = false;
  final formKey = GlobalKey<FormState>();
  String? name, email, password;
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Form(
        key: formKey,
        child: Center(
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

              Visibility(
                visible: isSignupScreen,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    prefixIcon: Icon(Icons.person, color: Colors.white,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white38, width: 1.0, style: BorderStyle.solid)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid)
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.white54),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                ),
              ),

              SizedBox(
                height: 16,
              ),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.email, color: Colors.white,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white38, width: 1.0, style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid)
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white54),
                  floatingLabelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if( !GetUtils.isEmail(value) ){
                    return 'Please enter a valid email';
                  }

                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),

              SizedBox(
                height: 16,
              ),

              TextFormField(
                obscureText: obscureText,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
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
                    }, icon: Icon( obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: Colors.white, )),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white54),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),

              SizedBox(height: 16),

              MaterialButton(
                height: 50,
                color: Colors.white,
                textColor: getIntColor('0065ff'),
                onPressed: () => {
                  if(formKey.currentState!.validate()){
                    formKey.currentState?.save(),
                    proceedToLogin()
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill in the details'),)
                    )
                  }
                },
                child: Text(isSignupScreen ? 'SIGN UP' : 'LOGIN', style: TextStyle(fontWeight: FontWeight.bold),),
              ),

              SizedBox(height: 16),

              InkWell(
                onTap: (){
                  setState(() {
                    isSignupScreen = !isSignupScreen;
                  });
                },
                child: Text(
                  isSignupScreen ? 'Already have an account? Login' : 'Don\'t have an account? Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  proceedToLogin() async {

    try {
      if(isSignupScreen){
        await auth.signUp(email!, password!);
        auth.updateProfile(displayName: name!);
      } else {
        await auth.signIn(email!, password!);
      }

      if(auth.isSignedIn){
        print('signin suxus');
        SharedPrefsHelper().setBool(Enumz.isLoggedIn.name, true);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => TabView()),
              (Route<dynamic> route) => false,
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }

  }//proceedToLogin

}
