import 'package:flutter/material.dart';
import 'package:testdb/models/user.dart';
import 'package:testdb/utility/api_service.dart';

class Body_profile extends StatefulWidget {
  @override
  _Body_profileState createState() => _Body_profileState();
}

class _Body_profileState extends State<Body_profile> {
  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = ApiService.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: FutureBuilder<User?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user found'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    controller: TextEditingController(text: user.name),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Surname',
                    ),
                    controller: TextEditingController(text: user.surname),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                    controller: TextEditingController(text: user.phone),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: TextEditingController(text: user.email),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: TextEditingController(text: user.password),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    controller: TextEditingController(text: user.address),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to update profile
                    },
                    child: Text('Edit Profile'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add functionality to delete profile
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
