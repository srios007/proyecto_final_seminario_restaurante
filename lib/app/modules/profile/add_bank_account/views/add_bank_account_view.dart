import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/purple_button.dart';
import '../controllers/add_bank_account_controller.dart';

class AddBankAccountView extends GetView<AddBankAccountController> {
  const AddBankAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Cuenta bancaria',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Text(
              'Agrega una\ncuenta bancaria',
              textScaleFactor:
                  context.textScaleFactor > 1.2 ? 1.2 : context.textScaleFactor,
              style: const TextStyle(
                color: Palette.darkBlue,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            _BankAccountForm(controller: controller),
            const SizedBox(height: 40),
            PurpleButton(
              isLoading: controller.isLoading,
              onPressed: controller.createBankAccount,
              buttonText: 'Guardar',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _BankAccountForm extends StatelessWidget {
  const _BankAccountForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddBankAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formKeyNewBankAccount,
        child: Column(
          children: [
            _DropdownField(
              controller: controller,
              title: 'Nombre del banco',
              dropdownItems: controller.getAvailableBanks(),
              onChanged: controller.changeBankName,
              selectedValue: controller.bankName.value,
            ),
            const SizedBox(height: 25),
            _DropdownField(
              controller: controller,
              title: 'Tipo de cuenta',
              dropdownItems: controller.getAvailableAccountTypes(),
              onChanged: controller.changeAccountType,
              selectedValue: controller.accountType.value,
            ),
            const SizedBox(height: 25),
            _InputField(
              title: 'Número de cuenta',
              hintText: 'Ej: 1234 5678 9012 3456',
              textController: controller.accountNumberController,
              validator: controller.validateAccountNumber,
              errorIndicator: controller.accountNumberError,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 25),
            _InputField(
              title: 'Titular de la cuenta',
              hintText: 'Ej: Pedro López',
              textController: controller.accountOwnerNameController,
              validator: controller.validateAccountOwnerName,
              errorIndicator: controller.accountOwnerNameError,
            ),
            const SizedBox(height: 25),
            _DropdownField(
              controller: controller,
              title: 'Tipo de documento del titular',
              dropdownItems: controller.getTypeIds(),
              onChanged: controller.changeTypeId,
              selectedValue: controller.typeId.value,
            ),
            const SizedBox(height: 25),
            _InputField(
              title: 'Documento del titular',
              hintText: 'Ej: 1927364412',
              textController: controller.accountOwnerIdController,
              validator: controller.validateAccountOwnerId,
              errorIndicator: controller.accountOwnerIdError,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    Key? key,
    required this.controller,
    required this.title,
    required this.dropdownItems,
    required this.onChanged,
    required this.selectedValue,
  }) : super(key: key);

  final AddBankAccountController controller;
  final String title;
  final List<DropdownMenuItem<String>> dropdownItems;
  final void Function(String?) onChanged;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Palette.purple,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: Get.width,
            height: 50,
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Palette.gray,
                width: 2,
              ),
            ),
            child: DropdownButton<String>(
              underline: const SizedBox.shrink(),
              value: selectedValue,
              isExpanded: true,
              icon: const Icon(CupertinoIcons.chevron_down),
              iconEnabledColor: Palette.green,
              iconSize: 20,
              elevation: 0,
              style: const TextStyle(
                color: Palette.darkBlue,
                // fontSize: responsive.font16,
              ),
              dropdownColor: Palette.white,
              focusColor: Palette.gray,
              onChanged: onChanged,
              items: dropdownItems,
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.textController,
    required this.validator,
    required this.errorIndicator,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final RxBool errorIndicator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Palette.purple,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
              width: Get.width,
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Palette.gray,
                  width: 2,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Palette.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  errorStyle: styles.errorStyle,
                ),
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                controller: textController,
                validator: validator,
              )),
          Obx(() => errorIndicator.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Por favor, rellena este campo',
                    style: styles.errorStyle,
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
