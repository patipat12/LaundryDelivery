import 'package:flutter/material.dart';




class NotificationsScreen extends StatelessWidget {
  final List<NotificationItem> notifications = List.generate(
    10,
    (index) => NotificationItem(
      title: 'George Antonio',
      message: 'Please make the presentation before Friday, the next meeting agenda will...',
      time: '2h Ago',
      imageUrl: 'https://via.placeholder.com/150', // Replace with the actual image URL
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search notifications',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(notification: notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final String imageUrl;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.imageUrl,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(notification.imageUrl),
      ),
      title: Text(notification.title),
      subtitle: Text(notification.message),
      trailing: Text(notification.time),
    );
  }
}