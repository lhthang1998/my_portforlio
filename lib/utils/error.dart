import 'package:flutter/material.dart';
import 'package:get/get.dart';

showError(msg) {
  Get.snackbar("", "",
      duration: Duration(milliseconds: 1000),
      titleText: Text(
        "Failed",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      messageText: Text(
        msg,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red);
}

showSuccesfull(msg) {
  Get.snackbar("", "",
      duration: Duration(milliseconds: 1000),
      titleText: Text(
        "Successfully",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      messageText: Text(
        msg,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green);
}
