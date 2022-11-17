import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vehicle_app/boxes.dart';
import 'package:vehicle_app/db/vehicle_db.dart';
import 'package:vehicle_app/view/add_vehicle/add_vehicle_page.dart';
import '../../widget/app_text_view.dart';
import '../../../util/app_ constant.dart';
import '../../../util/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var progressValue = 0.00;
  var pValue = 0.00;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appTextView(
            name: "Vehicle List",
            isBold: true,
            size: 19,
            color: AppColor.kWhite),
        backgroundColor: AppColor.kBlue,
      ),
      body: Padding(
        padding: commonPaddingAll,
        child: Column(
          children: [
            ValueListenableBuilder<Box<Vehicle>>(
                valueListenable: Boxes.getData().listenable(),
                builder: (context, box, _) {
                  final vehicle = box.values.toList().cast<Vehicle>();

                  return Expanded(
                    child: vehicleListUi(vehicle),
                  );
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: AppColor.kBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddVehicle()),
          );
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget vehicleListUi(List<Vehicle> vehicle) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: vehicle.length,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (context, index) => dividerSH(),
        itemBuilder: (context, index) {
          String number = vehicle[index].number.toString();
          bool isRunning = vehicle[index].isRunning;
          var value = vehicle[index].animationValue;
          _updateProgress(vehicle, index);
          return vehicle.isEmpty
              ? Center(
                  child: appTextView(
                      name: 'No Vehicle Listed Add Vehicle', isBold: true),
                )
              : isRunning
                  ? SizedBox(
                      height: 60,
                      width: screenWidth(context),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: appTextView(name: number, isBold: true),
                          trailing: CircularProgressIndicator(
                            strokeWidth: 10,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColor.kGreen,
                            ),
                            value: value,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.kRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: screenWidth(context),
                      child: Center(
                        child: appTextView(
                            name: 'Running',
                            isBold: true,
                            color: AppColor.kWhite),
                      ),
                    );
        },
      ),
    );
  }

  void _updateProgress(List<Vehicle> vehicle, int index) {
    bool isTimerClose = false;
    var addedTime = vehicle[index].startTime;
    var isRunning = vehicle[index].isRunning;
    var vehicleNumber = vehicle[index].number;
    var value = vehicle[index].animationValue;

    for (int i = 0; i < vehicle.length; i++) {
      if (vehicle[i].isRunning == false) {
        isTimerClose = true;
      } else {
        isTimerClose = false;
      }
    }

    var aTime = DateTime.parse(addedTime);
    const oneSec = Duration(seconds: 1);
    isTimerClose
        ? Container()
        : Timer.periodic(oneSec, (Timer t) {
            var cTime = DateTime.now();
            final difference = cTime.difference(aTime).inSeconds;
            if (difference >= 3) {
              //value update
              final vehicleUpdateRunning = Vehicle()
                ..number = vehicleNumber
                ..isRunning = false
                ..startTime = addedTime
                ..animationValue = value;
              final box = Boxes.getData();
              box.putAt(index, vehicleUpdateRunning);
            } else {
              setState(() {
                //value
                pValue = (difference / 3);

                final vehicleUpdateValue = Vehicle()
                  ..number = vehicleNumber
                  ..isRunning = isRunning
                  ..startTime = addedTime
                  ..animationValue = pValue.toDouble();
                final box = Boxes.getData();
                box.putAt(index, vehicleUpdateValue);
              });
            }
          });
  }
}
