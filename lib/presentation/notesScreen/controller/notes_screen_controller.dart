import 'package:eqraa/core/class/status_request.dart';
import 'package:eqraa/core/functions/handling_data_controller.dart';
import 'package:eqraa/models/book_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/token_manager.dart';
import '../data/notes_screen_data.dart';
import '../../../models/notes_model.dart';

class NotesScreenControllerImp extends GetxController {
  var isLoading = true.obs;
  List<Notes_Model> notes = []; // تعديل نوع القائمة إلى Notes_Model
  StatusRequest statusRequest = StatusRequest.none;
  NotesScreenData notesScreenData = NotesScreenData(Get.find());
  final TokenManager tokenManager = TokenManager();

  @override
  void onInit() {
    super.onInit();
    getBookMark(); // استدعاء الدالة لجلب البيانات عند التهيئة
  }

  Future<void> getBookMark() async {
    String accessToken = await TokenManager().accessToken;

    var response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/bookmarks'),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      notes = temp.map((item) => Notes_Model.fromJson(item)).toList();
      statusRequest = StatusRequest.success; // تغيير حالة الطلب إلى success
    } else {
      Get.snackbar('notSuccess', jsonDecode(response.body).toString());
      statusRequest = StatusRequest.failure; // تغيير حالة الطلب إلى failure في حالة الفشل
    }

    update(); // تحديث الـ UI بعد جلب البيانات
  }

  // تابع لحذف الملاحظة
  Future<void> deleteNote(int noteId) async {
    String accessToken = await TokenManager().accessToken;

    var response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/bookmarks/$noteId'),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      // حذف الملاحظة من القائمة المحلية بعد نجاح الحذف
      notes.removeWhere((note) => note.id == noteId);
      update(); // تحديث الـ UI بعد الحذف

      print("Note deleted successfully");
      Get.snackbar('Success', 'Note deleted successfully');
    } else {
      print("Failed to delete note: ${response.statusCode}");
      Get.snackbar('Failure', 'Failed to delete note');
    }
  }
}
