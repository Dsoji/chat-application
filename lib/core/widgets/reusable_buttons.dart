import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String? text;
  final double? width;
  final Color color;
  final void Function()? onPressed;
  final bool isLoading;
  const TransparentButton(
      {this.text,
      this.onPressed,
      this.width,
      this.isLoading = false,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      height: 40,
      minWidth: width!,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: BorderSide(
            color: color,
          )),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: color,
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final Color? textColor;
  final void Function()? onPressed;
  final bool isLoading;
  const ColorButton(
      {Key? key,
      this.width,
      this.color,
      this.text,
      this.onPressed,
      this.textColor,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 9,
      onPressed: onPressed!,
      minWidth: width!,
      color: color,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: textColor,
        ),
      ),
    );
  }
}

class KolorButton2 extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final void Function()? onPressed;
  final bool isLoading;
  const KolorButton2(
      {Key? key,
      this.width,
      this.color,
      this.text,
      this.onPressed,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      minWidth: width!,
      color: color,
      height: 18,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: Colors.white,
        ),
      ),
    );
  }
}

class KolorButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final void Function()? onPressed;
  final bool isLoading;
  const KolorButton(
      {Key? key,
      this.width,
      this.color,
      this.text,
      this.onPressed,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      minWidth: width!,
      color: color,
      height: 46,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final Color? textColor;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomButton(
      {Key? key,
      this.width,
      this.color,
      this.text,
      this.onPressed,
      this.isLoading = false,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      minWidth: width!,
      color: color,
      height: 60,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Kanit',
          color: textColor,
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final Color? textColor;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomButton2(
      {Key? key,
      this.width,
      this.color,
      this.text,
      this.onPressed,
      this.isLoading = false,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      minWidth: width!,
      color: color,
      height: 60,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: textColor,
        ),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final String? text;
  final double? width;

  final void Function()? onPressed;
  final bool isLoading;
  const WhiteButton(
      {this.text, this.onPressed, this.width, this.isLoading = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      height: 40,
      minWidth: width!,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(
            color: Colors.white,
          )),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Kanit',
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class SmallIconButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Color highcolor;
  final double? width;
  final double? height;
  final Function()? onPressed;

  const SmallIconButton(
      {Key? key,
      this.width,
      required this.icon,
      this.onPressed,
      this.height,
      required this.color,
      required thisighcolor,
      required this.highcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: highcolor,
      ),
      child: IconButton(
        icon: icon,
        color: color,
        highlightColor: highcolor,
        onPressed: onPressed!,
        iconSize: 21.5,

        //disabledColor: AppColors.grey20,
      ),
    );
  }
}

class Label2Button extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;

  final String image;
  final Color textColor;
  final double width;
  final void Function()? onPressed;

  const Label2Button(
      {Key? key,
      required this.width,
      required this.text,
      required this.color,
      required this.textColor,
      required this.image,
      this.onPressed,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      height: 46,
      minWidth: width,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
