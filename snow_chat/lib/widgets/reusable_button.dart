import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentButton extends StatelessWidget {
  final String? text;
  final double? width;

  final void Function()? onPressed;
  final bool isLoading;
  const TransparentButton(
      {this.text, this.onPressed, this.width, this.isLoading = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed!,
      height: 40.h,
      minWidth: width!,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(
            color: Colors.black,
          )),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Messina Sans',
          color: Colors.black,
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? width;
  final void Function()? onPressed;
  final bool isLoading;
  const ColorButton(
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
      height: 40.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Messina Sans',
          color: Colors.black,
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
      height: 46.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Messina Sans',
          color: Colors.white,
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
      height: 40.h,
      minWidth: width!,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(
            color: Color.fromRGBO(240, 82, 86, 1),
          )),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Messina Sans',
          color: Colors.indigo,
        ),
      ),
    );
  }
}
