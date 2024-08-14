import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/localization/changelocal.dart';

class NoteItem extends StatelessWidget {
   NoteItem({super.key});
  LocaleController localController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color:(!localController.isDark)? AppColor.fourthColor:AppColor.primaryColorDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text("AlSera",
            style: TextStyle(color: Colors.black,
            fontSize: 26),

            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:16),
              child: Text("yourNotes",

                style: TextStyle(color: Colors.black.withOpacity(0.4),
                fontSize: 20),),
            ),
            trailing: IconButton(onPressed: (){},
                icon: Icon(Icons.delete),
            color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
