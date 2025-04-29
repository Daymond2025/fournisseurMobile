import 'package:daymond_dis/controllers/LoginController.dart';
import 'package:daymond_dis/controllers/parametreController.dart';
import 'package:daymond_dis/controllers/supplierController.dart';
import 'package:daymond_dis/models/categorieModel.dart';
import 'package:daymond_dis/models/usermodel.dart';
import 'package:daymond_dis/models/villeModel.dart';
import 'package:daymond_dis/models/walletmodel.dart';
import 'package:daymond_dis/screens/newScreens/flutter_flow_drop_down.dart';
import 'package:daymond_dis/screens/newScreens/form_field_controller.dart';
import 'package:daymond_dis/screens/views/homeScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'profil_model.dart';
export 'profil_model.dart';

class ProfilWidget extends StatefulWidget {
  const ProfilWidget(
      {super.key, required this.user, required this.businessInfo});

  final User user;
  final Wallet businessInfo;

  static String routeName = 'profil';
  static String routePath = '/profil';

  @override
  State<ProfilWidget> createState() => _ProfilWidgetState();
}

class _ProfilWidgetState extends State<ProfilWidget> {
  late ProfilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _contactController = TextEditingController();
  final FocusNode _contactFocusNode = FocusNode();

  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  RxBool modif = false.obs; // Déclaration d'un RxBool

  final Suppliercontroller supplierController = Get.put(Suppliercontroller());
  final ConditionController etatcontroller = Get.put(ConditionController());
  final LoginController loginController = Get.put(LoginController());

  final List<CatParams> lisCat = [];
  final List<VilleParams> lisVil = [];

  String myCat = '';

  List<String>? dropDownValue;
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController;
  FormFieldController<String>? dropDownValueController2;

  final TextEditingController _nomPrenomController2 = TextEditingController();
  final FocusNode _nomPrenomFocusNode2 = FocusNode();

  final TextEditingController _contactController2 = TextEditingController();
  final FocusNode _contactFocusNode2 = FocusNode();

  final TextEditingController _emailController2 = TextEditingController();
  final FocusNode _emailFocusNode2 = FocusNode();

