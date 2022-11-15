import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vehicle_app/boxes.dart';
import 'package:vehicle_app/db/vehicle_db.dart';
import 'package:vehicle_app/view/add_vehicle/add_vehicle_page.dart';

import '../../../app_text_view.dart';
import '../../../util/app_ constant.dart';
import '../../../util/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
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
      body: Column(
        children: [
          ValueListenableBuilder<Box<Vehicle>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                final vehicle = box.values.toList().cast<Vehicle>();

                return Expanded(
                  child: ListView(
                    children: [
                      vehicleListUi(vehicle),
                    ],
                  ),
                );
              }),
        ],
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
          return vehicle.isEmpty
              ? Center(
                  child: appTextView(
                      name: 'No Vehicle Listed Add Vehicle', isBold: true),
                )
              : isRunning
                  ? SizedBox(
                      height: 85,
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                              title: appTextView(name: number),
                              trailing: CircularPercentIndicator(
                                animation: true,
                                radius: 20.0,
                                percent: 1.0,
                                progressColor: Colors.green,
                                animationDuration: 3000,
                                onAnimationEnd: () {
                                  final vehicleUpdate = Vehicle()
                                    ..number = number
                                    ..isRunning = false;
                                  final box = Boxes.getData();
                                  box.putAt(index, vehicleUpdate);
                                  //  vehicleUpdate.save();
                                },
                              )),
                        ),
                        onTap: () {
                          log('Status >> $isRunning');
                        },
                      ),
                    )
                  : InkWell(
            onTap: ()=>log("Status>>> $isRunning") ,
                    child: Container(
                        color: AppColor.kRed,
                        child: Center(
                          child: appTextView(
                              name: 'Running',
                              isBold: true,
                              color: AppColor.kWhite),
                        ),
                      ),
                  );
        },
      ),
    );
  }
}
