import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/appointment_model.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'appointments';

  Future<void> createAppointment(AppointmentModel appointment) async {
    try {
      await _firestore.collection(_collectionName).doc(appointment.id).set(appointment.toMap());
    } catch (e) {
      // Handle error
      print('Error creating appointment: $e');
    }
  }

  Stream<List<AppointmentModel>> getAppointments() {
    try {
      return _firestore.collection(_collectionName).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          // Extract date from Timestamp
          DateTime date = (doc['date'] as Timestamp).toDate();

          // Extract TimeOfDay from string representation of time
          List<String> timeParts = (doc['time'] as String).split(':');
          TimeOfDay time = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );

          // Create AppointmentModel
          return AppointmentModel(
            id: doc.id,
            date: date,
            time: time,
            userId: doc['userId'],
            isConfirmed: doc['isConfirmed'] ?? false,
          );
        }).toList();
      });
    } catch (e) {
      // Handle error
      print('Error getting appointments: $e');
      return Stream.empty();
    }
  }
}
