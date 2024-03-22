class ForTime {
  static Future after(int time, Function? aftertimeCallBack,
      [bool? milisec = false]) async {
    Future.delayed(
        Duration(
            seconds: milisec! ? 0 : time,
            milliseconds: milisec ? time : 0), () {
      aftertimeCallBack != null ? aftertimeCallBack.call() : null;
    });
  }
}
