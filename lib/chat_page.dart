// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:websockets/controllers/chat_controller.dart';
import 'package:websockets/message_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websockets/models/message_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messageController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
      'http://localhost:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    setUpSocketListener();
    super.initState();
  }

  // @override
  // void dispose() {
  //   messageController.dispose();
  //   super.dispose();
  // }

  void sendMessage(String msg) {
    var json = {
      "message": msg,
      "sendByMe": socket.id,
    };
    socket.emit('message', json);
    chatController.chatMessages.add(
      MessageModel.fromJson(json),
    );
  }

  void setUpSocketListener() {
    socket.on(
      'message-receive',
      (data) {
        chatController.chatMessages.add(
          MessageModel.fromJson(data),
        );
      },
    );
  }

  var chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Web Socket",
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    var currentItem = chatController.chatMessages[index];
                    return MessageItem(
                      sendByMe: currentItem.sendByMe == socket.id,
                      message: currentItem.message,
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: TextFormField(
                controller: messageController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                cursorHeight: 18.sp,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: InkWell(
                    onTap: () {
                      sendMessage(messageController.text);
                      messageController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      size: 25.sp,
                    ),
                  ),
                  hintText: 'Type a message!',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(
                    10.sm,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
