import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sociall_app/Shared/Styles/icons_borken.dart';

Widget CustomerTextForm({
  controller,
  onChange,
  bool validatorPostion = false,
  Textvalidator,
  prefixIcon,
  labelText,
  hintText,
  suffixIcon,
  bool lock = false,
  ontap,
  double circular = 0,
  TextInputType keyboardType = TextInputType.emailAddress,
  floatingLabelAlignment = FloatingLabelAlignment.start,
}) =>
    TextFormField(
      onChanged: onChange,
      keyboardType: keyboardType,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          if (validatorPostion == true) {
            return '${Textvalidator}';
          } else {
            return null;
          }
        }
      },
      onTap: ontap,
      obscureText: lock,
      decoration: InputDecoration(
          floatingLabelAlignment: floatingLabelAlignment,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(circular),
              borderSide: BorderSide(color: Colors.redAccent))
      ),
    );

Widget CustomerTextForm1({
  controller,
  onChange,
  prefixIcon,
  bool validatorPostion = false,
  Textvalidator,
  labelText,
  hintText,
  suffixIcon,
  ontap,
  double circular = 0,
  TextInputType keyboardType = TextInputType.text,
  floatingLabelAlignment = FloatingLabelAlignment.start,
}) =>
    TextFormField(
      onChanged: onChange,
      keyboardType: keyboardType,
      controller: controller,
      onTap: ontap,
      validator: (value) {
        if (value!.isEmpty) {
          if (validatorPostion == true) {
            return '${Textvalidator}';
          } else {
            return null;
          }
        }
      },
      decoration: InputDecoration(
          floatingLabelAlignment: floatingLabelAlignment,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        border: InputBorder.none
      ),
    );

Widget CustomerButton({
  colorContainer = Colors.blue,
  splashColor,
  textColor = Colors.white70,
  text,
  onPressed,
  double circular = 10,
  double widthContainer = 220,
  double heightContainer = 35,
  double fontSize = 30,
}) =>
    Center(
      child: Container(
        width: widthContainer,
        height: heightContainer,
        decoration: BoxDecoration(
            color: colorContainer,
            borderRadius: BorderRadius.circular(circular)),
        child: MaterialButton(
          onPressed: onPressed,
          splashColor: splashColor,
          textColor: textColor,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );

Widget defaultButton(
        {
          double width = double.infinity,
        Color background = Colors.blue,
        bool isUpperCase = true,
        double radius = 3.0,
        function,
        text,
        TextStyle? textStyle,
        double widthBorder = 0,
        Color colorBorder = Colors.blue}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text, style: textStyle),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: widthBorder,
          color: colorBorder,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
  Widget defaultTextIconButton({
    double widthContainer = 200,
    double heightContainer = 60,
    Color background = Colors.blue,
    double radius = 3.0,
    double widthBorder = 0,
    Color colorBorder = Colors.blue,
     Icon,
    text,
    TextStyle,
    onPressed
})=>Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: widthBorder,
        color: colorBorder,
      ),
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  width: widthContainer,height: heightContainer,
  child: TextButton.icon(
    onPressed: onPressed, icon: Icon, label: Text(text,style: TextStyle,), ),
);


defaultAppBar({
  text,
  TextStyle,
  context,
  action,
}) =>
    AppBar(
      leading: IconButton(
          icon: Icon(IconBroken.Arrow___Left_2),
          onPressed: () {
            Navigator.pop(context);
          }),
      titleSpacing: 0.0,
      title: Text(
        text,
        style: TextStyle,
      ),
      actions: action,
    );

void navigatePush(context, {page}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

void navigateAndFinish(context, {page}) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) {
        return false;
      },
    );
void showToast({
  required String text,
  required toastStutes stutes,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: chooseColor(stutes),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastStutes { suess, error, warning }

Color chooseColor(toastStutes stutes) {
  Color color;
  switch (stutes) {
    case toastStutes.suess:
      color = Colors.green;
      break;
    case toastStutes.error:
      color = Colors.red;
      break;
    case toastStutes.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}
