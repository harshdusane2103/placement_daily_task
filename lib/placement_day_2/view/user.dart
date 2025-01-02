import 'package:flutter/material.dart';
import 'package:placement_daily_task/placement_day_2/model/model.dart';


class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${user.firstName} ${user.lastName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Center(
                child: CircleAvatar(
                radius: 50,
                backgroundImage: user.image.isNotEmpty
                    ? NetworkImage(user.image)
                    : const AssetImage('assets/placeholder.png'),
                          ),
              ),
                const SizedBox(height: 20),
                Text(
                  'ID: ${user.id}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Name: ${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Age: ${user.age}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Gender: ${user.gender}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Phone: ${user.phone}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

