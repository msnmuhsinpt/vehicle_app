import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_app/db/vehicle_db.dart';
import 'package:drift/drift.dart' as dr;

import '../../app_text_field.dart';
import '../../app_text_view.dart';
import '../../util/app_ constant.dart';
import '../../util/app_color.dart';

class AddVehicle extends StatelessWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDatabase appDatabase = Provider.of<AppDatabase>(context);

    final TextEditingController _vehicleNumber = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                appDatabase
                    .insertVehicle(VehicleCompanion(
                  vehicleNumber: dr.Value(_vehicleNumber.text),
                  vehicleStatus: const dr.Value(true),
                ))
                    .then(
                      (value) => Navigator.pop(context),
                );
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
