import 'package:_matamixtask/model/user_model.dart';
import 'package:flutter/material.dart';


class UserDetailsScreen extends StatelessWidget {
  final User user;
  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Widget row(IconData icon, String label, String value) => ListTile(
          leading: Icon(icon),
          title: Text(label, style: Theme.of(context).textTheme.labelMedium),
          subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
        );

    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        children: [
           SizedBox(height: 24),
          Center(
            child: CircleAvatar(
              radius: 40,
              child: Text(user.name[0], style:  TextStyle(fontSize: 32)),
            ),
          ),
           SizedBox(height: 8),
          Center(
            child: Text('@${user.username}',
                style: Theme.of(context).textTheme.titleMedium),
          ),
           SizedBox(height: 16),
          row(Icons.email_outlined, 'Email', user.email),
          row(Icons.phone_outlined, 'Phone', user.phone),
          row(Icons.language, 'Website', user.website),
          row(Icons.business_outlined, 'Company', user.company),
          row(Icons.location_on_outlined, 'Address', user.address),
        ],
      ),
    );
  }
}