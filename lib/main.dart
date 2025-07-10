import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  late Box<Habit> habitBox;
  List<Habit> get habits => habitBox.values.toList();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitBox = Hive.box<Habit>('habitsBox');
  }

  void _addHabit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    final habit = Habit(name: name, createdAt: DateTime.now());
    habitBox.add(habit);
    _controller.clear();
    setState( () {});
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
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];

        return Dismissible(
          key: Key(habit.key.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            habit.delete();
            setState(() {});
          },
          child: ListTile(
            title: Text(habit.name),
            subtitle: Text('Created: ${habit.createdAt.toLocal().toString().split('.')[0]}'),
            trailing: IconButton(
              icon: Icon(
                habit.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onPressed: () {
                final updatedHabit = habits[index];
                updatedHabit.isCompleted = !updatedHabit.isCompleted;
                updatedHabit.save();
                setState(() {});
              },
            ),
          ),
        );
      },
    ),
  ),