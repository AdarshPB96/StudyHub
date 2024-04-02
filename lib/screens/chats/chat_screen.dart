import 'package:flutter/material.dart';
import 'package:studyhub/core/constants/global_variables.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              _buildTabBarWithGradient(),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabView(
                        Colors.grey.shade300), // Tab view for Global Chat
                    _buildTabView(
                        Colors.pink.shade300), // Tab view for Friends Chat
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarWithGradient() {
    return TabBar(
      tabs: [
        _buildTabItemWithGradient(
            gradientColors: [Color(0xFF99B7CF), Colors.amber],
            label: "Global Chat"),
        _buildTabItemWithGradient(
            gradientColors: [Color(0xFF99B7CF), Colors.amber],
            label: "Friends Chat")
      ],
    );
  }

  Widget _buildTabItemWithGradient({
    required String label,
    required List<Color> gradientColors,
  }) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTabView(Color backgroundColor) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          'Chat Screen',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
