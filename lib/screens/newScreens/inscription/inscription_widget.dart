import 'dart:io';

import 'package:daymond_dis/controllers/parametreController.dart';
import 'package:daymond_dis/controllers/supplierController.dart';
import 'package:daymond_dis/models/categorieModel.dart';
import 'package:daymond_dis/models/villeModel.dart';
import 'package:daymond_dis/screens/auth/loginScreen.dart';
import 'package:daymond_dis/screens/newScreens/connexion/connexion_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../flutter_flow_drop_down.dart';
import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import '../form_field_controller.dart';
import 'dart:ui';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'inscription_model.dart';
export 'inscription_model.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class InscriptionWidget extends StatefulWidget {
  const InscriptionWidget({super.key});

  @override
  State<InscriptionWidget> createState() => _InscriptionWidgetState();
}

class _InscriptionWidgetState extends State<InscriptionWidget> {
  late InscriptionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? logo;
  File? facade;
  File? interieur;
  String _code = "";

  final ConditionController etatcontroller = Get.put(ConditionController());
  final Suppliercontroller suppliercontroller = Get.put(Suppliercontroller());
  final List<CatParams> lisCat = [];
  final List<VilleParams> lisVil = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InscriptionModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode7 ??= FocusNode();

    _model.textController8 ??= TextEditingController();
    _model.textFieldFocusNode8 ??= FocusNode();

    getCat();
    getVilles();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future getCode() async {
    EasyLoading.show(status: "Un instant...");
    suppliercontroller
        .envoiCodeForRegister(_model.textController8.text)
        .then((res) {
      if (res) {
        print("get code lancé");
        setState(() {
          _model.step = "quatrieme";
        });
        EasyLoading.dismiss();
      } else {
        print("erreur");
        EasyLoading.dismiss();
      }
    });
  }

  Future inscrire() async {
    EasyLoading.show(status: "Un instant...");
    List<CatParams> filteredCategories = lisCat
        .where((category) => _model.dropDownValue!.contains(category.name))
        .toList();
    print(filteredCategories.map((cat) => cat.toJson()).toList());

    suppliercontroller
        .inscription(
      cityId: int.parse(_model.dropDownValue2 as String),
      // businessId: 123, // Optionnel
      name: _model.textController1.text,
      code: _code,
      address: _model.textController3.text,
      email: _model.textController8.text,
      phoneNumberShop: "+225" + _model.textController4.text,
      phoneNumber: "+225" + _model.textController7.text,
      firstName: _model.textController5.text,
      lastName: _model.textController6.text, // Optionnel
      shopPictures: [facade, interieur], // Optionnel
      categoriesProduct: filteredCategories, // Optionnel
      picturePath: logo, // Optionnel
    )
        .then((res) {
      if (res) {
        EasyLoading.dismiss();
        print("get register lancé");
        Get.snackbar("Succès", "Inscription réussie");
        Get.to(() => const ConnexionWidget());
      } else {
        EasyLoading.dismiss();
        print("erreur");
      }
    });
  }

