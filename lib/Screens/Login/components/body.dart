import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mandate_storeapp/Screens/Login/components/background.dart';
import 'package:mandate_storeapp/Screens/Signup/signup_screen.dart';
import 'package:mandate_storeapp/components/already_have_an_account_acheck.dart';
import 'package:mandate_storeapp/components/rounded_button.dart';
import 'package:mandate_storeapp/components/text_field_container.dart';
import 'package:mandate_storeapp/constants.dart';
import 'package:mandate_storeapp/mainpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mandate_storeapp/utils.dart';
import 'dart:developer' as logger;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  final SharedPref sharedPref = SharedPref();
  String token;
  Future login() async {
    final url = Uri.http("www.mandatestore.ng", '/api/login/');
    var response = await http.post(
      url,
      body: jsonEncode(
        {
          "username": controllerUsername.text,
          "password": controllerPassword.text,
        },
      ),
      headers: Utils.configHeader(),
    );
    print(response.body);
    var data = json.decode(response.body.toString());
    sharedPref.setString('token', data['token']);    
    sharedPref.setString("username",   "${controllerUsername.text}");
    token=data['token'];
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage(username: controllerUsername.text, userToken: token, )));
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Username or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            // RoundedLoginUsernameField(
            //   hintText: "Your Email",
            //   onChanged: (value) {},
            // ),
            // RoundedLoginPasswordField(
            //   onChanged: (value) {},
            // ),
            TextFieldContainer(
              child: TextField(
                obscureText: false,
                cursorColor: kPrimaryColor,
                controller: controllerUsername,
                decoration: InputDecoration(
                  hintText: "UserName",
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  // suffixIcon: Icon(
                  //   Icons.visibility,
                  //   color: kPrimaryColor,
                  // ),
                  border: InputBorder.none,
                ),
              ),
            ),

            TextFieldContainer(
              child: TextField(
                obscureText: true,
                cursorColor: kPrimaryColor,
                controller: controllerPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            RoundedButton(
              text: "LOGIN",
              press: () {
                print("Printing Login");
                if (controllerUsername.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "UserName is Required",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                } else if (controllerPassword.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Password is Required",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }
                login();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
