import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:service_laptop/component/appbarview.dart';
import 'package:service_laptop/component/boxcontainer.dart';
import 'package:service_laptop/component/formfield.dart';
import 'package:service_laptop/component/fotorow.dart';
import 'package:service_laptop/controller/user_c.dart';
import 'package:service_laptop/util/colorapp.dart';
import 'package:service_laptop/util/textstyle.dart';
import 'package:sizer/sizer.dart';

class AddUser extends StatelessWidget {
  AddUser({Key key}) : super(key: key);
  final userC = Get.put(UsersC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.canvasColor,
      appBar: AppbarStyle(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: LineIcon.arrowLeft(
            size: 7.w,
            color: ColorApp.primaryColor,
          ),
        ),
        title: Text(
          "TAMBAH AKUN",
          style: AppbarTitle(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                userC.uploadUser();
              },
              icon: LineIcon.plus(color: ColorApp.primaryColor)),
        ],
      ),
      body: BoxContainer(
        fields: Obx(
          () => Form(
            key: userC.key,
            child: ListView(
              children: [
                FotoRow(
                  title: Text(
                    "Foto Profile",
                    style: NameStyle(),
                  ),
                  isi: userC.foto.value.path == ""
                      ? Text("Belum Ada Foto", style: EmailProfile())
                      : Image.file(userC.foto.value, fit: BoxFit.cover),
                  right: InkWell(
                    onTap: () {
                      userC.pickLampiran();
                    },
                    child: LineIcon.image(
                      size: 10.w,
                      color: ColorApp.primaryColor,
                    ),
                  ),
                ),
                FormF(
                  hintText: "Nama",
                  controller: userC.nama,
                  titleText: "Nama",
                  visibel: false,
                ),
                FormF(
                  hintText: "Email",
                  controller: userC.email,
                  titleText: "Email",
                  visibel: false,
                ),
                FormF(
                  hintText: "No. Telp",
                  controller: userC.noTelp,
                  titleText: "No. Telp",
                  visibel: false,
                ),
                FormF(
                  hintText: "Password",
                  controller: userC.password,
                  titleText: "Password",
                  visibel: false,
                ),
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: SizedBox(
                    width: 90.w,
                    height: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jenis", style: EmailProfile()),
                        DropdownButtonFormField<String>(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Tidak Boleh Kosong";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: ColorApp.greyColor),
                              ),
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                              fillColor: Colors.white,
                              filled: true),
                          isExpanded: true,
                          hint: const Text("Level"),
                          items: const [
                            DropdownMenuItem(
                              child: Text("Admin"),
                              value: "Admin",
                            ),
                            DropdownMenuItem(
                              child: Text("Customer"),
                              value: "Customer",
                            ),
                            DropdownMenuItem(
                              child: Text("Teknisi"),
                              value: "Teknisi",
                            ),
                          ],
                          onChanged: (String value) {
                            userC.level.text = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
