import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/model/chat_model.dart';
import 'package:service_laptop/services/chat_s.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:sizer/sizer.dart';

class ChatC extends GetxController {
  final userC = Get.put(UsersC());
  var isLoading = true.obs;
  var isOpen = false.obs;
  var listChat = List<Chat>.empty().obs;
  var idService = "".obs;
  final textChat = TextEditingController();
  var file = File("").obs;
  var image = XFile("").obs;
  final controller = ScrollController();
  var idChat = "".obs;
  var bgColor = ColorApp.primaryColor.obs;
  // final ImagePicker _picker = ImagePicker();
  // List<types.Message> messages = [];
  // final user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  @override
  void onInit() {
    // loadMessages();
    // Timer(
    //   const Duration(seconds: 1),
    //   () => controller.animateTo(controller.position.maxScrollExtent,
    //       duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn),
    // );
    fetchChat();

    super.onInit();
  }

  Future fetchChat() async {
    isLoading(true);
    try {
      var res = await ChatS().getChat(idService: idService.value);
      if (res != null) {
        listChat.assignAll(res);
      } else {
        listChat.assignAll([]);
      }
    } finally {
      isLoading(false);
    }

    return listChat;
  }

  Future<void> deleteChat() async {
    try {
      isLoading(true);

      List res = await ChatS.deleteChat(id: idChat.value);

      if (res[0] == "berhasil") {
        listChat.refresh();
        bgColor.value = ColorApp.primaryColor;
        isOpen(false);
      } else {
        // print(res[1]);
        // print(idChat.value);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addMessage() async {
    try {
      await ChatS.addChat(
        idService: idService.value,
        idUser: userC.idU.value,
        text: textChat.text,
        status: "Seen",
        type: "Text",
        file: file.value,
      ).then((value) {
        listChat.refresh();
        textChat.clear();
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void handleAtachmentPressed() {
    Get.bottomSheet(
      Container(
        width: 5.w,
        height: 15.h,
        color: Colors.white,
        child: SizedBox(
          height: 20.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                  handleImageSelection();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      LineIcon.image(
                        color: ColorApp.primaryColor,
                      ),
                      const Text("Image"),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  handleFileSelection();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      LineIcon.file(
                        color: ColorApp.primaryColor,
                      ),
                      const Text("File"),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Icon(Icons.close, color: ColorApp.primaryColor),
                      Text("Close"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      file.value = File(result.files.single.path);
      try {
        await ChatS.addChat(
          idService: idService.value,
          idUser: userC.idU.value,
          text: textChat.text,
          status: "Seen",
          type: "File",
          file: file.value,
        ).then((value) {
          file.value = File("");
          listChat.refresh();
        });
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<void> handleImageSelection() async {
    // final result = await _picker.pickImage(
    //   imageQuality: 30,
    //   maxWidth: 2400,
    //   source: ImageSource.gallery,
    // );
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      file.value = File(result.files.single.path);

      try {
        await ChatS.addChat(
          idService: idService.value,
          idUser: userC.idU.value,
          text: textChat.text,
          status: "Seen",
          type: "Image",
          file: file.value,
        ).then((value) {
          file.value = File("");
          listChat.refresh();
        });
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  // void handleMessageTap(types.Message message) async {
  //   if (message is types.FileMessage) {
  //     await OpenFile.open(message.uri);
  //   }
  // }

  // void handlePreviewDataFetched(
  //   types.TextMessage message,
  //   types.PreviewData previewData,
  // ) {
  //   final index = messages.indexWhere((element) => element.id == message.id);
  //   final updatedMessage = messages[index].copyWith(previewData: previewData);

  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     messages[index] = updatedMessage;
  //   });
  // }

  // void handleSendPressed(types.PartialText message) {
  //   final textMessage = types.TextMessage(
  //     author: user,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: const Uuid().v4(),
  //     text: message.text,
  //   );

  //   _addMessage(textMessage);
  // }

  // Future loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   this.messages = messages;
  // }
}
