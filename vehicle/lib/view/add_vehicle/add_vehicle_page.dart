import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vehicle_app/db/vehicle_db.dart';

import '../../app_text_field.dart';
import '../../app_text_view.dart';
import '../../boxes.dart';
import '../../util/app_ constant.dart';
import '../../util/app_color.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final TextEditingController _vehicleNumber = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextField(
            controller: _vehicleNumber,
            hintText: 'Number',
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
          ),
          dividerH(),
          SizedBox(
            width: screenWidth(context) - 20,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.kBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final vehicle = Vehicle()
                  ..number = _vehicleNumber.text.toString()
                  ..isRunning = true;

                final box = Boxes.getData();
                box.add(vehicle);
                Navigator.pop(context);
              },
              child: appTextView(
                  name: 'Submit', isBold: true, color: AppColor.kWhite),
            ),
          )
        ],
      ),
    );
  }
}
