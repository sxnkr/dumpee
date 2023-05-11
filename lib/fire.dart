import 'package:dumpee/drop_off.dart';
import 'package:flutter/material.dart';

class Fire extends StatefulWidget {
  const Fire({super.key});

  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> {
  @override
  Widget build(BuildContext context) {
    var pad = (MediaQuery.of(context).size.width / 8);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Throw it away, but with a cause, lets save our planet.',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(pad, 0, pad, 10),
            child: Image.asset('assets/gb.jpg'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DropOff()),
              );
            },
            color: Colors.deepPurpleAccent,
            child: const Text(
              'Drop Off',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
