import 'package:flutter/material.dart';
import 'package:vehicle_app/view/widget/app_text_view.dart';

import '../../../boxes.dart';
import '../../../db/vehicle_db.dart';
import '../../../util/app_ constant.dart';
import '../../../util/app_color.dart';
import '../../widget/app_text_field.dart';

class AddVehicle extends StatelessWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _vehicleNumber = TextEditingController();
    return AlertDialog(
      title: appTextView(name: 'Add Vehicle', isBold: true),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _vehicleNumber,
            hintText: 'Number',
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: commonPaddingAll,
          child: SizedBox(
            height: 40,
            width: screenWidth(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.kBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (_vehicleNumber.text == "") {
                  final snackBar = SnackBar(
                    content: appTextView(
                        name: 'Add Vehicle Number',
                        isBold: true,
                        color: AppColor.kWhite),
                    backgroundColor: AppColor.kRed,
                    elevation: 0,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final vehicle = Vehicle()
                    ..number = _vehicleNumber.text.toString()
                    ..isRunning = true
                    ..startTime = DateTime.now().toString()
                    ..animationValue = 0.00;
                  final box = Boxes.getData();
                  box.add(vehicle);
                  Navigator.pop(context);
                }
              },
              child: appTextView(
                  name: 'Submit', isBold: true, color: AppColor.kWhite),
            ),
          ),
        ),
      ],
    );
  }
}
