import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // path.quadraticBezierTo(0, size.height, size.width, 0);
    path.quadraticBezierTo(size.width, size.height * 0.8, size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipPathContainer extends StatelessWidget {
  const ClipPathContainer({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: h * 0.40,
        width: w,
        color: const Color.fromARGB(255, 105, 186, 252),
        child: Image.asset(
          'assets/images/0_3 (1).webp',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

// class MyBottomClipperBottom extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     path.relativeQuadraticBezierTo(
//         size.width, size.height * 0.8, size.width, 0);
//     //  path.quadraticBezierTo(size.width, size.height * 0.8, size.width, 0);
//     // path.lineTo(0, size.height);
//     // path.lineTo(0, size.height);

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class ClipPathContainerBottom extends StatelessWidget {
//   const ClipPathContainerBottom({
//     Key? key,
//     required this.h,
//     required this.w,
//   }) : super(key: key);

//   final double h;
//   final double w;

//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: MyBottomClipperBottom(),
//       child: Container(
//         height: h * 0.40,
//         width: w,
//         color: const Color.fromARGB(255, 105, 186, 252),
//         child: Image.asset(
//           'assets/images/0_3 (1).webp',
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
