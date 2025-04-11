import 'package:get/get.dart';
import 'package:momentsy/app/data/models/conversation_model.dart';
import 'package:momentsy/app/data/models/message_model.dart';
import 'package:momentsy/app/data/models/user_model.dart';
import 'package:momentsy/app/data/services/remote/chat_service.dart';
import 'package:momentsy/app/data/services/remote/friend_service.dart';
import 'package:momentsy/app/data/services/remote/socket_service.dart';
import 'package:momentsy/core/viewmodel/base_viewmodel.dart';

class ChatViewModel extends BaseViewModel {
  final FriendService _friendService;
  final ChatService _chatService;
  final SocketService _socketService;

  final RxList<UserModel> userModels = <UserModel>[].obs;
  final RxList<ConversationModel> conversationModels =
      <ConversationModel>[].obs;

  ChatViewModel({
    required FriendService friendService,
    required ChatService chatService,
    required SocketService socketService,
  }) : _chatService = chatService,
       _friendService = friendService,
       _socketService = socketService;

  @override
  void onInit() {
    super.onInit();
    _getFriendList();
    _getConversationList();

    _socketService.on('newMessage', (data) {
      final newMessage = MessageModel.fromJson(data);
      print('New message: ${newMessage.content}');

      final index = conversationModels.indexWhere(
        (element) =>
            element.friend?.id == newMessage.senderId ||
            element.friend?.id == newMessage.receiverId,
      );

      if (index != -1) {
        // Cập nhật lastMessage cho conversation đã có
        final existing = conversationModels[index];
        final updated = existing.copyWith(lastMessage: newMessage);

        conversationModels[index] = updated;
        // Đưa cuộc trò chuyện đó lên đầu danh sách
        final updatedList = List<ConversationModel>.from(conversationModels);
        final movedItem = updatedList.removeAt(index);
        updatedList.insert(0, movedItem);
        conversationModels.assignAll(updatedList);
      } else {
        // Nếu là cuộc trò chuyện mới, gọi lại API hoặc tự thêm mới
        _getConversationList(); // hoặc bạn có thể tạo ConversationModel mới và add
      }
    });
  }

  Future<void> _getFriendList() async {
    setLoading(true);
    final result = await _friendService.getFirendList(userId);
    setLoading(false);
    result.fold(
      (l) {
        print('Get friend list fail: ${l.message}');
      },
      (r) {
        print(r);
        userModels.assignAll(r.data ?? []);
      },
    );
  }

  Future<void> _getConversationList() async {
    setLoading(true);
    final result = await _chatService.getConversationList(userId);
    setLoading(false);
    result.fold(
      (l) {
        print('Get friend list fail: ${l.message}');
      },
      (r) {
        print(r);
        conversationModels.assignAll(r.data ?? []);
      },
    );
  }

  void disconnect() {
    // socketService.disconnect();
  }
}