  Future getCat() async {
    etatcontroller.fetchCat().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          // Populate items list with category names
          lisCat.addAll(etatcontroller.catList.value);
          print(lisCat.map((cat) => cat.toJson()).toList());
        });
      });
    });
  }

  Future getVilles() async {
    etatcontroller.fetchVilles().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          // Populate items list with category names
          lisVil.addAll(etatcontroller.villeList.value);
          print(lisVil.map((ville) => ville.toJson()).toList());
        });
      });
    });
  }

  Future getImage(int type, String quel) async {
    final pickedFile = await ImagePicker().pickImage(
        source: type == 1 ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 50);
    if (pickedFile != null) {
      switch (quel) {
        case "logo":
          setState(() {
            logo = File(pickedFile.path);
          });
          break;
        case "facade":
          setState(() {
            facade = File(pickedFile.path);
          });
          break;
        case "interieur":
          setState(() {
            interieur = File(pickedFile.path);
          });
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
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
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 80,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFFFF9500),
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                  switch (_model.step) {
                                    case "premier":
                                      // setState(() {
                                      //   _model.step = "deuxieme";
                                      // });
                                      break;
                                    case "deuxieme":
                                      setState(() {
                                        _model.step = "premier";
                                      });
                                      break;
                                    case "troisieme":
                                      setState(() {
                                        _model.step = "deuxieme";
                                      });
                                      break;
                                    case "quatrieme":
                                      setState(() {
                                        _model.step = "troisieme";
                                      });
                                      break;
                                    default:
                                  }
                                },
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Divider(
                                        thickness: 3,
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0,
                                height: 0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (_model.step == 'premier') {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: VerticalDivider(
                                                    thickness: 3,
                                                    color: Color(0xFFC4C4C4),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'INFORMATIONS SUR VOTRE BOUTIQUE',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 20,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 7)),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 20, 0),
                                              child: Text(
                                                'Donnez-nous des informations sur votre boutique, y compris votre localisation exacte',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: Container(
                                                width: double.infinity,
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController1,
                                                  focusNode: _model
                                                      .textFieldFocusNode1,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        'Nom de votre boutique',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFC4C4C4),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFFF9500),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        EdgeInsets.all(20),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .textController1Validator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController ??=
                                                  FormFieldController<String>(
                                                      null),
                                              onChangedForMultiSelect: (val) {
                                                print(val);
                                                safeSetState(() =>
                                                    _model.dropDownValue = val);
                                              },
                                              options: lisCat
                                                  .map((cat) => (cat
                                                      .toJson()['name']
                                                      .toString()) as String)
                                                  .toList(),
                                              optionLabels: lisCat
                                                  .map((cat) =>
                                                      cat.toJson()['name']
                                                          as String)
                                                  .toList(),
                                              // onChanged: (val) {
                                              //   print(val);
                                              //   safeSetState(() =>
                                              //       _model.dropDownValue = val);
                                              // },
                                              width: double.infinity,
                                              height: 49,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText:
                                                  '   Catégorie des produits vendus',
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2,
                                              borderColor: Color(0xFFC4C4C4),
                                              borderWidth: 0,
                                              borderRadius: 8,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              hidesUnderline: true,
                                              // isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: true,
                                            ),

                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController2 ??=
                                                  FormFieldController<String>(
                                                      null),
                                              // onChangedForMultiSelect: (val) {
                                              //   print(val);
                                              //   safeSetState(() =>
                                              //       _model.dropDownValue = val);
                                              // },
                                              options: lisVil
                                                  .map((cat) => (cat
                                                      .toJson()['id']
                                                      .toString()) as String)
                                                  .toList(),
                                              optionLabels: lisVil
                                                  .map((cat) =>
                                                      cat.toJson()['name']
                                                          as String)
                                                  .toList(),
                                              onChanged: (val) {
                                                print(val);
                                                safeSetState(() => _model
                                                    .dropDownValue2 = val);
                                              },
                                              width: double.infinity,
                                              height: 49,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: '   Ville',
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2,
                                              borderColor: Color(0xFFC4C4C4),
                                              borderWidth: 0,
                                              borderRadius: 8,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              hidesUnderline: true,
                                              // isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                            // Container(
                                            //   width: double.infinity,
                                            //   child: TextFormField(
                                            //     controller:
                                            //         _model.textController2,
                                            //     focusNode:
                                            //         _model.textFieldFocusNode2,
                                            //     autofocus: false,
                                            //     obscureText: false,
                                            //     decoration: InputDecoration(
                                            //       isDense: true,
                                            //       labelStyle:
                                            //           FlutterFlowTheme.of(
                                            //                   context)
                                            //               .labelMedium
                                            //               .override(
                                            //                 fontFamily: 'Inter',
                                            //                 letterSpacing: 0.0,
                                            //               ),
                                            //       hintText:
                                            //           'La commune a Abidjan',
                                            //       hintStyle:
                                            //           FlutterFlowTheme.of(
                                            //                   context)
                                            //               .labelMedium
                                            //               .override(
                                            //                 fontFamily: 'Inter',
                                            //                 letterSpacing: 0.0,
                                            //               ),
                                            //       enabledBorder:
                                            //           OutlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //           color: Color(0xFFC4C4C4),
                                            //           width: 1,
                                            //         ),
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8),
                                            //       ),
                                            //       focusedBorder:
                                            //           OutlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //           color: Color(0x00000000),
                                            //           width: 1,
                                            //         ),
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8),
                                            //       ),
                                            //       errorBorder:
                                            //           OutlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //           color:
                                            //               FlutterFlowTheme.of(
                                            //                       context)
                                            //                   .error,
                                            //           width: 1,
                                            //         ),
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8),
                                            //       ),
                                            //       focusedErrorBorder:
                                            //           OutlineInputBorder(
                                            //         borderSide: BorderSide(
                                            //           color:
                                            //               FlutterFlowTheme.of(
                                            //                       context)
                                            //                   .error,
                                            //           width: 1,
                                            //         ),
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8),
                                            //       ),
                                            //       filled: true,
                                            //       fillColor:
                                            //           FlutterFlowTheme.of(
                                            //                   context)
                                            //               .secondaryBackground,
                                            //       contentPadding:
                                            //           EdgeInsets.all(20),
                                            //     ),
                                            //     style:
                                            //         FlutterFlowTheme.of(context)
                                            //             .bodyMedium
                                            //             .override(
                                            //               fontFamily: 'Inter',
                                            //               letterSpacing: 0.0,
                                            //             ),
                                            //     cursorColor:
                                            //         FlutterFlowTheme.of(context)
                                            //             .primaryText,
                                            //     validator: _model
                                            //         .textController2Validator
                                            //         .asValidator(context),
                                            //   ),
                                            // ),
                                            Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller:
                                                    _model.textController3,
                                                focusNode:
                                                    _model.textFieldFocusNode3,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText:
                                                      'Le quartier et la localisation exacte',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFF9500),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  contentPadding:
                                                      EdgeInsets.all(20),
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
                                                validator: _model
                                                    .textController3Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Stack(children: [
                                                TextFormField(
                                                  controller:
                                                      _model.textController4,
                                                  focusNode: _model
                                                      .textFieldFocusNode4,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        'Contact de la boutique',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFC4C4C4),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFFF9500),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            60, 20, 20, 20),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .textController4Validator
                                                      .asValidator(context),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 20, 0, 20),
                                                    child: Text(
                                                      "+225 | ",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFFF9500),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                              ]),
                                            ),
                                            Container(height: 40)
                                          ].divide(SizedBox(height: 20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 150)),
                              );
                            } else if (_model.step == 'deuxieme') {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: VerticalDivider(
                                                  thickness: 3,
                                                  color: Color(0xFFC4C4C4),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'AJOUTER DES PHOTOS A VOTRE BOUTIQUE',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 20,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 7)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: Text(
                                              'ces photos nous permettent de\nmieux vous identifier',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF7F8FE),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xFFDBDBDB),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      getImage(1, "logo");
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        image: logo != null
                                                            ? DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    FileImage(
                                                                        logo!),
                                                              )
                                                            : null,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .add_photo_alternate_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'AJOUTER UN LOGO',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Text(
                                                          'si vous avez un logo, \najoutez-le pour mieux vous\nidentifier',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 20)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF7F8FE),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xFFDBDBDB),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      getImage(1, "facade");
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        image: facade != null
                                                            ? DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: FileImage(
                                                                    facade!),
                                                              )
                                                            : null,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .add_photo_alternate_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'AJOUTER UNE PHOTO',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Text(
                                                          'Ajouter une photo de la façade \nde votre boutique',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 20)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF7F8FE),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xFFDBDBDB),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      getImage(1, "interieur");
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        image: interieur != null
                                                            ? DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: FileImage(
                                                                    interieur!),
                                                              )
                                                            : null,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .add_photo_alternate_outlined,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'AJOUTER UNE PHOTO',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Text(
                                                          ' Ajouter une photo de L\'INTERIEUR de votre boutique',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 20)),
                                              ),
                                            ),
                                          ),
                                          Container(height: 40)
                                        ].divide(SizedBox(height: 20)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 150)),
                              );
                            } else if (_model.step == 'troisieme') {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: VerticalDivider(
                                                  thickness: 3,
                                                  color: Color(0xFFC4C4C4),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'INFORMATIONS SUR LE PROPRIETAIRE',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 20,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 7)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: Text(
                                              'Ajouter les informations du gérant\nde la boutique',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller:
                                                    _model.textController5,
                                                focusNode:
                                                    _model.textFieldFocusNode5,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText: 'Nom',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFF9500),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  contentPadding:
                                                      EdgeInsets.all(20),
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
                                                validator: _model
                                                    .textController5Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController6,
                                              focusNode:
                                                  _model.textFieldFocusNode6,
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
                                                hintText: 'Prenom',
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
                                                    EdgeInsets.all(20),
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
                                              validator: _model
                                                  .textController6Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Stack(children: [
                                              TextFormField(
                                                controller:
                                                    _model.textController7,
                                                focusNode:
                                                    _model.textFieldFocusNode7,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText: 'Contact',
                                                  hintStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFF9500),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          60, 20, 20, 20),
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
                                                validator: _model
                                                    .textController7Validator
                                                    .asValidator(context),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 20, 0, 20),
                                                  child: Text(
                                                    "+225 | ",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFFF9500),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ]),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController8,
                                              focusNode:
                                                  _model.textFieldFocusNode8,
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
                                                    'Adresse e-mail de connexion',
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
                                                    EdgeInsets.all(20),
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
                                              validator: _model
                                                  .textController8Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Container(height: 40)
                                        ].divide(SizedBox(height: 20)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 240)),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                child: VerticalDivider(
                                                  thickness: 3,
                                                  color: Color(0xFFC4C4C4),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'CONFIRMER VOTRE COMPTE',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 20,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 7)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: Text(
                                              'Un code à 4 chiffres, vous a été\ntransmis par votre adresse mail suivant',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: Text(
                                              '${_model.textController8.text}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            Color(0xFF3688FA),
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 50),
                                            child: PinFieldAutoFill(
                                              codeLength: 4,
                                              autoFocus: true,
                                              controller:
                                                  _model.pinCodeController,
                                              decoration: BoxLooseDecoration(
                                                textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                strokeColorBuilder:
                                                    FixedColorBuilder(Colors
                                                        .black
                                                        .withOpacity(0.3)),
                                              ),
                                              currentCode: _code,
                                              onCodeSubmitted: (code) {},
                                              onCodeChanged: (code) {
                                                if (code!.length == 4) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());

                                                  setState(() {
                                                    _code = code;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Renvoyer le code',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Text(
                                                  'Modifier le mail',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 10)),
                                            ),
                                          ),
                                          Container(height: 40)
                                        ].divide(SizedBox(height: 20)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 240)),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Align(
                      alignment: AlignmentDirectional(0, 1),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x23000000),
                                offset: Offset(
                                  0,
                                  -2,
                                ),
                                spreadRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Get.to(() => const ConnexionWidget());
                                  },
                                  child: Text(
                                    'J\'ai déjà un compte',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFFF9500),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                FFButtonWidget(
                                  showLoadingIndicator: true,
                                  onPressed: () async {
                                    print('Button pressed ...');

                                    switch (_model.step) {
                                      case "premier":
                                        setState(() {
                                          _model.step = "deuxieme";
                                        });
                                        break;
                                      case "deuxieme":
                                        setState(() {
                                          _model.step = "troisieme";
                                        });
                                        break;
                                      case "troisieme":
                                        getCode();
                                        // setState(() {
                                        //   _model.step = "quatrieme";
                                        // });
                                        break;
                                      case "quatrieme":
                                        inscrire();
                                        break;
                                      default:
                                    }
                                  },
                                  text: 'Enregistrer',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: Color(0xFFFF9500),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ].divide(SizedBox(height: 20)),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
