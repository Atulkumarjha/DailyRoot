import 'package:flutter/material.dart';
import 'models/habit.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Root',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Habit> _habits = [];
  final TextEditingController _controller = TextEditingController();

  void _addHabit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _habits.add(Habit(
        name: name, 
        createdAt: DateTime.now().toString(),
      ));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Habit',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addHabit,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  final habit = _habits[index];
                  return ListTile(
                    title: Text(habit.name),
                    subtitle: Text('Created: ${habit.createdAt}'),
                    trailing: IconButton(
                      icon: Icon(
                        habit.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                      onPressed: () {
                        setState(() {
                          habit.isCompleted = !habit.isCompleted;
                        });
                      },
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