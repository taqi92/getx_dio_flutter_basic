import 'dart:core';
import 'package:flutter/material.dart';

extension CapitalizeString on String {
  get allWordsCapitalize {
    return toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  // int parseInt() {
  //   return int.parse(this);
  // }
  // double parseDouble() {
  //   return double.parse(this);
  // }
}

// extension Toast on String {
//   showAsToast(BuildContext context, {Duration duration = const Duration(seconds: 5)}) {
//
//     final snackBar = SnackBar(
//       content: const Text('Yay! A SnackBar!'),
//       action: SnackBarAction(
//         label: 'Undo',
//         onPressed: () {
//           // Some code to undo the change.
//         },
//       ),
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     // final scaffold = ScaffoldMessenger.of(context);
//     // /*final controller = */scaffold.showSnackBar(
//     //   SnackBar(
//     //     content: Text(this),
//     //     backgroundColor: const Color(0xFF24283b),
//     //     behavior: SnackBarBehavior.floating,
//     //     elevation: 2.0,
//     //     shape: RoundedRectangleBorder(
//     //       borderRadius: BorderRadius.circular(10),
//     //     ),
//     //   ),
//     // );
//
//     // await Future.delayed(duration);
//     // controller.close();
//   }
// }
