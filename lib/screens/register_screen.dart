// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';

// class RegisterScreen extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   void _register(BuildContext context) async {
//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();

//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }

//     final success = await _authService.register(username, password);
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registration successful. Please log in.')),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registration failed. Try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Register')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _register(context),
//               child: Text('Register'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//               child: Text('Already have an account? Sign in'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// Upated UI



// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';

// class RegisterScreen extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   void _register(BuildContext context) async {
//     final username = usernameController.text.trim();
//     final password = passwordController.text.trim();

//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }

//     final success = await _authService.register(username, password);
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registration successful. Please log in.')),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registration failed. Try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//         backgroundColor: Color(0xFF6200EA), // Deep Purple
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 labelStyle: TextStyle(color: Color(0xFF6200EA)),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF6200EA)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF6200EA)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Color(0xFF6200EA)),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF6200EA)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF6200EA)),
//                 ),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () => _register(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF6200EA), // Deep Purple
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//               ),
//               child: Text('Register'),
//             ),
//             SizedBox(height: 20),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//               child: Text(
//                 'Already have an account? Sign in',
//                 style: TextStyle(color: Color(0xFF6200EA)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  RegisterScreen({super.key});

  void _register(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final isEmailRegistered = await _authService.isEmailRegistered(email);
    if (isEmailRegistered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This email is already registered. Please log in.')),
      );
      return;
    }

    final success = await _authService.register(email, password);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful. Please log in.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register' , style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(197, 98, 0, 234), // Deep           
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                labelStyle: TextStyle(color: Color(0xFF6200EA)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EA)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EA)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0xFF6200EA)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EA)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EA)),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6200EA), // Deep Purple
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: Text('Register'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Already have an account? Sign in',
                style: TextStyle(color: Color(0xFF6200EA)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
