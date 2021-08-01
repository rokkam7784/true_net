import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_net/Constants/Colors.dart';
import 'dart:io';
import 'package:true_net/Widget/authForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_net/Widget/helperFunctions.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//
//   var _isLoading = false;
//
//   void _submitAuthForm(
//     String email,
//     String username,
//     String password,
//     bool isLogin,
//     BuildContext ctx,
//   ) async {
//     //TODO AuthResult ==> UserCredential
//     UserCredential authResult;
//
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       if (isLogin) {
//         authResult = await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//       } else {
//         authResult = await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//       }
//
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(authResult.user!.uid)
//           .set(
//         {
//           'username': username,
//           'email': email,
//         },
//       );
//     } on PlatformException catch (e) {
//       var message = "An error occured , please check your credentials ";
//       if (e.message != null) {
//         message = e.message!;
//       }
//
//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Theme.of(ctx).errorColor,
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       print(e);
//
//       var message =
//           "Something's wrong with your login credentials.\nEmail address might be already in use by another account. ";
//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(
//             message,
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Theme.of(ctx).errorColor,
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Kclr21,
//       body: AuthForm(
//         _submitAuthForm,
//         _isLoading,
//       ),
//     );
//   }
// }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(
        () {
          _isLoading = true;
        },
      );
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = FirebaseAuth.instance.currentUser!;
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        //TODO Added HelperFunctions
        HelperFunctions.saveUserNamePreference(userData['username']);
        HelperFunctions.saveUserEmailPreference(email);
        HelperFunctions.saveUserImagePreference(userData['image_url']);
        HelperFunctions.saveUserLoggedInPreference(true);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
            'image_url': url,
          },
        );

        //TODO Added HelperFunctions
        HelperFunctions.saveUserNamePreference(username);
        HelperFunctions.saveUserEmailPreference(email);
        HelperFunctions.saveUserImagePreference(url);
        HelperFunctions.saveUserLoggedInPreference(true);
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message!;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(
        () {
          _isLoading = false;
        },
      );
    } catch (err) {
      print(err);
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kclr21,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}

//async {
//     UserCredential authResult;
//
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       if (isLogin) {
//         authResult = await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//       } else {
//         authResult = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('user_image')
//             .child(authResult.user!.uid + '.jpg');
//
//         await ref.putFile(image);
//
//         final url = await ref.getDownloadURL();
//
//         // final ref = FirebaseStorage.instance
//         //     .ref()
//         //     .child('user_image')
//         //     .child(authResult.user.uid + '.jpg');
//         //
//         // await ref.putFile(image);
//
//         // final url = await ref.getDownloadURL();
//
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(authResult.user!.uid)
//             .set(
//           {
//             'username': username,
//             'email': email,
//             'image_url': url,
//           },
//         );
//       }
//     } on PlatformException catch (err) {
//       var message = 'An error occurred, pelase check your credentials!';
//
//       if (err.message != null) {
//         message = err.message!;
//       }
//
//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Theme.of(ctx).errorColor,
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (err) {
//       print(err);
//       var message =
//           "Something's wrong with your login credentials.\nThe user may have been deleted or might be in use by another account. ";
//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(
//             message,
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Theme.of(ctx).errorColor,
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
