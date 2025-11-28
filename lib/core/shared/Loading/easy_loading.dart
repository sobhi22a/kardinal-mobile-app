import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

enum EasyLoadingEnum {
  dismiss,
  loading,
  toast,
  success,
  error,
  info,
  progress,
  show,
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

void easyLoading ($message, type, {second = 2}) async {
  switch(type){
    case EasyLoadingEnum.error:
      EasyLoading.instance
        ..errorWidget = const Icon(Icons.error_outlined, color: ColorFile.error, size: 40,)
        ..loadingStyle = EasyLoadingStyle.light
        ..textColor = ColorFile.error
        ..textStyle = const TextStyle(color: ColorFile.error, fontSize: 18)
        ..indicatorSize = 45.0;
      EasyLoading.showError($message, duration: Duration(seconds: second), maskType: EasyLoadingMaskType.black,);
      break;
    case EasyLoadingEnum.info:
      EasyLoading.showInfo($message,duration: Duration(seconds: second));
      break;
    case EasyLoadingEnum.success:
      EasyLoading.instance
        ..successWidget = const Icon(Icons.check, color: ColorFile.blackColor, size: 40,)
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorColor = Colors.black
        ..textColor = Colors.black
        ..textStyle = const TextStyle(color: ColorFile.blackColor, fontSize: 18)
        ..indicatorSize = 45.0;
      EasyLoading.showSuccess($message, duration: Duration(seconds: second), maskType: EasyLoadingMaskType.black,);
      break;
    case EasyLoadingEnum.toast:
      EasyLoading.showToast($message, duration: Duration(seconds: second),
        toastPosition: EasyLoadingToastPosition.bottom,
        maskType: EasyLoadingMaskType.black,);
      break;
    case EasyLoadingEnum.loading:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorType = EasyLoadingIndicatorType.circle
        ..indicatorColor = Colors.blue
        ..textColor = Colors.blue
        ..textStyle = const TextStyle(color: ColorFile.whiteColor)
        ..indicatorSize = 45.0;
      EasyLoading.show(status: $message, maskType: EasyLoadingMaskType.black,);
      break;
    case EasyLoadingEnum.progress:
      double progress = 0;
      EasyLoading.showProgress(progress, status: '${(progress * 100).toStringAsFixed(0)}%', maskType: EasyLoadingMaskType.black,);
      break;
    case EasyLoadingEnum.dismiss:
      EasyLoading.dismiss();
      break;
  }
}