import 'package:flutter/material.dart';
import 'package:studyhub/core/constants/global_variables.dart';

class HomeScreen extends StatelessWidget {
  static void navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset('assets/images/iconowl.png'),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.message))
                  ],
                ),
                GlobalVariables.height20,
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Image.asset('assets/images/iconowl.png'),
                                radius: 15,
                              ),
                              GlobalVariables.width10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "SSLC",
                                  ),
                                ],
                              )
                            ],
                          ),
                          GlobalVariables.height10,
                          Text(
                              'sdkjgbhjkdfsbghjkdfsbgkhjdfsbgjhdsf sjkgdfhbkjgbfsd ikyfsdguyifhsdg'),
                          GlobalVariables.height10,
                          SizedBox(
                            height: h * 0.4,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/0_3 (1).webp',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.thumb_up)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.comment)),
                              Spacer(),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.share)),
                            ],
                          ),
                          Text('123 Likes'),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey,
                        thickness: 1,
                      );
                    },
                    itemCount: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
