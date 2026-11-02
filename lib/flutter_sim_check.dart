import 'dart:async';
import 'package:flutter/services.dart';

/// Information about the SIM card and cellular network.
class SimInfo {
  /// Indicates whether a SIM card is present and detected in the device.
  final bool hasSimCard;

  /// Carrier / network operator name, if available.
  final String? carrierName;

  /// Mobile Country Code (MCC), if available.
  final String? mcc;

  /// Mobile Network Code (MNC), if available.
  final String? mnc;

  /// Creates a new [SimInfo] instance.
  SimInfo({required this.hasSimCard, this.carrierName, this.mcc, this.mnc});

  /// Creates a [SimInfo] instance parsed from a method channel response [map].
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

/// Main class for querying SIM card status and carrier details.
class FlutterSimCheck {
  static const MethodChannel _channel = MethodChannel('flutter_sim_check');

  /// Fetches detailed SIM information including presence, carrier name, MCC, and MNC.
  static Future<SimInfo> getSimInfo() async {
    try {
      final map =
          await _channel.invokeMethod<Map<dynamic, dynamic>>('getSimInfo');
      return SimInfo.fromMap(map ?? {});
    } catch (_) {
      return SimInfo(hasSimCard: false);
    }
  }

  /// Quickly checks whether any SIM card is present on the device.
  static Future<bool> hasSimCard() async {
    final info = await getSimInfo();
    return info.hasSimCard;
  }
}
