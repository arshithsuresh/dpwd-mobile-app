import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dpwdapp/components/cards/ComplaintCardSmall.dart';
import 'package:path/path.dart';
import 'package:dpwdapp/api/ComplaintAPI.dart';
import 'package:dpwdapp/components/buttons/PrimaryButton.dart';
import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/complaintModel.dart';
import 'package:dpwdapp/state/complaints/ComplaintProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as gMapLoc;

import 'package:crypto/crypto.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({Key key}) : super(key: key);

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtShortDesc = TextEditingController();
  final TextEditingController txtDesc = TextEditingController();
  final TextEditingController txtCreatedDate = TextEditingController();
  final TextEditingController txtRegion = TextEditingController();

  File complaintImage;

  Completer<GoogleMapController> _controller = Completer();
  Marker _pickMarker;
  LatLng pickedLocation;

  String txtComplaintType = ComplaintType[0];
  gMapLoc.Location location = gMapLoc.Location();

  dummyProjectInfo() {
    txtTitle.text = "CHNGR - TVLA Bypass";
    final curDate = DateTime.now().toString();
    txtCreatedDate.text = curDate.substring(0, curDate.length - 10);
    txtShortDesc.text = "Pothole on road. High";
    txtDesc.text = "Pothole on road. Very bad condition of road";
    txtRegion.text = pickedLocation == null ? "" : pickedLocation.toString();
  }

  @protected
  @mustCallSuper
  void initState() {
    dummyProjectInfo();
  }

  Future<void> pickComplaintLocation(context) async {
    final selectedLatLng = await pickLocation(context);
    final encodedRegion = await ComplaintAPI().encodeToRegion(
        latLng: Location(
            lat: selectedLatLng.latitude, lng: selectedLatLng.longitude));
    setState(() {
      txtRegion.text = encodedRegion;
    });
    print("INFO :: Encoded Region ${encodedRegion}");
    final complaints =
        await Provider.of<ComplaintProvider>(context, listen: false)
            .getComplaintsByRegion(region: encodedRegion);

    if (complaints.length > 0) {
      showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Previous Complaints"),
                content: Container(
                    child: ListView.builder(
                        itemCount: complaints.length,
                        itemBuilder: ((context, index) => ComplaintCardSmall(
                              complaint: complaints[index],
                            )))));
          });
    } else {
      print("No Previous Complaints");
    }
  }

  Future<LatLng> pickLocation(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: location.getLocation(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
              } else {
                final gMapLoc.LocationData location = snapshot.data;
                if (_pickMarker == null)
                  _pickMarker = Marker(
                    markerId: MarkerId("picker"),
                    position: LatLng(location.latitude, location.longitude),
                  );
                print("Data");
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  margin:
                      EdgeInsets.only(top: 30, bottom: 80, left: 12, right: 12),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: GoogleMap(
                          markers: {_pickMarker},
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onTap: (latlng) {
                            setState(() {
                              pickedLocation = latlng;
                              _pickMarker = Marker(
                                  markerId: MarkerId("picker"),
                                  position: latlng);
                            });
                            Navigator.pop(context);
                          },
                          initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(location.latitude, location.longitude),
                              zoom: 18),
                          mapType: MapType.normal,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            "Pick a Location. Default : user location.",
                            style: TextStyle(
                                fontSize: 12,
                                backgroundColor: Colors.white,
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        });
    return pickedLocation;
  }

  Future<bool> createComplaint(context) async {
    final txtBID = sha256
        .convert(utf8.encode(txtTitle.text + txtCreatedDate.text))
        .toString();

    if (txtBID.length < 5 ||
        txtShortDesc.text.length < 5 ||
        txtDesc.text.length < 10 ||
        txtCreatedDate.text.length < 4 ||
        txtRegion.text.length < 2 ||
        complaintImage == null) {
      return false;
    }

    String userid =
        Provider.of<UserProvider>(context, listen: false).curUser.id;

    Complaint complaintData = Complaint(
      bid: txtBID,
      complaintID: txtBID,
      createdBy: userid,
      createdDate: txtCreatedDate.text,
      detailedDesc: txtDesc.text,
      shortDesc: txtShortDesc.text,
      location:
          Location(lat: pickedLocation.latitude, lng: pickedLocation.longitude),
      region: txtRegion.text,
      signatures: [],
      title: txtTitle.text,
      type: txtComplaintType,
      status: 0,
      upVotes: [],
    );

    final result = await Provider.of<ComplaintProvider>(context, listen: false)
        .createComplaint(complaintData, complaintImage, userid);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(234, 234, 234, 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 32, right: 32, top: 80),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Register Complaint",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Complaint Subject"),
                          TextField(
                            controller: txtTitle,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Text("Short Description"),
                          TextField(
                            controller: txtShortDesc,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Text("Description"),
                          TextField(
                            minLines: 3,
                            maxLines: 3,
                            controller: txtDesc,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pick Location"),
                                  Container(
                                    width: 200,
                                    child: TextField(
                                      controller: txtRegion,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(left: 4),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await pickComplaintLocation(context);
                                    },
                                    child: Icon(Icons.location_pin),
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: Size(60, 50),
                                        minimumSize: Size(60, 50)),
                                  ))
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("Complaint Image"),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "${complaintImage == null ? "Not Selected" : basename(complaintImage.path)}")),
                              SizedBox(
                                width: 4,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      final result =
                                          await FilePicker.platform.pickFiles();

                                      if (result != null) {
                                        setState(() {
                                          complaintImage =
                                              File(result.files.single.path);
                                        });
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  child: Text("Select Image")),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("Created Date"),
                          TextField(
                            controller: txtCreatedDate,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Text("Complaint Type"),
                          DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    )),
                              ),
                              value: txtComplaintType,
                              items:
                                  ComplaintType.map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (item) {
                                txtComplaintType = item;
                              }),
                          SizedBox(height: 8),
                          PrimaryButton(
                              title: "Create",
                              onPressed: () {
                                createComplaint(context).then((value) {
                                  if (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Complaint Registered!")));
                                    Future.delayed(
                                        Duration(seconds: 3),
                                        () => Navigator.popAndPushNamed(context,
                                            AppRoutes.ROUTE_Dashboard));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Error! Complaint Registered failed")));
                                  }
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
