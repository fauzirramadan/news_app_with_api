import 'package:flutter/material.dart';
import 'package:flutter_day3/api.dart';
import 'package:flutter_day3/main.dart';
import 'package:flutter_day3/register_screen.dart';
import 'package:flutter_day3/res_login.dart';
import 'package:flutter_day3/session_manager.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  SessionManager session = SessionManager();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  Future<ResLogin?> loginUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(Uri.parse("$baseUrl/login.php"),
          body: {'username': username.text, 'password': password.text});
      ResLogin data = resLoginFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          session.saveSession(
              data.value, data.username, data.id, data.fullname);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MenuTab()),
              (route) => false);
        });
      } else if (data.value == 0) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.message ?? "")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  radius: 55,
                  child: Icon(
                    Icons.login_sharp,
                    size: 55,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("Login dulu yuk",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty
                        ? "Username tidak boleh kosong"
                        : null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                      labelText: "Username",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty
                        ? "Password tidak boleh kosong"
                        : null;
                  },
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.security),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MaterialButton(
                        onPressed: () async {
                          if (keyForm.currentState!.validate())
                            await loginUser();
                        },
                        shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        minWidth: 140,
                        height: 45,
                        color: Colors.white,
                        textColor: Colors.blue,
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()));
                  }),
                  child: const Text(
                    "anda belum punya akun? silahkan register",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
