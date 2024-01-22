import 'package:flutter/material.dart';

import '../global/utils/color_app.dart';

class TestDelet extends StatefulWidget {
  const TestDelet({Key? key}) : super(key: key);

  @override
  State<TestDelet> createState() => _TestDeletState();
}

class _TestDeletState extends State<TestDelet> {
  final List<String> cars = ["Car", "Car", "Car", "Car1", "Car1", "Car1"];

  final List<String> uniqueValues = [
    "Car1",
    "Car2",
    "Car3",
    "Car4",
    "Car5",
    "Car6"
  ];

  String? selectedCarUniqueValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // DropdownButton
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 110),
            child: DropdownButton<String>(
              value: selectedCarUniqueValue,
              hint: Text("اختر سيارة"),
              items: List<DropdownMenuItem<String>>.generate(
                cars.length,
                (int index) {
                  return DropdownMenuItem<String>(
                    value: uniqueValues[index],
                    child: Text(cars[index]),
                  );
                },
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCarUniqueValue = newValue;
                  print('AAAAAAAAAAA');
                  print(selectedCarUniqueValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
