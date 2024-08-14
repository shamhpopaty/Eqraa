import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/my_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String? _imagePath;

  Future<void> _pickImage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imagePath = result.files.single.name; // Save only the name
      });
    }
  }
  final EditProfileController profileController = Get.put(EditProfileController());

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // عرض وتعديل الصورة
            Obx(() {
              return CircleAvatar(
                backgroundImage: FileImage(File(profileController.profile.value.imageUrl)),
                radius: 50,
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                _imagePath == null
                    ? 'Pick Image'
                    : 'Image Selected: $_imagePath',
              ) ,
              onPressed: _pickImage,),
            SizedBox(height: 20),

            // تعديل السيرة الذاتية
            Obx(() => TextFormField(
              initialValue: profileController.profile.value.bio,
              onChanged: (value) {
                profileController.updateBio(value);
              },
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            )),
            SizedBox(height: 20),

            // تعديل رابط التواصل الاجتماعي
            Obx(() => TextFormField(
              initialValue: profileController.profile.value.socialLink,
              onChanged: (value) {
                profileController.updateSocialLink(value);
              },
              decoration: InputDecoration(
                labelText: 'Social Link',
                border: OutlineInputBorder(),
              ),
            )),
            SizedBox(height: 20),

            // زر حفظ
            ElevatedButton(
              onPressed: () {
                // هنا يمكنك تنفيذ منطق حفظ البيانات
                Get.snackbar('Success', 'Profile updated successfully');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
