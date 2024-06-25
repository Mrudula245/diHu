import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../models/guide_model.dart';

class AppointmentFormScreen extends StatefulWidget {
  final String userId;
  final GuideModel? guide;

  AppointmentFormScreen({required this.userId, this.guide});

  @override
  _AppointmentFormScreenState createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Reference to Firestore collection
  final CollectionReference appointmentsCollection =
  FirebaseFirestore.instance.collection('appointments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Schedule Appointment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Schedule Appointment',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.date_range, color: Colors.white),
                label: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${_selectedDate!.toString().substring(0, 10)}',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                icon: Icon(Icons.access_time, color: Colors.white),
                label: Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : 'Time: ${_selectedTime!.format(context)}',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null && pickedTime != _selectedTime) {
                    setState(() {
                      _selectedTime = pickedTime;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  if (_selectedDate == null || _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select date and time.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Create a DateTime object from selected date and time
                  DateTime selectedDateTime = DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );
                  var appointmentId = Uuid().v1();
                  // Create a Map for the appointment data
                  Map<String, dynamic> appointmentData = {
                    'date': Timestamp.fromDate(selectedDateTime),
                    'time': '${_selectedTime!.hour}:${_selectedTime!.minute}',
                    'userId': widget.userId,
                    'guideId': widget.guide!.uid,
                    'guideName': widget.guide!.name,
                    'id': appointmentId,
                    'status': 0,
                  };

                  // Add appointment to Firestore
                  try {
                    await appointmentsCollection.doc(appointmentId).set(appointmentData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Appointment Scheduled!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context); // Go back to previous screen
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to schedule appointment. Please try again.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  'Schedule Appointment',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
