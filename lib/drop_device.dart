import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DropDevice extends StatefulWidget {
  final String val;
  DropDevice({super.key, required this.val});

  @override
  State<DropDevice> createState() => _DropDeviceState();
}

class _DropDeviceState extends State<DropDevice> {

  var loading = true;
  var dateDiff=0;
  var device;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var statusIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date1 = DateTime.parse("2023-05-08");
    DateTime date2 = DateTime.now();

    dateDiff = daysBetween(date1, date2);
    print(dateDiff);
    device = widget.val;
    FirebaseFirestore.instance
        .collection('devices')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['val'] == device){
          statusIndex = doc['status'];
        }
      });
      setState(() {
        loading=false;
      });
    });
  }

  // Collection, Sorting and Segregation, Dismantling and Shredding, Seperation and Recovery, Refining, Disposal of Residual Waste

  var tracks = [
    'Collection',
    'Sorting and Segregation',
    'Dismantling and Shredding',
    'Seperation and Recovery',
    'Refining',
    'Disposal of Residual Waste'
  ];
  @override
  Widget build(BuildContext context) {
    var pad = (MediaQuery.of(context).size.width / 8);
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
        ):SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(pad, 10, pad, 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/bins.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Awesome Amigos, Thank you for you time for dropping off your " +
                        "e-waste, I'll take good care of it. ;)"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Track the status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Next shipment in $dateDiff days',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 179, 177, 177)),
                ),
                SizedBox(height: 20,),
                Column(
                  children: trackWidgets(),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ));
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Widget purpleContainer(text, status) {
    return Container(
      color: status == true
          ? const Color.fromARGB(255, 199, 179, 255)
          : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: status == true ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  List<Widget> trackWidgets() {
    List<Widget> widgets = [];
    for (int i = 0; i < 6; i++) {
      var status = statusIndex == i;
      widgets.add(purpleContainer(tracks[i], status));
      if (i != 5)
        widgets.add(Icon(
          Icons.arrow_drop_down,
          size: 35,
        ));
    }
    return widgets;
  }
}
