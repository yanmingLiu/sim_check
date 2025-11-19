import 'package:flutter/material.dart';
import 'package:flutter_sim_check/flutter_sim_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_sim_check example',
      home: const SimPage(),
    );
  }
}

class SimPage extends StatefulWidget {
  const SimPage({super.key});
  @override
  State<SimPage> createState() => _SimPageState();
}

class _SimPageState extends State<SimPage> {
  String text = 'Loading...';
  @override
  void initState() {
    super.initState();
    _load();
  }
  Future<void> _load() async {
    final info = await FlutterSimCheck.getSimInfo();
    setState(() {
      text = 'hasSim: ${info.hasSimCard}\ncarrier: ${info.carrierName ?? "-"}\nMCC: ${info.mcc ?? "-"}\nMNC: ${info.mnc ?? "-"}';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SIM Check Example')),
      body: Center(child: Text(text)),
    );
  }
}
