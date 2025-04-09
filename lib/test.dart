// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:momentsy/app/data/models/message_model.dart';
// import 'package:momentsy/app/data/services/remote/socket_service.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Khởi tạo controller
//     Get.put(ChatController());

//     return GetMaterialApp(title: 'Chat App', home: HomeScreen());
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final ChatController chatController = Get.find<ChatController>();

//   @override
//   Widget build(BuildContext context) {
//     // Giả sử userId là "user1" - trong thực tế bạn sẽ lấy từ auth
//     chatController.initSocket("user2");

//     return Scaffold(
//       appBar: AppBar(title: Text('Chat App')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Get.to(() => ChatScreen(receiverId: "user1"));
//           },
//           child: Text('Chat với user1'),
//         ),
//       ),
//     );
//   }
// }

// class ChatController extends GetxController {
//   final SocketService _socketService = SocketService();
//   final RxList<MessageModel> messages = <MessageModel>[].obs;
//   String? _currentUserId;

//   void initSocket(String userId) {
//     _currentUserId = userId;
//     _socketService.connect(userId);
//     _socketService.onMessageReceived((message) {
//       messages.add(message);
//     });
//   }

//   void sendMessage(String receiverId, String content) {
//     if (_currentUserId != null) {
//       _socketService.sendMessage(receiverId, content);
//       messages.add(
//         MessageModel(
//           senderId: _currentUserId!,
//           receiverId: receiverId,
//           content: content,
//           timestamp: DateTime.now(),
//         ),
//       );
//     }
//   }

//   void disconnect() {
//     _socketService.disconnect();
//   }
// }

// class ChatScreen extends StatelessWidget {
//   final String receiverId;
//   final TextEditingController _messageController = TextEditingController();

//   ChatScreen({required this.receiverId});

//   final ChatController chatController = Get.find<ChatController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat với $receiverId')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: chatController.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = chatController.messages[index];
//                   final isMe =
//                       message.senderId ==
//                       chatController.messages[index].senderId;
//                   return Align(
//                     alignment:
//                         isMe ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: isMe ? Colors.blue[100] : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment:
//                             isMe
//                                 ? CrossAxisAlignment.end
//                                 : CrossAxisAlignment.start,
//                         children: [
//                           Text(message.content),
//                           SizedBox(height: 5),
//                           Text(
//                             DateFormat('HH:mm').format(message.timestamp),
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập tin nhắn...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_messageController.text.isNotEmpty) {
//                       chatController.sendMessage(
//                         receiverId,
//                         _messageController.text,
//                       );
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
