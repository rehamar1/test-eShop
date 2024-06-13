import 'package:e_shop/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_shop/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                User? user = await _authService.signIn(email, password);

                if (user != null) {
                  // Authentification réussie, rediriger vers l'écran principal
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListScreen()),
                  );
                } else {
                  // Afficher un message d'erreur à l'utilisateur
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur de connexion')),
                  );
                }
              },
              child: Text('Se connecter'),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                User? user = await _authService.signUp(email, password);

                if (user != null) {
                  // Utilisateur inscrit avec succès, rediriger vers l'écran principal
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListScreen()),
                  );
                } else {
                  // Afficher un message d'erreur à l'utilisateur
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de l\'inscription')),
                  );
                }
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
