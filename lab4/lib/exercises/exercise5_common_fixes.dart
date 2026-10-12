import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatelessWidget {
  const CommonUiFixesDemo({super.key});

  static const List<String> _movies = [
    'Movie A',
    'Movie B',
    'Movie C',
    'Movie D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    leading: const Icon(
                      Icons.movie_creation_outlined,
                      size: 28,
                      color: Colors.black87,
                    ),
                    title: Text(
                      _movies[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task2OverflowFixDemo extends StatelessWidget {
  const Task2OverflowFixDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2 – Overflow Fix'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            15,
            (index) => ListTile(
              title: Text('Item $index'),
            ),
          ),
        ),
      ),
    );
  }
}

class Task3StateUpdateFixDemo extends StatefulWidget {
  const Task3StateUpdateFixDemo({super.key});

  @override
  State<Task3StateUpdateFixDemo> createState() => _Task3StateUpdateFixDemoState();
}

class _Task3StateUpdateFixDemoState extends State<Task3StateUpdateFixDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3 – setState Fix'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $_counter'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment with setState'),
            ),
          ],
        ),
      ),
    );
  }
}

class Task4DatePickerContextFixDemo extends StatefulWidget {
  const Task4DatePickerContextFixDemo({super.key});

  @override
  State<Task4DatePickerContextFixDemo> createState() =>
      _Task4DatePickerContextFixDemoState();
}

class _Task4DatePickerContextFixDemoState
    extends State<Task4DatePickerContextFixDemo> {
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4 – BuildContext Fix'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : 'Selected: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Open DatePicker'),
            ),
          ],
        ),
      ),
    );
  }
}
