import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.purchase.meal!.name!),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
