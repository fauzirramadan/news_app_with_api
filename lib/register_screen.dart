import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_day3/api.dart';
import 'package:flutter_day3/res_register.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  Future<ResRegister?> registerUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse(baseUrl + "/register.php"), body: {
        'username': username.text,
        'fullname': fullname.text,
        'email': email.text,
        'password': password.text
      });
      ResRegister data = resRegisterFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message ?? "")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message ?? "")));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
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
                SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 55,
                  child: Icon(
                    Icons.person,
                    size: 55,
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty
                        ? "Fullname tidak boleh kosong"
                        : null;
                  },
                  controller: fullname,
                  decoration: InputDecoration(
                      labelText: "Fullname",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.person_add_alt),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    return value!.isEmpty ? "Email tidak boleh kosong" : null;
                  },
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
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
                SizedBox(
                  height: 15,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MaterialButton(
                        onPressed: () async {
                          if (keyForm.currentState!.validate())
                            await registerUser();
                        },
                        shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        minWidth: 150,
                        height: 45,
                        color: Colors.white,
                        textColor: Colors.blue,
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  }),
                  child: const Text(
                    "anda sudah punya akun? silahkan login",
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
