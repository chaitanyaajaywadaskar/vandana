import 'package:flutter/material.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Models/get_time_slot_model.dart';

import 'package:vandana/controllers/billing_controller.dart';
import 'package:get/get.dart';

import '../Constant/static_decoration.dart';
import '../Controllers/tifin_billing_controller.dart';

void showTimeSlotePopUP(
  BuildContext context,
  List TimeSlotList,
  bool fromLunh,
) {
  print("List data check ==> ${TimeSlotList.length}");
  TifinBillingController tifinBillingController =
      Get.put(TifinBillingController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selct Time Slot",
                style: TextStyleConstant.bold20().copyWith(
                    color: ColorConstant.appMainColor,
                    fontWeight: FontWeight.w500),
              ),
              height10,
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: TimeSlotList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        fromLunh == true
                            ? tifinBillingController.selectedLunchTime.value =
                                TimeSlotList[index].timeslot
                            : tifinBillingController.selectedDinnerTime.value =
                                TimeSlotList[index].timeslot;
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorConstant.appMainColor),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.appMainColor,
                                ),
                              ),
                            ),
                            width10,
                            Text(
                              TimeSlotList[index].timeslot,
                              style: TextStyleConstant.regular16().copyWith(
                                  color: ColorConstant.appMainColorLite),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
