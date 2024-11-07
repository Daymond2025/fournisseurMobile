import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/constantApp.dart';
import '../../../controllers/phoneController.dart';
import '../../../controllers/rechargeController.dart';

// Contrôleur pour gérer les données du formulaire
class RetraitScreen extends StatefulWidget {
  const RetraitScreen({super.key});

  @override
  State<RetraitScreen> createState() => _RetraitScreenState();
}

class _RetraitScreenState extends State<RetraitScreen> {
  final RechargeController controller = Get.put(RechargeController());
  final PhoneDataController phoneController = Get.put(PhoneDataController());

  //phoneController.fetchPhoneData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.fetchPhoneData();
  }

  @override
  Widget build(BuildContext context) {
    // Instanciation du contrôleur
    double hauteur = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rétrait',
          style: AppConstants.headingTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 50),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  controller.montant.value = value;
                },
                decoration: AppConstants.inputDecoration.copyWith(
                    labelText: 'Entrer un montant',
                    hintText: 'Entrer un montant'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  final montantValue = double.tryParse(value);
                  if (montantValue == null || montantValue <= 0) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null; // Si tout est OK
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) {
                        return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Center(
                                child: Text(
                              "Sélectionnez un numéro",
                              style: AppConstants.headingTextStyle
                                  .copyWith(fontSize: 15),
                            )),
                            content: Obx(
                              () {
                                if (phoneController.isLoading.value) {
                                  return const CircularProgressIndicator(); // Indicateur de chargement
                                } else {
                                  // Afficher la liste des numéros et opérateurs
                                  return SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: phoneController
                                          .phoneData.value.length,
                                      itemBuilder: (context, index) {
                                        var phone = phoneController
                                            .phoneData.value[index];
                                        return ListTile(
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  phone.operator == 'Wave'
                                                      ? Images.wave
                                                      : phone.operator ==
                                                              'Orange'
                                                          ? Images.orange
                                                          : Images.mtn,
                                                ),
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          title: Text(
                                            phone.phoneNumber,
                                            style: AppConstants.bodyTextStyle
                                                .copyWith(fontSize: 10),
                                          ),
                                          subtitle: Text(phone.operator),
                                          onTap: () {
                                            setState(() {
                                              controller.numeroWave.value =
                                                  phone.phoneNumber;
                                              controller.operator.value =
                                                  phone.operator;
                                            });
                                            // Sélectionner le numéro et fermer le dialogue

                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ));
                      });
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 205, 205, 205)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          controller.numeroWave.value == ''
                              ? ' Numero de télephone '
                              : controller.numeroWave.value,
                          style: AppConstants.bodyTextStyle.copyWith(
                              color: const Color.fromARGB(255, 137, 137, 137),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: hauteur * 0.55,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: AppConstants.validateButtonStyle,
                  onPressed: () {
                    controller.retraits();
                  },
                  child: const Text(
                    'Valider',
                    style: AppConstants.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
