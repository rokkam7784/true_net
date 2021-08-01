import 'package:flutter/material.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/Widget/picker/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }

    if (isValid) {
      _formKey.currentState!.save();
      // print(_userName);
      // print(_userPassword);
      // print(_userEmail);
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Card(
          color: Kclr01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "images/TrueNetLogo.jpeg",
                    height: 290,
                  ),
                  //Todo TextForms
                  if (!_isLogin)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserImagePicker(_pickedImage),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: TextFormField(
                              key: ValueKey("username"),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 1) {
                                  return "Enter a valid Username";
                                }
                                return null;

                                // return value.toString().length < 6
                                //     ? "Enter Correct Username (6+ characters)"
                                //     : null;
                              },
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: new TextStyle(
                                  color: const Color(0xFF424242),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Kclr21),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Kclr21),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Kclr21),
                                ),
                              ),
                              onSaved: (value) {
                                _userName = value!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  TextFormField(
                    key: ValueKey("Email"),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Enter a valid Email-id";
                      }
                      return null;

                      // return RegExp(
                      //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //     .hasMatch(value.toString())
                      //     ? null
                      //     : "Enter Correct mail id";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: new TextStyle(
                        color: const Color(0xFF424242),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                    ),
                    style: TextStyle(color: Kclr21),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("password"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Enter a valid Password";
                      }
                      return null;

                      // return value.toString().length < 6
                      //     ? "Enter Password 6+ characters"
                      //     : null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: new TextStyle(
                        color: const Color(0xFF424242),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Kclr21),
                      ),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator(
                      color: Kclr23,
                    ),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(_isLogin ? "Login" : "Sign Up"),
                      ),
                      onPressed: _trySubmit,
                      style: ElevatedButton.styleFrom(
                        primary: Kclr22,
                      ),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? "Create a new Account"
                            : "Already have an account ? Log in",
                      ),
                      style: TextButton.styleFrom(
                        primary: Kclr21,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
