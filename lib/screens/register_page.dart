import 'package:flutter/material.dart';
import 'package:uts_project_syifa/databases/user_database.dart';
import 'package:uts_project_syifa/models/user_model.dart';
import 'package:uts_project_syifa/models/validation_email.dart';

class RegisterPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController(); 

  void register(BuildContext context) {
    String namaLengkap = namaLengkapController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Cek apakah email sudah ada
    for (var data in databases) {
      if (data.email == email) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email sudah terdaftar!'))
        );
        return;
      }
    }

    // Jika email belum ada, lanjutkan registrasi
    databases.add(UserModel(namalengkap: namaLengkap, email: email, password: password));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register Berhasil')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: namaLengkapController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Harus Di-isi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!isEmailValid(value)) {
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus di-isi';
                  } else if (value.length < 8) {
                    return 'Password harus 8 karakter';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password harus di-isi';
                  } else if (value != passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    register(context); 
                    Navigator.pushReplacementNamed(context, '/'); 
                  }
                },
                child: Text('Daftar'),
              ),
              
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Sudah punya akun? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
