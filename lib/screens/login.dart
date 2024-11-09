import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/commons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscureText = true;
  bool isSignupScreen = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  controller: nameController,
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
                ),
              ),

              SizedBox(
                height: 16,
              ),

              TextFormField(
                controller: emailController,
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
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 16,
              ),

              TextFormField(
                controller: passwordController,
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
              ),

              SizedBox(height: 16),

              MaterialButton(
                height: 50,
                color: Colors.white,
                textColor: getIntColor('0065ff'),
                onPressed: () => {
                  if(formKey.currentState!.validate()){

                    if(emailController.text=="koderkashif@gmail.com" && passwordController.text=="qwerty"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TabView() ))
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid credentials'))
                      )
                    }

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
}
