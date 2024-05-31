import 'package:flutter/material.dart';

import '../core/constant/color.dart';

Widget container_profile(IconData icon, String containerName, IconData endicon,)=>
  Container(
    height: 50,
    width: 400,
    child: Row(
      children: [
        Icon(icon),
        SizedBox(width: 10,),
        Text('$containerName',
          style: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold
          ),),
        SizedBox(width: 230,),
        IconButton(onPressed: (){},
            icon: Icon(endicon))
      ],
    ),
  );


Widget container_profile2(IconData icon, String containerName, int number)=>
    Container(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10,),
          Text('$containerName',
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(width:240 ),
         Text("$number"),
        ],
      ),
    );

Widget container_profile3(IconData icon, String containerName, int number)=>
    Container(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10,),
          Text('$containerName',
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(width:205 ),
          Text("$number"),
        ],
      ),
    );

Widget container_profile4(IconData icon, String containerName, IconData endicon,)=>
    Container(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10,),
          Text('$containerName',
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(width: 243,),
          IconButton(onPressed: (){},
              icon: Icon(endicon))
        ],
      ),
    );
