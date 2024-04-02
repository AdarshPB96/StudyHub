import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:studyhub/screens/add_post/add_post_screen.dart';
import 'package:studyhub/screens/chats/chat_screen.dart';
import 'package:studyhub/screens/home/home_screen.dart';

class MainSCreen extends StatefulWidget {
  const MainSCreen({super.key});

  @override
  State<MainSCreen> createState() => _MainSCreenState();
}

class _MainSCreenState extends State<MainSCreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    FriendRequestsScreen(),
    NotificationsScreen(),
    AddPostScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class FriendRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Requests Screen'),
      ),
      body: Center(
        child: Text('Friend Requests Screen'),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Screen'),
      ),
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}

