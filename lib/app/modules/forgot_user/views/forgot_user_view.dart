import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_user_controller.dart';

class ForgotUserView extends GetView<ForgotUserController> {
  const ForgotUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotUserView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ForgotUserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
