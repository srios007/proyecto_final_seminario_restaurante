import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../controllers/tour_controller.dart';
import '../widgets/labels.dart';
import '../widgets/tour_page.dart';

class TourView extends GetView<TourController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPopFunction,
      child: Scaffold(
        backgroundColor: Palette.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Palette.green,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    _MessageTour(controller: controller),
                    const Spacer(),
                    _DotsIndicatorTour(controller: controller),
                    const SizedBox(height: 10),
                    _TourButton(controller: controller),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageTour extends StatelessWidget {
  const _MessageTour({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TourController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 630,
      child: PageView(
        controller: controller.pageController,
        physics: const ClampingScrollPhysics(),
        children: [
          TourPage(
            context: context,
            title: 'Bienvenido a RondApp',
            imageRoute: imageReferences.tour1,
            label: labels.welcome(),
          ),
          TourPage(
            context: context,
            title: 'Todo mediante un App',
            imageRoute: imageReferences.tour2,
            label: labels.become(),
          ),
          TourPage(
            context: context,
            title: 'Encuentra y pide',
            imageRoute: imageReferences.tour3,
            label: labels.find(),
          ),
          TourPage(
            context: context,
            title: 'Con RondApp',
            imageRoute: imageReferences.tour4,
            label: labels.withLiz(),
          ),
        ],
      ),
    );
  }
}

class _DotsIndicatorTour extends StatelessWidget {
  const _DotsIndicatorTour({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TourController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotsIndicator(
          dotsCount: 4,
          position: controller.currentIndexPage.value,
          decorator: DotsDecorator(
            size: const Size.square(15.0),
            activeColor: Palette.purple,
            activeSize: const Size.square(15.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(width: 1.4),
            ),
            color: Palette.green,
          ),
        ),
      );
    });
  }
}

class _TourButton extends StatelessWidget {
  const _TourButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TourController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: PurpleButton(
        width: Get.width - 60,
        height: 70,
        onPressed: controller.buttonFunction,
        isLoading: false.obs,
      ),
    );
  }
}
