import 'dart:convert';

import 'package:daymond_dis/constants/styles.dart';
import 'package:daymond_dis/controllers/supplierController.dart';
import 'package:daymond_dis/screens/newScreens/commentcava/commentcava_widget.dart';
import 'package:daymond_dis/screens/newScreens/flutter_flow_icon_button.dart';
import 'package:daymond_dis/screens/newScreens/flutter_flow_theme.dart';
import 'package:daymond_dis/screens/newScreens/flutter_flow_util.dart';
import 'package:daymond_dis/screens/newScreens/livreurs/livreurs_widget.dart';
import 'package:daymond_dis/screens/newScreens/profil/profil_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_images.dart';
import '../../constants/app_pages.dart';
import '../../constants/constantApp.dart';
import '../../constants/modules.dart';
import '../../controllers/GetUsercontroller.dart';
import '../../controllers/LoginController.dart';
import '../../controllers/commandeController.dart';
import '../../controllers/shopController.dart';
import '../../controllers/walletController.dart';
import '../../models/api_response.dart';
import '../../models/order_table.dart';
import '../../models/usermodel.dart';
import '../../services/userService .dart';
import 'commande/commandeView.dart';
import 'commande/paginationcommande.dart';
import 'comptable/comptableScreen.dart';
import 'detailNeworderScreen.dart';
import 'produits/produitscreen.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  User? user;
  Order? order;
  bool loading = true;
  final GetUserController authController = Get.find<GetUserController>();
  //final ShopController shopController = Get.put(ShopController());
  String year = DateFormat('y').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());
  final LoginController loginController = Get.put(LoginController());
  final WalletController walletController = Get.put(WalletController());
  final OrderController orderController = Get.put(OrderController());
  final Suppliercontroller supplierController = Get.put(Suppliercontroller());

  RxBool modif = false.obs; // Déclaration d'un RxBool
  final TextEditingController _nomPrenomController = TextEditingController();
  final FocusNode _nomPrenomFocusNode = FocusNode();

  final TextEditingController _contactController = TextEditingController();
  final FocusNode _contactFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletController.fetchWalletData();
    //orderController.fetchCommande('confirm');
    print("la wallet value ${walletController.wallet.value}");
    getUser('Home');
  }

  // get user detail
  void getUser(String p) async {
    print('///////////////////////////////////////////////////$p');
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      if (mounted) {
        setState(() {
          user = response.data as User;
          loading = false;
          //txtNameController.text = user!.name ?? '';
        });
        print("User info : ${user?.entity.id}");
      }
    } else if (response.error == AppConstants.unauthorized) {
    } else {}
  }

  void toggle() {
    modif.value = !modif.value; // Utiliser .value pour modifier la valeur
  }

  modifierInfos() async {
    bool success = await supplierController.updateFournisseur(
      id: user!.entity.id,
      firstName: _nomPrenomController.text.split(" ").first,
      lastName: _nomPrenomController.text.split(" ").sublist(1).join(" "),
      email: _emailController.text,
      phoneNumber: _contactController.text,
    );

    // Affichage d'un message en fonction de la réussite ou de l'échec de la soumission
    if (success) {
      Get.off(() => HomeSreen());
      EasyLoading.showSuccess('Infos modifiées avec succès!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Infos modifiées soumis avec succès!'),
        ),
      );
    } else {
      EasyLoading.showError('Erreur lors de la modification des infos');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la modification des infos'),
        ),
      );
    }
  }

  showBoutique() async {
    // showModalBottomSheet(
    //     context: context,
    //     backgroundColor: Colors.white,
    //     isScrollControlled: true, // Permet au modal d'occuper plus d'espace

    //     builder: (BuildContext context) {});
  }

  showGerant() async {
    setState(() {
      _nomPrenomController.text =
          '${user!.entity.firstName} ${user!.entity.lastName}';
      _contactController.text = user!.phoneNumber ?? '';
      _emailController.text = user!.email ?? '';
    });
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true, // Permet au modal d'occuper plus d'espace

        builder: (BuildContext context) {
          return
              // Generated code for this userInfos Widget...
              //   Align(
              // alignment: AlignmentDirectional(0, 1),
              // child: Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              //   child:

              Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8, // 90% de l'écran
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7FA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF0055FF),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowIconButton(
                                  borderRadius: 8,
                                  buttonSize: 40,
                                  fillColor: Color(0xFF0055FF),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                                Obx(() => !modif.value
                                    ? InkWell(
                                        onTap: () {
                                          modifierInfos();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Enregistrer",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : Text('')),
                              ],
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                user!.picture ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              '${user!.entity.firstName} ${user!.entity.lastName}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nom et prénoms',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(
                                    () => !modif.value
                                        ? Text(
                                            '${user!.entity.firstName} ${user!.entity.lastName}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          )
                                        : Container(
                                            width: 200,
                                            child: TextFormField(
                                              controller: _nomPrenomController,
                                              focusNode: _nomPrenomFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText:
                                                    'Quel est le nom de cet article ?',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFC4C4C4),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFFF9500),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              // validator: _model
                                              //     .textController1Validator
                                              //     .asValidator(context),
                                            ),
                                          ),
                                  )
                                ].divide(SizedBox(height: 10)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 100,
                                buttonSize: 40,
                                fillColor: Color(0xFFECECEC),
                                icon: FaIcon(
                                  FontAwesomeIcons.pen,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 15,
                                ),
                                onPressed: () async {
                                  toggle();

                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(() => !modif.value
                                      ? Text(
                                          user?.phoneNumber ?? '',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      : Container(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _contactController,
                                            focusNode: _contactFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  'Quel est le nom de cet article ?',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFC4C4C4),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFF9500),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            // validator: _model
                                            //     .textController1Validator
                                            //     .asValidator(context),
                                          ),
                                        )),
                                ].divide(SizedBox(height: 10)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 100,
                                buttonSize: 40,
                                fillColor: Color(0xFFECECEC),
                                icon: FaIcon(
                                  FontAwesomeIcons.pen,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 15,
                                ),
                                onPressed: () {
                                  toggle();
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Adresse e-mail',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(() => !modif.value
                                      ? Text(
                                          user!.email ?? '',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      : Container(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _emailController,
                                            focusNode: _emailFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  'Quel est le nom de cet article ?',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFC4C4C4),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFF9500),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            // validator: _model
                                            //     .textController1Validator
                                            //     .asValidator(context),
                                          ),
                                        )),
                                ].divide(SizedBox(height: 10)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 100,
                                buttonSize: 40,
                                fillColor: Color(0xFFECECEC),
                                icon: FaIcon(
                                  FontAwesomeIcons.pen,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 15,
                                ),
                                onPressed: () {
                                  toggle();
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () async {
                      loginController.logout();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.logout,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        Text(
                          'Déconnexion',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          //   ),
          // );
        });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppConstants.backgroundColor,
      onRefresh: () async {
        walletController.fetchWalletData();
        orderController.fetchCommande(orderController.currentPage.value);
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 239, 239),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.2), // Couleur de l'ombre légèrement sombre
                      spreadRadius: 1, // Diffusion légère
                      blurRadius: 5, // Flou doux pour un effet plus subtil
                      offset: const Offset(
                          0, 3), // Ombre en bas (aucun décalage horizontal)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: Container(
                                              height: 5,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Paramètre',
                                              style: AppConstants
                                                  .headingTextStyle
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     showDialog(
                                        //       context: context,
                                        //       builder: (BuildContext context) {
                                        //         return AlertDialog(
                                        //           backgroundColor: Colors.white,
                                        //           title: Center(
                                        //             child: Text(
                                        //               "",
                                        //               style: AppConstants
                                        //                   .headingTextStyle
                                        //                   .copyWith(
                                        //                       fontSize: 15),
                                        //             ),
                                        //           ),
                                        //           content: Text(
                                        //             'Informations disponible sur la version web',
                                        //             style: AppConstants
                                        //                 .bodyTextStyle
                                        //                 .copyWith(fontSize: 15),
                                        //           ),
                                        //           actions: [
                                        //             ElevatedButton(
                                        //               style: AppConstants
                                        //                   .validateButtonStyle,
                                        //               onPressed: () {
                                        //                 Navigator.of(context)
                                        //                     .pop();
                                        //               },
                                        //               child: const Text(
                                        //                 "Quitter",
                                        //                 style: AppConstants
                                        //                     .buttonTextStyle,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         );
                                        //       },
                                        //     );
                                        //   },
                                        //   child: Card(
                                        //     color: Colors.white,
                                        //     child: Column(
                                        //       children: [
                                        //         Padding(
                                        //           padding:
                                        //               const EdgeInsets.all(8.0),
                                        //           child: Row(
                                        //             children: [
                                        //               CircleAvatar(
                                        //                 radius: 25,
                                        //                 backgroundColor:
                                        //                     const Color
                                        //                         .fromARGB(255,
                                        //                         243, 237, 254),
                                        //                 child: Image.network(
                                        //                   '${walletController.wallet.value!.entity!.logo}',
                                        //                   height: 200,
                                        //                   width: 100,
                                        //                   fit: BoxFit.cover,
                                        //                 ),
                                        //               ),
                                        //               const SizedBox(
                                        //                 width: 20,
                                        //               ),
                                        //               Column(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .start,
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .start,
                                        //                 children: [
                                        //                   Text(
                                        //                     '${walletController.wallet.value!.entity!.name}',
                                        //                     style: AppConstants
                                        //                         .headingTextStyle
                                        //                         .copyWith(
                                        //                             fontSize:
                                        //                                 14),
                                        //                   ),
                                        //                   Text(
                                        //                     '${walletController.wallet.value!.entity!.phoneNumber}',
                                        //                     style: AppConstants
                                        //                         .bodyTextStyle
                                        //                         .copyWith(
                                        //                             fontSize:
                                        //                                 11),
                                        //                   ),
                                        //                 ],
                                        //               )
                                        //             ],
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () async {
                                            Get.to(() => ProfilWidget(
                                                  user: user!,
                                                  businessInfo: walletController
                                                      .wallet.value!,
                                                ));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0,
                                                    2,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Info fournisseur',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            Color(0xFF707070),
                                                        size: 30,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        height: 65,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          '${walletController.wallet.value!.entity!.logo}',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${walletController.wallet.value!.entity!.name}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF0084FE),
                                                                  fontSize: 20,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Text(
                                                            '#${user?.entity.shop.code}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // Generated code for this Container Widget...
                                        InkWell(
                                          onTap: () async {
                                            showGerant();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0,
                                                    2,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Info gérant',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            Color(0xFF707070),
                                                        size: 30,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        height: 65,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          user?.picture ?? '',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${user?.entity.firstName} ${user?.entity.lastName}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF0084FE),
                                                                  fontSize: 20,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Text(
                                                            user?.phoneNumber ??
                                                                '',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.to(() => CommentcavaWidget());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x33000000),
                                                  offset: Offset(
                                                    0,
                                                    2,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Comment ça va ?',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFF707070),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            Color(0xFF707070),
                                                        size: 30,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.bottomLeft,
                                        //   child: SizedBox(
                                        //     height: 40,
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width *
                                        //         0.4,
                                        //     child: ElevatedButton(
                                        //         style: AppConstants
                                        //             .cancelButtonStyle,
                                        //         onPressed: () {
                                        //           loginController.logout();
                                        //         },
                                        //         child: Text(
                                        //           'Se deconnecter',
                                        //           style: AppConstants
                                        //               .buttonTextStyle
                                        //               .copyWith(fontSize: 10),
                                        //         )),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    walletController
                                            .wallet.value?.entity?.logo ??
                                        '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  walletController.wallet.value?.entity?.name ??
                                      '',
                                  style: AppConstants.headingTextStyle
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Text('')
                        ],
                      ),
                    ),
                    if (walletController.roles.value == 'supplier')
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.1), // Couleur de l'ombre légèrement sombre
                              spreadRadius: 1, // Diffusion légère
                              blurRadius:
                                  2, // Flou doux pour un effet plus subtil
                              offset: const Offset(0,
                                  3), // Ombre en bas (aucun décalage horizontal)
                            ),
                          ],
                        ),
                        child: Obx(() {
                          if (walletController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          var wallet = walletController.wallet.value;
                          var dash = walletController.dash.value;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.wallets,
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Comptable',
                                                style: AppConstants
                                                    .headingTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w800),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Row(
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: formatwallet
                                                                .format(
                                                                    dash?.chiffreAffaire ??
                                                                        0),
                                                            style: AppConstants
                                                                .headingTextStyle
                                                                .copyWith(
                                                                    color: hexToColor(
                                                                        '#0791FF'),
                                                                    fontSize:
                                                                        25)),
                                                        TextSpan(
                                                          text: AppConstants
                                                              .currency,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: hexToColor(
                                                                  '#0791FF')),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Text(
                                            'Chiffre d’affaires',
                                            style: AppConstants.bodyTextStyle,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25),
                                            child: Text(
                                              '${month.capitalizeFirst} $year',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () =>
                                                Get.to(ComptatScreen()),
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.grey,
                                              size: AppConstants.iconSizeMedium,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                Get.to(ComptatScreen()),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 70,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: hexToColor('#F7F8FE'),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: RichText(
                                                          textAlign:
                                                              TextAlign.start,
                                                          text: TextSpan(
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: formatwallet
                                                                    .format(
                                                                        dash?.aSolder ??
                                                                            0),
                                                                style: AppConstants
                                                                    .headingTextStyle
                                                                    .copyWith(
                                                                        color: hexToColor(
                                                                            '#F87957'),
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                              TextSpan(
                                                                text: AppConstants
                                                                    .currency,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: hexToColor(
                                                                        '#F87957')),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        'A solder',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        'Aujourd’hui',
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                      ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const LivreursWidget());
                            },
                            child: Container(
                                // height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xFF0BC724)),
                                    color: hexToColor('#F7F8FE')),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Color(0xFF0BC724),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            Images.livreur,
                                            height: 28,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                        'Livreurs',
                                        style: AppConstants.bodyTextStyle,
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => OrderView());
                            },
                            child: Container(
                                // height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.orange),
                                    color: const Color.fromARGB(
                                        255, 254, 250, 254)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.orange),
                                            color: Colors.orange),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            Images.commande,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Obx(() {
                                        // Calcul du nombre de commandes publiées aujourd'hui
                                        var confirmOrders = orderController
                                            .orderList
                                            .where((order) =>
                                                order.status == 'confirm')
                                            .length;
                                        var pendingOrders = orderController
                                            .orderList
                                            .where((order) =>
                                                order.status == 'pending')
                                            .length;
                                        var inProgressOrders = orderController
                                            .orderList
                                            .where((order) =>
                                                order.status == 'in_progress')
                                            .length;

                                        var totalOrders = confirmOrders +
                                            pendingOrders +
                                            inProgressOrders;

                                        return Row(
                                          children: [
                                            const Text(
                                              'Commandes',
                                              style: AppConstants.bodyTextStyle,
                                            ),
                                            const SizedBox(width: 5),
                                            CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.red,
                                              child: Text(
                                                '$totalOrders', // Nombre de commandes publiées aujourd'hui
                                                style: AppConstants
                                                    .bodyTextStyle
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 9),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const ProduitScreen());
                            },
                            child: Container(
                                // height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.blue),
                                    color: hexToColor('#F7F8FE')),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border:
                                                Border.all(color: Colors.blue),
                                            color: Colors.blue),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            Images.produits,
                                            height: 28,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                        'Produits',
                                        style: AppConstants.bodyTextStyle,
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Align(
                  alignment:
                      Alignment.centerLeft, // Aligne le texte en haut à gauche
                  child: Text(
                    orderController.orderList
                            .where((order) => order.status == 'confirm')
                            .toList()
                            .isNotEmpty
                        ? 'Nouvelle commande'
                        : '',
                    style: AppConstants.bodyTextStyle.copyWith(fontSize: 15),
                  ),
                ),
              ),
              Obx(() {
                if (orderController.iswaiting.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                var orders = orderController.orderList
                    .where((order) => order.status == 'confirm')
                    .toList();
                if (orders.isEmpty) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                      child: emptyMessage(
                          'Pas de nouvelle commande pour \nle moment, restez connecté. ',
                          imagese: 'valide'));
                }
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final items = order.items;

                      if (items == null || items.isEmpty) {
                        return Text('Pas d\'articles disponibles');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, itemIndex) {
                          final item = items[itemIndex];
                          return produitCard(
                            item.product.name ?? '',
                            '${item.product.orderstock}',
                            '${item.product.totalstock}',
                            '${order.delivery!.city!.name}', // Description du prix
                            item.product.images?.isNotEmpty == true
                                ? item.product.images!.first
                                : 'https://www.lascom.com/wp-content/uploads/2021/03/Bland_Cosmetic_Product_Packaging_Unit_500x400.jpg',
                            '${formatCustomDate(order.confirmed!.date)}, ${order.confirmed!.time!.substring(0, 5)}',
                            '${item.product.price?.price ?? 0} ',
                            'Nouvelle commande',
                            'Voir les détails',
                            () {
                              Get.to(CommandHome(
                                command: order,
                                items: item,
                                titre: 'Nouvelle Commande',
                              ));
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              }),
              if (orderController.orderList.length > 20)
                PaginationorderWidget(
                  currentPage: orderController.currentPage.value,
                  lastPage: orderController.lastPage.value,
                  onPageChanged: (page) {
                    orderController.goToPage(page);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
