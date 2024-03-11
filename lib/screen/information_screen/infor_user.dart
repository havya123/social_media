import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/extension/date_dropdown.dart';
import 'package:social_media/manage/controller/information_controller.dart';
import 'package:social_media/widgets/button.dart';
import 'package:social_media/widgets/input_widget.dart';

class InforUserScreen extends StatelessWidget {
  const InforUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? day;
    String? month;
    String? year;

    final formKey = GlobalKey<FormState>();
    var controller = Get.find<InformationController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
              ),
              spaceHeight(context),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: controller.nameController,
                      hint: "Fullname",
                      errorText: "Please enter name",
                      borderRadius: 15,
                    ),
                    spaceHeight(context),
                    TextFieldWidget(
                      controller: controller.emailController,
                      hint: "Email",
                      errorText: "Please enter email",
                      borderRadius: 15,
                      type: TextInputType.emailAddress,
                    ),
                    spaceHeight(context),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "DOB",
                        style: TextStyle(color: Color(0xffBAB8B8)),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, height: 0.2),
                      width: double.infinity,
                      child: DropdownDatePickerVN(
                        locale: 'en',
                        inputDecoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10))), // optional
                        isDropdownHideUnderline: true, // optional
                        isFormValidator: true,
                        errorDay: "Please select day",
                        errorMonth: "Please select month",
                        errorYear: "Please select year", // optional
                        startYear: 1950, // optional
                        endYear: DateTime.now().year, // optional
                        width: 5,
                        monthFlex: 4,
                        dayFlex: 2,
                        yearFlex: 3,
                        hintTextStyle: const TextStyle(fontSize: 15),
                        // selectedDay: 14,/ optional
                        onChangedDay: (value) {
                          day = value;
                        },
                        onChangedMonth: (value) {
                          month = value;
                        },
                        onChangedYear: (value) {
                          year = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              spaceHeight(context),
              ButtonWidget(
                function: () async {
                  if (formKey.currentState!.validate()) {
                    controller.dob = "$day/$month/$year";
                    await controller.updateInforUser();
                    await Future.delayed(const Duration(seconds: 2), () {});
                    Get.toNamed(RouteName.categoryRoute);
                  }
                },
                textButton: "Continue",
              )
            ],
          ),
        ),
      ),
    );
  }
}
