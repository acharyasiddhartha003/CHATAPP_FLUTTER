// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class LoginScreen extends StatelessWidget {
// //   final _auth = FirebaseAuth.instance;

// //   final _formKey = GlobalKey<FormState>();
// //   String email = '', password = '';

// //   LoginScreen({super.key});

// //   Future<void> login(BuildContext context) async {
// //     if (_formKey.currentState!.validate()) {
// //       try {
// //         await _auth.signInWithEmailAndPassword(email: email, password: password);
// //         Navigator.pushReplacementNamed(context, '/home');
// //       } catch (e) {
// //         print(e);
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(SnackBar(content: Text('Error: $e')));
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Login')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Email'),
// //                 validator: (value) =>
// //                     value!.isEmpty ? 'Enter your email' : null,
// //                 onChanged: (value) => email = value,
// //               ),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Password'),
// //                 obscureText: true,
// //                 validator: (value) =>
// //                     value!.length < 6 ? 'Password too short' : null,
// //                 onChanged: (value) => password = value,
// //               ),
// //               const SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () => login(context),
// //                 child: const Text('Login'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }










// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _auth = FirebaseAuth.instance;

//   Future<void> _login() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Logged in successfully!')),
//       );
//       // Navigate to Home or Dashboard screen if needed
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.chat_bubble_outline, size: 64),
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome back you've been missed!",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   // Implement Forgot Password functionality here
//                 },
//                 child: const Text(
//                   'Forgot Password?',
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, '/sign_up'); // Navigate to Sign-Up
//               },
//               child: const Text(
//                 'Not a member? Register now',
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









import 'package:chatapp_flutter/services/auth/auth_service.dart';
import 'package:chatapp_flutter/components/my_button.dart';
import 'package:chatapp_flutter/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;
  

   LoginPage({super.key, required this.onTap});

   //login method
   void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    //try login 
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
         _pwController.text,
         );
    }

    // catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
      );
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50),

            // welcome back message
            Text(
              "Let's create account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController ,
            ),

            const SizedBox(height: 10),

            // pw textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
              ),

              const SizedBox(height: 25),

            // login button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Not a member? ",
                    style: 
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                      ),
                ),
               
              ],
            )
          ],
        ),
      ),
    );
  }
}