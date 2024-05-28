import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  final activities = ['Wake up', 'Go to gym', 'Breakfast', 'Meetings', 'Lunch', 'Quick nap', 'Go to library', 'Dinner', 'Go to sleep'];
  String selectedDay = 'Sunday';
  TimeOfDay? selectedTime;
  String selectedActivity = 'Wake up';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daily Reminder'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dropdown for Day
              DropdownButtonFormField<String>(
                value: selectedDay,
                hint: Text('Select Day'),
                items: daysOfWeek.map((day) => DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                )).toList(),
                onChanged: (value) => setState(() => selectedDay = value!),
              ),

              // Time picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time:'),
                  TextButton(
                    onPressed: () async {
                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {});
                    },
                    child: Text(selectedTime?.format(context) ?? 'Select Time'),
                  ),
                ],
              ),

              // Dropdown for Activity
              DropdownButtonFormField<String>(
                value: selectedActivity,
                hint: Text('Select Activity'),
                items: activities.map((activity) => DropdownMenuItem<String>(
                  value: activity,
                  child: Text(activity),
                )).toList(),
                onChanged: (value) => setState(() => selectedActivity = value!),
              ),

              // Button to show reminder details
              ElevatedButton(
                onPressed: () {
                  if (selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a time'),
                      ),
                    );
                    return;
                  }
                  // Display reminder details in a dialog or snackbar (implementation not included)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reminder Details'),
                        content: Text('Day: $selectedDay\nTime: ${selectedTime?.format(context)}\nActivity: $selectedActivity'),
                        actions: [
                          TextButton(
  onPressed: () async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {});
  },
  child: FutureBuilder<TimeOfDay?>(
    future: showTimePicker(context: context, initialTime: TimeOfDay.now()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        return Text(snapshot.data!.format(context));
      } else {
        return Text('Select Time');
      }
    },
  ),
),
                        ],
                      );
                    },
                  );
                },
                child: Text('Show Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
