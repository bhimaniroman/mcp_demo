import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'AppData.dart';

save(String key, value) async {
  final box = GetStorage();
  box.write(key, value);
}

appBar({
  String? leadingIcon,
  String? title,
  Widget? actionIcon,
  Function()? leadingOnTap,
}) {
  return Container(
    color: bgcolor,
    child: ListTile(
      horizontalTitleGap: 00,
      leading: Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: leadingOnTap,
          splashColor: Colors.transparent,
          icon: Image(
            image: AssetImage("$leadingIcon"),
            height: 22,
            width: 22,
            color: textcolor,
          ),
        ),
      ),
      title: Center(
        child: SizedBox(
          child: appText(
              title: title,
              fontSize: 18,
              letterSpacing: 0.3,
              color: textcolor,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ),
      trailing:
          Padding(padding: const EdgeInsets.only(right: 10), child: actionIcon),
      contentPadding: const EdgeInsets.only(left: 12),
    ),
  );
}

Widget appText(
    {String? title,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    Color? color,
    double? height,
    int? maxLines,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextAlign? textAlign}) {
  return Text(
    title.toString(),
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: GoogleFonts.poppins(
        height: height,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        color: color ?? textcolor,
        fontStyle: fontStyle),
  );
}

appButton({String? title, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: buttoncolor,
      ),
      child: Center(
          child: appText(
              title: "$title",
              color: fontcolor,
              fontWeight: FontWeight.w600,
              fontSize: 17)),
    ),
  );
}

appTheme() async {
  bool colormode = getData.read('appcolor') ?? false;
  switch (colormode) {
    case true:
      bgcolor = Color(0xff000000);
      textcolor = Color(0xffffffff);
      blogtextcolor = Color(0xff737171);
      viewcolor = Color(0xff262626);
      dividercolor = Color(0xff3D3D3D);
      blankbuttoncolor = Color(0xff5C657B);
      alertcolor = Color(0xff737171);
      blogbgcolor = Color(0xff262626);
      break;
    case false:
      bgcolor = Color(0xffffffff);
      textcolor = Color(0xff000000);
      blogtextcolor = Color(0xffACACAC);
      viewcolor = Color(0xffF5F5F5);
      dividercolor = Color(0xffE0E0E0);
      blankbuttoncolor = Color(0xffD4E0FF);
      alertcolor = Color(0xff707070);
      blogbgcolor = Color(0xffFBFBFF);
      break;
  }
}

Widget loader() {
  return Center(
    child: SizedBox(
      height: Get.height * 0.1,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation(textcolor),
        ),
      ),
    ),
  );
}
