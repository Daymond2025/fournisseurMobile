import 'package:daymond_dis/screens/newScreens/inscription/inscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_pages.dart';
import '../../constants/constantApp.dart';
import '../../controllers/GetUsercontroller.dart';
import '../../controllers/LoginController.dart';
import '../../models/usermodel.dart';

class LoginSreen extends StatefulWidget {
  const LoginSreen({super.key});

  @override
  State<LoginSreen> createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {
  bool isLoading = false;
  final GetUserController authController = Get.put(GetUserController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _acceptPolicy = false;
  final LoginController loginController = Get.put(LoginController());

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(158, 158, 158, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 20, right: 20),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 50,
                        width: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      ' CONNECTEZ-VOUS\n A VOTRE COMPTE',
                      style: AppConstants.headingTextStyle
                          .copyWith(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InscriptionWidget(),
                      ),
                    );
                  },
                  child: Text("Inscription"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Email Input Field
                      TextFormField(
                        controller: _emailController,
                        decoration: AppConstants.inputDecoration.copyWith(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(
                              Icons.mail,
                              size: AppConstants.iconSizeMedium,
                            )),
                        style: AppConstants.inputTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.fieldRequiredError;
                          }
                          if (!RegExp(AppConstants.emailRegex)
                              .hasMatch(value)) {
                            return AppConstants.invalidEmailError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Password Input Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: AppConstants.inputDecoration.copyWith(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            size: AppConstants.iconSizeMedium,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.black,
                            onPressed: _toggle,
                            icon: _obscureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        style: AppConstants.inputTextStyle,
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.fieldRequiredError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptPolicy,
                            onChanged: (value) {
                              setState(() {
                                _acceptPolicy = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                const url =
                                    'https://supplier.daymondboutique.com/conditions-generales';

                                if (await canLaunch(url)) {
                                  await launch(url);

                                  EasyLoading.dismiss();
                                  // showGetSnackBar(messageText: "Un enregistrement ajouté avec succès!");
                                  return;
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: 'J\'accepte la ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Politique générale',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 33, 58, 243),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: "d'utilisation",
                                        style: AppConstants.bodyTextStyle),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() => ElevatedButton(
                              onPressed: loginController.isLoading.value
                                  ? null // Désactiver le bouton pendant le chargement
                                  : () {
                                      if (_formKey.currentState!.validate() &&
                                          _acceptPolicy == true) {
                                        loginController.loginUser(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                      } else {
                                        Get.snackbar("Erreur",
                                            AppConstants.fieldRequiredError);
                                      }
                                    },
                              style: AppConstants.validateButtonStyle,
                              child: loginController.isLoading.value
                                  ? const SpinKitCircle(
                                      color: Colors.white,
                                      size: 24.0,
                                    )
                                  : const Text(
                                      'Valider',
                                      style: AppConstants.buttonTextStyle,
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
