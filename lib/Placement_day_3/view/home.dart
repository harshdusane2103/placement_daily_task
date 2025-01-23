import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:placement_daily_task/Placement_day_3/Api/api.dart';
import 'package:placement_daily_task/Placement_day_3/helper/helper.dart';
import 'package:placement_daily_task/Placement_day_3/model/model.dart';
import 'package:placement_daily_task/placement_day_2/model/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseHelper dbHelper;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    apiService = ApiService();
  }

  Future<void> _refreshUsers() async {
    if (await _checkInternetConnection()) {
      final users = await apiService.fetchUsers();
      await dbHelper.deleteAllUsers();
      for (var user in users) {
        await dbHelper.insertUser(user);
      }
      setState(() {});
    }
  }

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: FutureBuilder<List<Usermodel>>(
        future: dbHelper.fetchAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          if (users.isEmpty) {
            return Center(child: Text('No users found.'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        _showEditContactDialog(context, user);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await dbHelper.deleteUser(user.id);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _showEditContactDialog(BuildContext context, Usermodel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final updatedUser = Usermodel(
                  id: user.id,
                  name: nameController.text,
                  email: emailController.text,
                  avatar: user.avatar,
                  role: user.role,
                  password: user.password,
                  creationAt: user.creationAt,
                  updatedAt: user.updatedAt
                );
                await dbHelper.updateUser(updatedUser);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
