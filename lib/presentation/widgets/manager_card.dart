// import 'package:capstone/data/models/models.dart';
// import 'package:capstone/presentation/widgets/constants.dart';
// import 'package:flutter/material.dart';

// class ManagerCard extends StatelessWidget {
//   final User manager;
//   ManagerCard(this.manager);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10.0),
//         padding: EdgeInsets.all(6.0),
//         width: double.infinity,
//         height: 65.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(169, 176, 185, 0.42),
//               spreadRadius: 0,
//               blurRadius: 8,
//               offset: Offset(0, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: 55.0,
//               width: 55.0,
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(224, 230, 255, 1),
//               ),
//               child: Image.network(this.manager.imageURL),
//             ),
//             SizedBox(
//               width: 25.0,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     this.manager.userName,
//                     style: TextStyle(
//                       color: kCaptionTextColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Text(
//                     this.manager.fullName,
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: kCaptionTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.navigate_next_sharp,
//               //FlutterIcons.play_circle_filled_mdi,
//               color: kCaptionTextColor,
//             ),
//             SizedBox(
//               width: 15.0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
