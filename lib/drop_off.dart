import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumpee/drop_device.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DropOff extends StatefulWidget {
  const DropOff({super.key});

  @override
  State<DropOff> createState() => _DropOffState();
}

class _DropOffState extends State<DropOff> {

  var loading = true;
  var nearbyList = [''];
  var refIDs = ['',];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference devices = FirebaseFirestore.instance.collection('devices');
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('devices')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        refIDs.add(doc.reference.id);
        nearbyList.add(doc["val"]);
      });
      setState(() {
        loading=false;
      });
    });
  }

  String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DumpE'),
        centerTitle: true,
      ),
      body: loading == true ? Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 50,
        ),
      ):
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 90,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 199, 179, 255),
                border: Border.all(
                  color: Colors.deepPurple,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  'Select the nearest drop off device',
                  style: TextStyle(color: Colors.black),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward, color: Colors.black),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                    var i = nearbyList.indexOf(dropdownValue);

                    devices
                        .doc(refIDs[i])
                        .update({'open': 1})
                        .then((value) => print("Updated"))
                        .catchError((error) => print("Failed to update user: $error"));


                    if (dropdownValue != '')
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DropDevice(val: dropdownValue)),
                      );
                  },
                  items: nearbyList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
