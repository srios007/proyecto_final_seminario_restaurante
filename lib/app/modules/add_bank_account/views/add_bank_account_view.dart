import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_bank_account_controller.dart';

class AddBankAccountView extends GetView<AddBankAccountController> {
  const AddBankAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBankAccountView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddBankAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
