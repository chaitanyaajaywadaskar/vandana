import 'package:flutter/material.dart';

class ColorConstant {
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black87;
  static const Color darkGrey = Colors.black54;
  static const Color grey = Colors.grey;
  static Color lightGrey = Colors.grey[350]!;
  static Color extraLightGrey = Colors.grey[200]!;
  static const Color white = Colors.white;
  static const Color appMainColor = Color(0xffEC6223); //E22A2A
  static const Color greenColor = Color(0xff19AA5C);
  static const Color appMainColorLite = Color(0xffF68D2D); //E22A2A
  static const Color blue = Color(0xff068AEC);

  static Color orange = const Color(0xffEC6223);
  static Color orangeAccent = const Color(0xffF68D2D);
  static Color backGround = const Color(0xfffef5ee);


 static  const Color lightBlackColor = Color(0xff1A1A1A);
static  const Color greyColor = Color(0xffC0C0C0);
 static const Color appBackgroundColor = Color(0xffF1F5FA);
static const Color secondBackgroundColor = Color(0xffEEEEEE);
static const Color textGreyColor = Color(0xffACB0B5);
static const Color appColor = Color(0xff1E252B);
static const Color appBlackColor = Color(0xff1E1E1E);
static const Color dividerColor = Color(0xff8D8DA2);

static const Color containerBlackColor = Color(0xff1E252A);
static const Color darkprimaryButtonColor = Color(0xffA88C40);
static const Color secondaryButtonColor = Color(0xff5A5A5A);
static const Color darKYellowGradientColor = Color(0xff8F5E25);
static const Color lightYellowGradientColor = Color(0xffD7BD73);
static const Color gradientLightColor = Color(0xff1E252B);
static const Color gradientDarkColor = Color(0xff2A333B);
static const Color textFieldColor = Color(0xff32393F);
static const Color textFieldTitleColor = Color(0xffC0C0C0);
static const Color textFieldBorderColor = Color(0xffE2E3E5);
static const Color titleBlack = Color(0xff1E1E1E);
static const Color barrierBlackColor = Color(0xff2C353D);
static const Color startColor = Color(0xffD7D9DB);
static const Color blurBackgroundColor = Color(0xff282829);
static const Color yellowColor = Color(0xffFFC400);
static const Color skyColor = Color(0xff63C7F5);
static const Color whiteColor = Color(0xffffffff);
static const Color redColor = Color(0xffFF3333);

static const Color commongreycolor = Color(0xff6E757C);
static const Color offWhite = Color(0xffF8F8F8);
static const Color ongolingBackgroundBlack = Color(0xff282828);
static const Color backgroundColor = Color(0xffF9F9F9);

static const Color lightgreycolor = Color(0xffE9E9E9);

static const Color backgroundGrey = Color(0xffECEFF3);
static const Color hintGrey = Color(0xffBABABA);
static const Color contentGrey = Color(0xff969498);
static const Color regularGrey = Color(0xff7F7D89);
static const Color darkGreyWhite = Color(0xffA1ACB6); //505050
// const Color? titleBlack = Color(0xff333333);

static const Color lightRedColor = Color(0xffFF4A59);
static const Color lightappColor = Color(0xffFFE7E7);
static const Color red = Color(0xffB21807);
static const Color success = Color(0xff426d54); //5FB924
static const Color infoDialog = Color(0xff79B3E4);
static const Color yellow = Color(0xffFFCC00);
static const Color borderGrey = Color(0xffDBDBDB);

Color lightSilver = const Color(0xffF7F7F7);
static const Color darkSilver = const Color(0xffE4E4E4);
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
const int _whitePrimaryValue = 0xFFFFFFFF;

const MaterialColor primaryWhite = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
