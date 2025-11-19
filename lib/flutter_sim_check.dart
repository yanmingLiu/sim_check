import 'dart:async';
import 'package:flutter/services.dart';

class SimInfo {
  final bool hasSimCard;
  final String? carrierName;
  final String? mcc;
  final String? mnc;

  SimInfo({required this.hasSimCard, this.carrierName, this.mcc, this.mnc});

  factory SimInfo.fromMap(Map<dynamic, dynamic> map) {
    return SimInfo(
      hasSimCard: map['hasSimCard'] ?? false,
      carrierName: map['carrierName'],
      mcc: map['mcc'],
      mnc: map['mnc'],
    );
  }

  @override
  String toString() {
    return 'SimInfo(hasSimCard: $hasSimCard, carrierName: $carrierName, mcc: $mcc, mnc: $mnc)';
  }
}

class FlutterSimCheck {
  static const MethodChannel _channel = MethodChannel('flutter_sim_check');

  static Future<SimInfo> getSimInfo() async {
    try {
      final map = await _channel.invokeMethod<Map<dynamic, dynamic>>('getSimInfo');
      return SimInfo.fromMap(map ?? {});
    } catch (_) {
      return SimInfo(hasSimCard: false);
    }
  }

  static Future<bool> hasSimCard() async {
    final info = await getSimInfo();
    return info.hasSimCard;
  }
}
