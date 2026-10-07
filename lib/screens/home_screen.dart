import 'package:_matamixtask/provider/user_provider.dart';
import 'package:_matamixtask/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<UserProvider>().fetchUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title:  Text('Users'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon:  Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) =>  LoginScreen())),
          ),
        ],
      ),
      body: switch (p.status) {
        Status.loading =>  Center(child: CircularProgressIndicator()),
        Status.error => Center(
            child: Padding(
              padding:  EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(Icons.error_outline, size: 56, color: Colors.red),
                   SizedBox(height: 12),
                  Text(p.error, textAlign: TextAlign.center),
                   SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: p.fetchUsers,
                    icon:  Icon(Icons.refresh),
                    label:  Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        Status.success => RefreshIndicator(
            onRefresh: p.fetchUsers,
            child: ListView.separated(
              itemCount: p.users.length,
              separatorBuilder: (_, __) =>  Divider(height: 1),
              itemBuilder: (context, i) {
                final u = p.users[i];
                return ListTile(
                  leading: CircleAvatar(child: Text(u.name[0])),
                  title: Text(u.name),
                  subtitle: Text(u.email),
                  trailing:  Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UserDetailsScreen(user: u)),
                  ),
                );
              },
            ),
          ),
      },
    );
  }
}