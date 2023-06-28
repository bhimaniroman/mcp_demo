import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../AppData/AppData.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String? buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton(
      {super.key, required this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 30.0,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
      child: SizedBox(
        width: Get.width * 0.8,
        child: ElevatedButton(
          onPressed: onPressed,
          style: flatButtonStyle,
          child: Ink(
            height: height ?? 50,
            width: width ?? Get.width,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(radius)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor),
                    )
                  : const SizedBox(),
              Text(buttonText ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    fontSize: fontSize ?? 20,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
