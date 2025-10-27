import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

class EditUserPage extends StatefulWidget {
  final User user; // menerima objek User dari halaman sebelumnya
  const EditUserPage({super.key, required this.user});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _jobController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data lama
    _nameController = TextEditingController(
        text: '${widget.user.firstName} ${widget.user.lastName}');
    _jobController = TextEditingController();
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await apiService.updateUser(
          widget.user.id.toString(),
          _nameController.text,
          _jobController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User "${response['name']}" berhasil diperbarui!'),
        ));

        Navigator.pop(context, true); // kembali dengan status sukses
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal update: $e')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                  labelText: 'Pekerjaan Baru',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Pekerjaan tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updateUser,
                      child: const Text('Update User'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
