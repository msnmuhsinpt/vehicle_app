import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_app/view/add_vehicle/add_vehicle_page.dart';
import '../../../app_text_view.dart';
import '../../../db/vehicle_db.dart';
import '../../../util/app_ constant.dart';
import '../../../util/app_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDatabase appDatabase = Provider.of<AppDatabase>(context);

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
      body: RefreshIndicator(
        onRefresh: () {
          return _getVehicleFromDatabase(appDatabase);
        },
        child: ListView(
          children: [
            FutureBuilder<List<VehicleData>>(
              future: _getVehicleFromDatabase(appDatabase),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  log("InitialDataCall>>> ${snapshot.data!.length}");
                  List<VehicleData>? vehicleList = snapshot.data;

                  if (vehicleList != null) {
                    if (vehicleList.isEmpty) {
                      return Center(
                        child: appTextView(
                            name:
                                'No vehicles Found, Click on add button to add new vehicle',
                            isBold: true,
                            maxLines: 3),
                      );
                    } else {
                      return vehicleListUi(vehicleList, appDatabase);
                    }
                  }
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ));
                }
                return Center(
                  child: appTextView(
                      name: 'Click on add button to add new  Vehicle',
                      isBold: true,
                      maxLines: 3),
                );
              },
            ),
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

  Future<List<VehicleData>> _getVehicleFromDatabase(
      AppDatabase appDatabase) async {
    return await appDatabase.getVehicleList();
  }

  Widget vehicleListUi(List<VehicleData> vehicleList, AppDatabase appDatabase) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: vehicleList.length,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (context, index) => dividerSH(),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 85,
            child: InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                    title: appTextView(
                        name: vehicleList[index].vehicleNumber, isBold: true),
                    trailing: CircularPercentIndicator(
                      animation: true,
                      radius: 20.0,
                      percent: 1.0,
                      progressColor: Colors.green,
                      animationDuration: 3000,
                      onAnimationEnd: () {
                        appDatabase.updateVehicle(
                          VehicleData(
                              id: vehicleList[index].id,
                              vehicleNumber: vehicleList[index].vehicleNumber,
                              vehicleStatus: false),
                        );
                        log("ChangeStatus${vehicleList[index].vehicleStatus}");
                      },
                    )),
              ),
              onTap: () {
                log("CStatus>>> ${vehicleList[index].vehicleStatus}");
                log("CSNumber>>> ${vehicleList[index].vehicleNumber}");
                log("CSId>>> ${vehicleList[index].id}");
              },
            ),
          );
        },
      ),
    );
  }
}