  showGerant() async {
    setState(() {
      _nomPrenomController2.text =
          '${widget.user!.entity.firstName} ${widget.user!.entity.lastName}';
      _contactController2.text = widget.user!.phoneNumber ?? '';
      _emailController2.text = widget.user!.email ?? '';
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
                                Obx(() => modif.value
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
                                widget.user!.picture ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              '${widget.user!.entity.firstName} ${widget.user!.entity.lastName}',
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
                                            '${widget.user!.entity.firstName} ${widget.user!.entity.lastName}',
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
                                              controller: _nomPrenomController2,
                                              focusNode: _nomPrenomFocusNode2,
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
                                          widget.user?.phoneNumber ?? '',
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
                                          widget.user!.email ?? '',
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
                                            controller: _emailController2,
                                            focusNode: _emailFocusNode2,
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
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilModel());
    getCat();
    getVilles();
    setState(() {
      _nameController.text = widget.user.entity.shop.name ?? '';
      _contactController.text = widget.user.entity.shop.phoneNumber ?? '';
      _addressController.text = widget.user.entity.shop.address ?? '';
      myCat =
          widget.user.entity.categories!.map((item) => item["name"]).join(", ");

      // dropDownValue2 = widget.user.entity.shop.city?.id.toString();
    });
    List<String>? laList = widget.user.entity.categories
        ?.map((item) => item["name"] as String)
        .toList();
    String result = laList!.map((item) => item).join(", ");
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void toggle() {
    modif.value = !modif.value; // Utiliser .value pour modifier la valeur
  }

  modifierInfos() async {
    List<CatParams> _categories = lisCat
        .where((category) => dropDownValue!.contains(category.name))
        .toList();
    print(_categories.map((cat) => cat.toJson()).toList());

    bool success = await supplierController.updateShop(
      supplierId: widget.user!.entity.id,
      id: widget.user.entity.shop.id,
      shopName: _nameController.text,
      address: _addressController.text,
      categoriesProduct: _categories,
      phoneNumber: _contactController.text,
      cityId: int.parse(dropDownValue2 as String),
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

  String capitalizeEachWord(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase();
    }).join(' ');
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
        backgroundColor: Color(0xFFF7F7FA),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF0055FF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 8,
                              buttonSize: 40,
                              fillColor: Color(0xFF0055FF),
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                                Get.to(HomeSreen());
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      capitalizeEachWord(widget
                                          .businessInfo.entity!.name as String),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            fontSize: 30,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.businessInfo.entity!.name}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '${widget.user.createdAtFr}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Obx(() => modif.value
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
                                    : SizedBox(width: 20)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
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
                                    'Nom de votre boutique',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF676767),
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(() => !modif.value
                                      ? Text(
                                          '${widget.user.entity.shop.name}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 20,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      : Container(
                                          width: 200,
                                          child: TextFormField(
                                            controller: _nameController,
                                            focusNode: _nameFocusNode,
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
                                              hintText: 'Nom de votre boutique',
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
                      Container(
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
                              Expanded(
                                // Permet d'éviter les débordements en donnant plus d'espace à la liste
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Catégorie des produits vendus',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF676767),
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    SizedBox(
                                        height:
                                            10), // Ajoute un espacement entre le titre et la liste
                                    Obx(() => modif.value
                                        ? Container(
                                            width: 200,
                                            child: FlutterFlowDropDown<String>(
                                              controller: dropDownValueController ??=
                                                  FormFieldController<
                                                      String>((dropDownValue ??= widget
                                                              .user
                                                              .entity
                                                              .categories
                                                              ?.map((item) =>
                                                                  item["name"]
                                                                      as String)
                                                              .toList())
                                                          ?.map((item) => item)
                                                          .join(", ") ??
                                                      null),
                                              onChangedForMultiSelect: (val) {
                                                print(val);
                                                safeSetState(
                                                    () => dropDownValue = val);
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
                                              hintText: '   Catégories',
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
                                          )
                                        : SizedBox(
                                            height:
                                                25, // Ajuste la hauteur selon tes besoins
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: widget.user.entity
                                                  .categories!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFFFECEC),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      '${widget.user.entity.categories![index]["name"]}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            color: Color(
                                                                0xFFFF5F84),
                                                            fontSize: 10,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                  ],
                                ),
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
                      Container(
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
                                    'Localisation',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF676767),
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(() => !modif.value
                                      ? Text(
                                          '${widget.user.entity.shop.city!.name}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 15,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Column(
                                                children: [
                                                  FlutterFlowDropDown<String>(
                                                    controller: dropDownValueController2 ??=
                                                        FormFieldController<
                                                                String>(
                                                            dropDownValue2 ??=
                                                                widget
                                                                        .user
                                                                        .entity
                                                                        .shop
                                                                        .city
                                                                        ?.id
                                                                        .toString() ??
                                                                    null),
                                                    // onChangedForMultiSelect: (val) {
                                                    //   print(val);
                                                    //   safeSetState(() =>
                                                    //       _model.dropDownValue = val);
                                                    // },
                                                    options: lisVil
                                                        .map((cat) => (cat
                                                                .toJson()['id']
                                                                .toString())
                                                            as String)
                                                        .toList(),
                                                    optionLabels: lisVil
                                                        .map((cat) =>
                                                            cat.toJson()['name']
                                                                as String)
                                                        .toList(),
                                                    onChanged: (val) {
                                                      print(val);
                                                      safeSetState(() =>
                                                          dropDownValue2 = val);
                                                    },
                                                    width: double.infinity,
                                                    height: 49,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24,
                                                    ),
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    elevation: 2,
                                                    borderColor:
                                                        Color(0xFFC4C4C4),
                                                    borderWidth: 0,
                                                    borderRadius: 8,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    hidesUnderline: true,
                                                    // isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _addressController,
                                                    focusNode:
                                                        _addressFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintText: 'Adresse',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFFF9500),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      contentPadding:
                                                          EdgeInsets.all(10),
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
                                                    // validator: _model
                                                    //     .textController1Validator
                                                    //     .asValidator(context),
                                                  ),
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                            ),
                                          ],
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
                      Container(
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
                                          color: Color(0xFF676767),
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Obx(() => !modif.value
                                      ? Text(
                                          '${widget.user.entity.shop.phoneNumber}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 15,
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
                                              hintText: 'Contact',
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
                      Container(
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
                                    'Numéro de compte',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF676767),
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Transactions',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Color(0xFF676767),
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '${widget.user.entity.shop.phoneNumber}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              'https://picsum.photos/seed/351/600',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 10)),
                                      ),
                                    ].divide(SizedBox(width: 10)),
                                  ),
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
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                                    'Les photos de la \nboutique',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 20,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 10)),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.user.entity.shop.shopPicture![0] ??
                                      'https://picsum.photos/seed/291/600',
                                  width: 70,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 20, 0),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      '${widget.businessInfo.entity!.logo}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.user.entity.shop.name}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF0084FE),
                                            fontSize: 20,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      'Info gérant',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 10)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
