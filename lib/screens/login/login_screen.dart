import 'package:flutter/material.dart';
import 'package:studyhub/core/common/custom_widgets.dart';
import 'package:studyhub/core/constants/global_variables.dart';
import 'package:studyhub/screens/home/home_screen.dart';
import 'package:studyhub/screens/register/register_screen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: signupFormkey,
          child: Stack(
            children: [
              // ClipPathContainer(h: h, w: w),
              CustomShapedContainerTop(),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * 0.25,
                  ),
                  // GlobalVariables.height40,
                  // Image.asset('assets/images/iconowl.png')
                  IconTitleWidget(h: h, w: w),
                  // CustomTextFormfield(
                  //   width: w * 0.9,
                  //   controller: nameController,
                  //   hintText: 'Name',
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter your name';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  GlobalVariables.height20,
                  CustomTextFormfield(
                    width: w * 0.9,
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      } else if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  GlobalVariables.height20,
                  CustomTextFormfield(
                    width: w * 0.9,
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  GlobalVariables.height20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomElevatedButton(
                        onTap: () {
                          HomeScreen.navigate(context);
                          if (signupFormkey.currentState!.validate()) {
                            print('Validateeeeeeeeeeeeeeeeeedddddd');
                          }
                        },
                        text: 'Log In'),
                  ),
                  GlobalVariables.height20,
                  const Text(
                    'You dont have an account ?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  GlobalVariables.height10,
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                      },
                      icon: Icon(Icons.app_registration),
                      label: Text('Register')),
                  const CustomShapedContainer()
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class IconTitleWidget extends StatelessWidget {
  const IconTitleWidget({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: h * 0.07,
          width: w * 0.1,
          child: Image.asset('assets/images/iconowl.png'),
        ),
        Text(
          'Study Hub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }
}

//  ClipPathContainer(h: h, w: w),
class CustomShapeClipperTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 0.6, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomShapedContainerTop extends StatelessWidget {
  const CustomShapedContainerTop({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: CustomShapeClipperTop(),
      child: Container(
        decoration: BoxDecoration(
          gradient: GlobalVariables.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: h * 0.2,
        width: double.infinity,
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
        size.width / 4, 0, size.width / 2, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height * 0.4, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomShapedContainer extends StatelessWidget {
  const CustomShapedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: GlobalVariables.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        height: h * 0.2,
      ),
    );
  }
}
