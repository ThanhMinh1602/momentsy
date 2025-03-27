import 'package:flutter/material.dart';
import 'package:momentsy/core/constants/app_color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Chats'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 64,
                color: AppColor.secondary,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No conversations yet',
              style: TextStyle(
                color: AppColor.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Start chatting with your friends',
              style: TextStyle(color: AppColor.textSecondary, fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('New message'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.secondary,
        child: Icon(Icons.chat),
      ),
    );
  }
}
