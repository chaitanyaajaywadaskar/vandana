import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabji Probability',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SabjiProbabilityPage(),
    );
  }
}

class SabjiProbabilityPage extends StatefulWidget {
  const SabjiProbabilityPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SabjiProbabilityPageState createState() => _SabjiProbabilityPageState();
}

class _SabjiProbabilityPageState extends State<SabjiProbabilityPage> {
  List<String> sabjiNames = ["Methi", "Malay Kofta", "Kofta"];

  List<Map<String, dynamic>> probabilityList = [];

  @override
  void initState() {
    super.initState();
    generateProbabilityList();
  }

  void generateProbabilityList() {
    List<List<String>> combinations = _generateCombinations(sabjiNames);
    int totalCombinations = combinations.length;
    double probability = 1 / totalCombinations;

    setState(() {
      probabilityList = combinations.map((combo) {
        return {"combination": combo, "probability": probability};
      }).toList();
    });
  }

  List<List<String>> _generateCombinations(List<String> elements) {
    List<List<String>> result = [];
    for (int i = 0; i < elements.length; i++) {
      for (int j = 0; j < elements.length; j++) {
        if (i != j) {
          result.add([elements[i], elements[j]]);
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sabji Probability'),
      ),
      body: ListView.builder(
        itemCount: probabilityList.length,
        itemBuilder: (context, index) {
          final combination =
              probabilityList[index]['combination'] as List<String>;
          final probability = probabilityList[index]['probability'] as double;
          return ListTile(
            title: Text('${combination[0]} - ${combination[1]}'),
            subtitle: Text('Probability: ${probability.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
