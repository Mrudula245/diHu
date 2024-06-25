import 'package:flutter/material.dart';

class AppointmentModel {
  final String id;
  final DateTime date;
  final TimeOfDay time;
  final String userId;
  final bool isConfirmed;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.time,
    required this.userId,
    this.isConfirmed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': '${time.hour}:${time.minute}', // Store time as a string
      'userId': userId,
      'isConfirmed': isConfirmed,
    };
  }
}
