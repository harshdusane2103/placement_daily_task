
import 'package:flutter/material.dart';
import 'package:placement_daily_task/placement_day_1/Api/api.dart';
import 'package:placement_daily_task/placement_day_1/Components/todoitem.dart';
import 'package:placement_daily_task/placement_day_1/Model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Todo>> todos;
  bool Show = true;
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    todos = ApiService().fetchTodos();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Show = prefs.getBool('viewType') ?? true; // Default to true
      isDarkTheme = prefs.getBool('theme') ?? false;
    });
  }

  Future<void> _toggleViewType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Show = !Show;
      prefs.setBool('viewType', Show);
    });
  }

  Future<void> _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = !isDarkTheme;
      prefs.setBool('theme', isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todos App'),
          actions: [
            IconButton(
              icon: Icon(Show
                  ? Icons.grid_view_rounded
                  : Icons.format_list_bulleted_outlined),
              onPressed: _toggleViewType,
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: FutureBuilder<List<Todo>>(
          future: todos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final todos = snapshot.data!;
              return Show
                  ? GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(todo: todos[index]);
                },
              )
                  : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return TodoItem(todo: todos[index]);
                },
              );
            } else {
              return const Center(child: Text('No todos found'));
            }
          },
        ),
      ),
    );
  }
}
