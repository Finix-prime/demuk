import 'package:demuk/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool visible = true;

  void errorMsg() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("Got Error ..."),
          content: const Text("username and password invalid !!!"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkCorectUserPass() {
    if (userNameController.text == 'demuk' && passController.text == '1234') {
      print('go next');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    } else {
      errorMsg();
      userNameController.clear();
      passController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please your username';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text('Ussername'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: visible,
              controller: passController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text('Password'),
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: Icon(Icons.visibility)),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  checkCorectUserPass();
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Login'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passController.dispose();
    super.dispose();
  }
}
