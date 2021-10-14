import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:photo_view/photo_view.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/controller/chat_c.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/model/chat_model.dart';
import 'package:service_laptop/services/base_services.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class ChatView extends StatelessWidget {
  ChatView({Key key}) : super(key: key);
  final chatC = Get.put(ChatC());
  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 1),
      () => chatC.controller.animateTo(
          chatC.controller.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn),
    );
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        leading: IconButton(
          onPressed: () {
            chatC.textChat.clear();
            Get.back();
          },
          icon: LineIcon.arrowLeft(
            color: ColorApp.primaryColor,
            size: 7.w,
          ),
        ),
        title: Text(
          "RUANG DISKUSI",
          style: AppbarTitle(),
        ),
        actions: [
          Obx(() => chatC.isOpen.value == true
              ? IconButton(
                  onPressed: () {
                    chatC.isOpen(false);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: ColorApp.darkgreyColor,
                  ))
              : const Text("")),
          Obx(() => chatC.isOpen.value == true
              ? IconButton(
                  onPressed: () {
                    chatC.deleteChat();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: ColorApp.darkgreyColor,
                  ))
              : const Text("")),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 2.w, 2.w, 15.h),
              child: Obx(() => FutureBuilder(
                  future: chatC.fetchChat(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          controller: chatC.controller,
                          reverse: false,
                          shrinkWrap: false,
                          itemCount: chatC.listChat.length ?? 0,
                          itemBuilder: (context, i) {
                            Chat x = chatC.listChat[i];

                            return userC.idU.value != x.idUser
                                ? leftChat(x)
                                : rightChat(x);
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
            ),
            formChat(),
          ],
        ),
      ),
    );
  }

  Align leftChat(Chat x) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 1.w),
            child: CircleAvatar(
              backgroundImage: x.foto != ""
                  ? NetworkImage(
                      BaseServices().urlFile + "/service/fotoProfile/" + x.foto)
                  : const AssetImage("assets/images/logo_github.png"),
            ),
          ),
          x.type == "text" || x.type == "Text"
              ? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.w),
                    decoration: BoxDecoration(
                        color: ColorApp.darkgreyColor,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    padding: EdgeInsets.all(2.w),
                    child: Text(
                      x.text,
                      style: ChatTextWhite(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 25,
                      softWrap: true,
                    ),
                  ),
                )
              : Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.w),
                    decoration: BoxDecoration(
                        color: ColorApp.darkgreyColor,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    padding: EdgeInsets.all(2.w),
                    child: x.type == "Image"
                        ? GestureDetector(
                            onTap: () {
                              PhotoView(
                                  imageProvider: NetworkImage(
                                BaseServices().urlFile +
                                    "/service/chatFile/" +
                                    x.file,
                              ));
                            },
                            child: Image.network(
                                BaseServices().urlFile +
                                    "/service/chatFile/" +
                                    x.file,
                                fit: BoxFit.cover,
                                height: 15.h),
                          )
                        : Row(
                            children: [
                              LineIcon.file(
                                color: ColorApp.darkgreyColor,
                              ),
                              Text(
                                x.file.substring(0, x.file.indexOf('_')),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 50,
                                softWrap: true,
                              ),
                            ],
                          ),
                  ),
                ),
        ],
      ),
    );
  }

  Align rightChat(Chat x) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          x.type == "text" || x.type == "Text"
              ? Flexible(
                  child: InkWell(
                    onLongPress: () {
                      chatC.isOpen.value = true;
                      chatC.idChat.value = x.idChat;
                      // chatC.bgColor.value = ColorApp.greyColor;
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      decoration: BoxDecoration(
                          color: chatC.bgColor.value,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: EdgeInsets.all(2.w),
                      child: Text(
                        x.text,
                        style: ChatTextWhite(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 25,
                        softWrap: true,
                      ),
                    ),
                  ),
                )
              : Flexible(
                  child: InkWell(
                    onLongPress: () {
                      chatC.isOpen.value = true;
                      chatC.idChat.value = x.idChat;
                      // chatC.bgColor.value = ColorApp.greyColor;
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 20.h,
                      ),
                      margin: EdgeInsets.only(bottom: 2.w),
                      decoration: BoxDecoration(
                          color: chatC.bgColor.value,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: EdgeInsets.all(2.w),
                      child: x.type == "Image"
                          ? InkWell(
                              onTap: () {
                                SizedBox(
                                  width: 100.w,
                                  child: PhotoView(
                                      imageProvider: NetworkImage(
                                    BaseServices().urlFile +
                                        "/service/chatFile/" +
                                        x.file,
                                  )),
                                );
                              },
                              child: Image.network(
                                BaseServices().urlFile +
                                    "/service/chatFile/" +
                                    x.file,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Row(
                              children: [
                                LineIcon.file(
                                  color: Colors.white70,
                                ),
                                Text(
                                  x.file.substring(0, x.file.indexOf('_')),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 50,
                                  softWrap: true,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: CircleAvatar(
              backgroundImage: x.foto != ""
                  ? NetworkImage(
                      BaseServices().urlFile + "/service/fotoProfile/" + x.foto)
                  : const AssetImage("assets/images/logo_github.png"),
            ),
          ),
        ],
      ),
    );
  }

  Align formChat() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: const BoxDecoration(
            color: ColorApp.blackFont,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: 100.w,
        height: 15.h,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  chatC.handleAtachmentPressed();
                },
                icon: Icon(
                  Icons.attach_file,
                  color: Colors.white70,
                  size: 7.w,
                )),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: WhiteTextMedium(),
                maxLines: 5,
                minLines: 1,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Ketik Pesan",
                  hintStyle: WhiteTextMedium(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(15)),
                ).copyWith(isDense: true),
                controller: chatC.textChat,
              ),
            ),
            IconButton(
              onPressed: () {
                chatC.addMessage();
              },
              icon: Icon(Icons.send, color: Colors.white70, size: 7.w),
            ),
          ],
        ),
      ),
    );
  }
}
