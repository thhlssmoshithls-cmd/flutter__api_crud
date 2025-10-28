import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';
import 'add_user_page.dart';
import 'edit_user_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API CRUD Praktikum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      home: const UserListPage(),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final ApiService apiService = ApiService();
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = apiService.fetchUsers();
  }

  Future<void> _refreshUserList() async {
    setState(() {
      futureUsers = apiService.fetchUsers();
    });
  }

  // 🗑️ Menampilkan dialog konfirmasi sebelum menghapus
  void _showDeleteDialog(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus ${user.firstName}?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.pop(context); // tutup dialog
                try {
                  await apiService.deleteUser(user.id.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User ${user.firstName} dihapus (simulasi).')),
                  );
                  _refreshUserList();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus user: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 🧱 Bangun tampilan daftar user
  Widget buildUserListView(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 28,
            ),
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.email),
            // 🔧 Tambah dua tombol Edit dan Delete di sebelah kanan
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  tooltip: 'Edit User',
                  onPressed: () async {
                    final bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(user: user),
                      ),
                    );
                    if (result == true) _refreshUserList();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  tooltip: 'Hapus User',
                  onPressed: () => _showDeleteDialog(user),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna (CRUD Lengkap)'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshUserList),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat data: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada pengguna.'));
          } else {
            return buildUserListView(snapshot.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddUserPage()),
          );
          if (result == true) _refreshUserList();
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah User Baru',
      ),
    );
  }
}
