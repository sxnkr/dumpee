import 'package:dumpee/drop_device.dart';
import 'package:flutter/material.dart';

class DropOff extends StatefulWidget {
  const DropOff({super.key});

  @override
  State<DropOff> createState() => _DropOffState();
}

class _DropOffState extends State<DropOff> {
  static const List<String> list = <String>[
    '',
    '1AXE3',
    'ASF3S',
  ];
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('DumpE'),
        centerTitle: true,
      ),
      body: Container(
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
                    if (dropdownValue != '')
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DropDevice()),
                      );
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
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