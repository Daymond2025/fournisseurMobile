import 'dart:io';

import 'package:daymond_dis/constants/constantApp.dart';
import 'package:daymond_dis/controllers/GetUsercontroller.dart';
import 'package:daymond_dis/controllers/parametreController.dart';
import 'package:daymond_dis/controllers/productController.dart';
import 'package:daymond_dis/controllers/shopController.dart';
import 'package:daymond_dis/controllers/walletController.dart';
import 'package:daymond_dis/models/api_response.dart';
import 'package:daymond_dis/models/statemedel.dart';
import 'package:daymond_dis/models/usermodel.dart';
import 'package:daymond_dis/screens/views/produits/produitscreen.dart';
import 'package:daymond_dis/services/userService%20.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow_drop_down.dart';
import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import '../form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'creation_produit_model.dart';
export 'creation_produit_model.dart';

class CreationProduitWidget extends StatefulWidget {
  const CreationProduitWidget({super.key});

  static String routeName = 'creationProduit';
  static String routePath = '/creationProduit';

  @override
  State<CreationProduitWidget> createState() => _CreationProduitWidgetState();
}

class _CreationProduitWidgetState extends State<CreationProduitWidget> {
  late CreationProduitModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductController produiController = Get.put(ProductController());
  final ConditionController etatcontroller = Get.put(ConditionController());
  final WalletController adminController = Get.find<WalletController>();
  final ShopController shopController = Get.put(ShopController());
  User? user;
  final _formKey = GlobalKey<FormState>();
  final List<StateParams> lisEtat = [];
  StateParams? selectedAccountValue;
  bool isLoading = false;
  List<String> _imagePaths =
      List.filled(8, ""); // Liste pour stocker les chemins d'images

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _etatController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();
  final TextEditingController _prixOfficielController = TextEditingController();
  final TextEditingController _prixPartenaireController =
      TextEditingController();
  String? boutique;
  int? idsop;
  final GetUserController authController = Get.find<GetUserController>();
  //final TextEditingController _taillesController = TextEditingController();
  //final TextEditingController _couleurController = TextEditingController();
  final TextEditingController _codeProduitController = TextEditingController();

  // Controller pour les tailles
  final TextEditingController _tailleController = TextEditingController();
  List<XFile?> _imageFiles = List.filled(8, null);
  // Liste pour stocker les tailles ajoutées
  List<String> _taillesAjoutees = [];
  bool errorMessage = false;
  double commissionMin = 0.0;

  // Méthode pour ajouter une taille
  void _ajouterTaille() {
    if (_taillesAjoutees.length < 6 && _tailleController.text.isNotEmpty) {
      setState(() {
        _taillesAjoutees.add(_tailleController.text);
        _tailleController.clear(); // Effacer le champ après ajout
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vous pouvez ajouter un maximum de 6 tailles'),
        ),
      );
    }
  }

  Future<void> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_info');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      setState(() {
        user = User.fromJson(userMap);
      });
      print("User info : ${user?.entity.shop.id}");
      setState(() {
        idsop = user?.entity.shop.id;
      });
    } else {
      print("User info : est nul");
    }
  }

  void _choisirCouleur() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Choisir une couleur',
              style: AppConstants.headingTextStyle.copyWith(fontSize: 15),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: _couleursDisponibles.map((couleur) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: couleur['color'],
                  ),
                  title: Text(couleur['name']),
                  onTap: () {
                    setState(() {
                      if (!_couleursAjoutees
                          .any((c) => c['name'] == couleur['name'])) {
                        _couleursAjoutees.add(couleur);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();

  bool _isValidExtension(String path) {
    final extension = path.split('.').last.toLowerCase();
    return extension == 'png' || extension == 'jpg' || extension == 'jpeg';
  }

// Méthode pour sélectionner plusieurs images
  Future<void> _ajouterImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        for (var image in images) {
          if (_isValidExtension(image.path)) {
            for (int i = 0; i < _imagePaths.length; i++) {
              if (_imagePaths[i].isEmpty) {
                _imagePaths[i] = image.path;
                break; // Sortir de la boucle dès qu'une image est ajoutée
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Format d\'image invalide. Seuls PNG, JPG et JPEG sont acceptés.'),
              ),
            );
          }
        }

        // Vérification si le nombre d'images dépasse 8
        if (_imagePaths.where((path) => path.isNotEmpty).length > 8) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Vous ne pouvez ajouter que 8 images'),
            ),
          );
        }
      });
    }
  }

  // Méthode pour supprimer une image
  void _supprimerImage(int index) {
    setState(() {
      _imagePaths[index] =
          ""; // Réinitialiser le chemin d'image à une chaîne vide
    });
  }

  // Méthode pour supprimer une taille
  void _supprimerTaille(String taille) {
    setState(() {
      _taillesAjoutees.remove(taille);
    });
  }

  // Liste des couleurs ajoutées
  List<Map<String, dynamic>> _couleursAjoutees = [];

  // Liste des couleurs disponibles avec leurs noms en français
  final List<Map<String, dynamic>> _couleursDisponibles = [
    {'name': 'Rouge', 'color': Colors.red, 'value': '#FF0000'},
    {'name': 'Bleu', 'color': Colors.blue, 'value': '#0000FF'},
    {'name': 'Vert', 'color': Colors.green, 'value': '#008000'},
    {'name': 'Jaune', 'color': Colors.yellow, 'value': '#FFFF00'},
    {'name': 'Noir', 'color': Colors.black, 'value': '#000000'},
    {'name': 'Blanc', 'color': Colors.white, 'value': '#FFFFFF'},
    {'name': 'Gris', 'color': Colors.grey, 'value': '#808080'},
    {'name': 'Orange', 'color': Colors.orange, 'value': '#FFA500'},
    {'name': 'Violet', 'color': Colors.purple, 'value': '#800080'},
    {'name': 'Rose', 'color': Colors.pink, 'value': '#FFC0CB'},
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreationProduitModel());

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

    _prixOfficielController.addListener(validateCommission);
    _prixPartenaireController.addListener(validateCommission);

    etatcontroller.fetchConditions().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          // Populate items list with category names
          lisEtat.addAll(etatcontroller.conditionList.value);
          //print('item new expense add:::::::::::::::::$items');
        });
      });
    });

    getUserInfo();
  }

  // Fonction pour obtenir le pourcentage minimum requis en fonction du prix de vente
  double getRequiredPercentage(double price) {
    if (price >= 2000 && price <= 30000) {
      setState(() {
        commissionMin = price * 0.20;
      });
      return 0.20;
    }
    if (price >= 30001 && price <= 75000) {
      setState(() {
        commissionMin = price * 0.15;
      });
      return 0.15;
    }
    if (price >= 75001 && price <= 500000) {
      setState(() {
        commissionMin = price * 0.12;
      });
      return 0.12;
    }
    if (price >= 500001 && price <= 2000000) {
      setState(() {
        commissionMin = price * 0.7;
      });
      return 0.07;
    }
    if (price >= 2000001 && price <= 100000000) {
      setState(() {
        commissionMin = price * 0.10;
      });
      return 0.10;
    }
    return 0.0;
  }

  void validateCommission() {
    double? price = double.tryParse(_prixOfficielController.text);
    double? commission = double.tryParse(_prixPartenaireController.text);

    if (price == null || commission == null) {
      setState(() => errorMessage = false);
      return;
    }

    double requiredCommission = price * getRequiredPercentage(price);

    if (commission < requiredCommission) {
      setState(() {
        errorMessage = true;
      });
    } else {
      setState(() => errorMessage = false);
    }
  }

  void getUser(String p) async {
    print('///////////////////////////////////////////////////$p');
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      if (mounted) {
        setState(() {
          user = response.data as User;
          //loading = false;
          //txtNameController.text = user!.name ?? '';
        });
      }
    } else if (response.error == AppConstants.unauthorized) {
    } else {}
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
        backgroundColor: Color(0xFFF7F8FE),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Container(
                    width: double.infinity,
                    height: 750,
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
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 80,
                                    buttonSize: 40,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color:
                                          // _model.step == "premier"
                                          //     ? Colors.white
                                          //     :
                                          Color(0xFFFF9500),
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      switch (_model.step) {
                                        case "premier":
                                          Get.to(() => const ProduitScreen());
                                        case "quatrieme":
                                          setState(() {
                                            _model.step = "troisieme";
                                          });
                                          break;
                                        case "troisieme":
                                          setState(() {
                                            _model.step = "deuxieme";
                                          });
                                          break;
                                        case "deuxieme":
                                          setState(() {
                                            _model.step = "premier";
                                          });
                                          break;
                                        default:
                                      }
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 40, 0),
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
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (_model.step == 'premier') {
                                    return Stack(
                                      alignment: AlignmentDirectional(0, 1),
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 120),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          'AJOUTER DES PHOTOS DE L\'ARTICLE',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 7)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 20, 0),
                                                    child: Text(
                                                      '4 minimums',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: _ajouterImages,
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF7F8FE),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(30),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .add_photo_alternate_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 50,
                                                            ),
                                                            Text(
                                                              'AJOUTER UNE PHOTO',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        12,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child:

                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 2),
                                                    child: GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10,
                                                        childAspectRatio: 1,
                                                      ),
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(), // Empêche le défilement si dans une colonne
                                                      itemCount: _imagePaths
                                                          .length, // Assure que l'index est valide
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Stack(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Container(
                                                                height: 200,
                                                                width: 200,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image: _imagePaths[
                                                                              index]
                                                                          .isNotEmpty
                                                                      ? DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              FileImage(File(_imagePaths[index])),
                                                                        )
                                                                      : null,
                                                                  color: Color(
                                                                      0xFFF7F8FE),
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xFFDBDBDB)),
                                                                ),
                                                                child: _imagePaths[
                                                                            index]
                                                                        .isEmpty
                                                                    ? Icon(
                                                                        Icons
                                                                            .image_outlined,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            40)
                                                                    : null,
                                                              ),
                                                            ),
                                                            if (_imagePaths[
                                                                    index]
                                                                .isNotEmpty)
                                                              Positioned(
                                                                right: 0,
                                                                top: 0,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .dangerous,
                                                                      color: Colors
                                                                          .red),
                                                                  onPressed: () =>
                                                                      _supprimerImage(
                                                                          index),
                                                                ),
                                                              ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // ),
                                                ].divide(SizedBox(height: 20)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (_model.step == 'deuxieme') {
                                    return SingleChildScrollView(
                                      child: Column(
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 20, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          'COMMENCER A AJOUTER UN PRODUIT',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 7)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 20, 0),
                                                    child: Text(
                                                      'Choisissez bien vos mots pour mieux vendre',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller:
                                                          _nomController,
                                                      focusNode: _model
                                                          .textFieldFocusNode1,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                        hintText:
                                                            'Quel est le nom de cet article ?',
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFC4C4C4),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFF9500),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                          borderSide:
                                                              BorderSide(
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
                                                            EdgeInsets.all(20),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller:
                                                          _marqueController,
                                                      focusNode: _model
                                                          .textFieldFocusNode2,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                        hintText: 'Marque',
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFC4C4C4),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFF9500),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                          borderSide:
                                                              BorderSide(
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
                                                            EdgeInsets.all(20),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                          .textController2Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 52,
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton2<
                                                                    StateParams>(
                                                              isExpanded: true,
                                                              hint: const Text(
                                                                "Etat",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          175,
                                                                          175,
                                                                          175),
                                                                ),
                                                              ),
                                                              items: lisEtat
                                                                  .map(
                                                                    (item) =>
                                                                        DropdownMenuItem(
                                                                      value:
                                                                          item,
                                                                      child:
                                                                          Text(
                                                                        item.name,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              175,
                                                                              175,
                                                                              175),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                              value:
                                                                  selectedAccountValue,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedAccountValue =
                                                                      value;
                                                                  // Pass the id to the controller instead of the name
                                                                  int selectedId =
                                                                      value!.id;
                                                                  print(
                                                                      'Selected ID: $selectedId'); // This is where you send it to the controller
                                                                  // Example: controller.updateState(selectedId);
                                                                });
                                                              },
                                                              buttonStyleData:
                                                                  ButtonStyleData(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16),
                                                                height: 52,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.90,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          229,
                                                                          229,
                                                                          229)),
                                                                ),
                                                              ),
                                                              dropdownStyleData:
                                                                  const DropdownStyleData(
                                                                maxHeight: 300,
                                                              ),
                                                              menuItemStyleData:
                                                                  const MenuItemStyleData(
                                                                height: 40,
                                                              ),
                                                              dropdownSearchData:
                                                                  DropdownSearchData(
                                                                searchController:
                                                                    _etatController,
                                                                searchInnerWidgetHeight:
                                                                    50,
                                                                searchInnerWidget:
                                                                    Container(
                                                                  height: 50,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 8,
                                                                    bottom: 4,
                                                                    right: 8,
                                                                    left: 8,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    expands:
                                                                        true,
                                                                    maxLines:
                                                                        null,
                                                                    controller:
                                                                        _etatController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            8,
                                                                      ),
                                                                      hintText:
                                                                          'Rechercher un etat...',
                                                                      hintStyle: const TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              175,
                                                                              175,
                                                                              175)),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                searchMatchFn:
                                                                    (item,
                                                                        searchValue) {
                                                                  return item
                                                                      .value!
                                                                      .name
                                                                      .toString()
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          searchValue
                                                                              .toLowerCase());
                                                                },
                                                              ),
                                                              onMenuStateChange:
                                                                  (isOpen) {
                                                                if (!isOpen) {
                                                                  _etatController
                                                                      .clear();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                _quantiteController,
                                                            focusNode: _model
                                                                .textFieldFocusNodes,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
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
                                                              hintText:
                                                                  'Quantité en stock',
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
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFC4C4C4),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFFF9500),
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .textController2Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10)),
                                                  ),
                                                ].divide(SizedBox(height: 20)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 150)),
                                      ),
                                    );
                                  } else if (_model.step == 'troisieme') {
                                    return Stack(
                                      alignment: AlignmentDirectional(0, 0),
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 120),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          'QUELS SONT LES CARACTERISTIQUES DE CET ARTICLE',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 7)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 20, 0),
                                                    child: Text(
                                                      'Choisissez bien vos mots pour mieux vendre',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller:
                                                            _descriptionController,
                                                        focusNode: _model
                                                            .textFieldFocusNode3,
                                                        autofocus: false,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
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
                                                          hintText:
                                                              'Description de l\'article',
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
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFFC4C4C4),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFFFF9500),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  20),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        maxLines: 4,
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        validator: _model
                                                            .textController3Validator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  210,
                                                                  210,
                                                                  210)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                'Taille du produit',
                                                                style: AppConstants
                                                                    .bodyTextStyle,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        title:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Ajouter des tailles",
                                                                            style:
                                                                                AppConstants.headingTextStyle.copyWith(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                        content: TextField(
                                                                            controller:
                                                                                _tailleController,
                                                                            decoration:
                                                                                AppConstants.inputDecoration.copyWith(labelText: 'Saisir la taille')),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop(); // Fermer le pop-up
                                                                            },
                                                                            child:
                                                                                const Text("Annuler"),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                AppConstants.validateButtonStyle,
                                                                            onPressed: () =>
                                                                                _ajouterTaille(),
                                                                            child:
                                                                                const Text(
                                                                              "Valider",
                                                                              style: AppConstants.buttonTextStyle,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 25,
                                                                ),
                                                              )
                                                            ],
                                                          ),

                                                          /*    TextFormField(
                                                                                controller: _tailleController,
                                                                                decoration: const InputDecoration(
                                                                                    labelText: 'Ajouter une taille',
                                                                                    labelStyle: AppConstants.bodyTextStyle),
                                                                              ),
                                                         
                                                         */
                                                          const SizedBox(
                                                              height: 10),

                                                          // Afficher les tailles ajoutées
                                                          Wrap(
                                                            spacing:
                                                                8, // Espacement entre les éléments
                                                            alignment: WrapAlignment
                                                                .start, // Aligner les éléments de gauche à droite
                                                            children:
                                                                _taillesAjoutees
                                                                    .map(
                                                                        (taille) {
                                                              return Chip(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                label: Text(
                                                                    taille),
                                                                onDeleted: () {
                                                                  _supprimerTaille(
                                                                      taille);
                                                                },
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  210,
                                                                  210,
                                                                  210)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                'Couleur du produit',
                                                                style: AppConstants
                                                                    .bodyTextStyle,
                                                              ),
                                                              InkWell(
                                                                onTap: () =>
                                                                    _choisirCouleur(),
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 25,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Wrap(
                                                            spacing:
                                                                8, // Espacement entre les éléments
                                                            alignment: WrapAlignment
                                                                .start, // Aligner les éléments de gauche à droite
                                                            children:
                                                                _couleursAjoutees
                                                                    .map(
                                                                        (couleur) {
                                                              return Chip(
                                                                backgroundColor:
                                                                    couleur[
                                                                        'color'],
                                                                avatar:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      couleur[
                                                                          'color'],
                                                                ),
                                                                label: Text(
                                                                  couleur[
                                                                      'name'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onDeleted: () {
                                                                  setState(() {
                                                                    _couleursAjoutees
                                                                        .remove(
                                                                            couleur);
                                                                  });
                                                                },
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 20)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 160)),
                                    );
                                  } else {
                                    return SingleChildScrollView(
                                      child: Column(
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 20, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          'DERNIERE ETAPE',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 7)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 20, 0),
                                                    child: Text(
                                                      'Ajouter les prix et les commissions',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Material(
                                                  //     color: Colors.transparent,
                                                  //     elevation: 1,
                                                  //     shape:
                                                  //         RoundedRectangleBorder(
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(10),
                                                  //     ),
                                                  //     child:
                                                  Container(
                                                    // height: 100,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFF5F6FB),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Frais de livraison Livraison',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  width: 100,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        _model
                                                                            .textController4,
                                                                    focusNode:
                                                                        _model
                                                                            .textFieldFocusNode4,
                                                                    autofocus:
                                                                        false,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      labelStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                      hintText:
                                                                          'A Abidjan',
                                                                      hintStyle: FlutterFlowTheme.of(
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0xFFC4C4C4),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0xFFFF9500),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    cursorColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    validator: _model
                                                                        .textController4Validator
                                                                        .asValidator(
                                                                            context),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  width: 100,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _model
                                                                            .textController5,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    focusNode:
                                                                        _model
                                                                            .textFieldFocusNode5,
                                                                    autofocus:
                                                                        false,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      labelStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                      hintText:
                                                                          'Hors Abidjan',
                                                                      hintStyle: FlutterFlowTheme.of(
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
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0xFFC4C4C4),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0xFFFF9500),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    cursorColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    validator: _model
                                                                        .textController5Validator
                                                                        .asValidator(
                                                                            context),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 10)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 10)),
                                                      ),
                                                    ),
                                                  ),
                                                  //   ),
                                                  // ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _prixOfficielController,
                                                      focusNode: _model
                                                          .textFieldFocusNode6,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                        hintText:
                                                            'Prix de vente',
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFC4C4C4),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFF9500),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                          borderSide:
                                                              BorderSide(
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
                                                            EdgeInsets.all(20),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                          .textController6Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _prixPartenaireController,
                                                      focusNode: _model
                                                          .textFieldFocusNode7,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
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
                                                        hintText:
                                                            'Commission Daymond',
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
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFC4C4C4),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFFF9500),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                          borderSide:
                                                              BorderSide(
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
                                                            EdgeInsets.all(20),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                          .textController7Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  if (errorMessage == true)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFFECEC),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        'Nous vous recommandons une commission de ${commissionMin.toStringAsFixed(2)} FCFA pour ce produit',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFFFF5F84),
                                                                  fontSize: 10,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),

                                                  if (_prixOfficielController
                                                      .text.isNotEmpty)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFFECEC),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        'Commission minimum ${commissionMin.toStringAsFixed(2)} FCFA',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Color(
                                                                      0xFFFF5F84),
                                                                  fontSize: 10,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                ].divide(SizedBox(height: 20)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 240)),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
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
                                    height: 100,
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
                                          FFButtonWidget(
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
                                                  setState(() {
                                                    _model.step = "quatrieme";
                                                  });
                                                  break;
                                                case "quatrieme":
                                                  EasyLoading.show(
                                                      status: "Un instant...");
                                                  Projet Produit = Projet(
                                                    price_city_delivery:
                                                        double.parse(_model
                                                            .textController5
                                                            .text),
                                                    price_no_city_delivery:
                                                        double.parse(_model
                                                            .textController5
                                                            .text),
                                                    marque: _nomController.text,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                    etat:
                                                        1, // Ex. valeur fixe ou ajustée en fonction de tes besoins
                                                    quantite: int.parse(
                                                        _quantiteController
                                                            .text),
                                                    prixOfficiel: double.parse(
                                                        _prixOfficielController
                                                            .text),
                                                    prixPartenaire: double.parse(
                                                        _prixPartenaireController
                                                            .text),
                                                    tailles:
                                                        _taillesAjoutees, // Liste des tailles ajoutées
                                                    couleurs:
                                                        _couleursAjoutees, // Liste des couleurs ajoutées
                                                    codeProduit:
                                                        _codeProduitController
                                                            .text,
                                                    imagePaths:
                                                        _imagePaths, // Chemins des images sélectionnées
                                                  );

                                                  // Appel de la méthode submitProjet du ProductController
                                                  ProducttController
                                                      projetController =
                                                      ProducttController();
                                                  bool success =
                                                      await projetController
                                                          .submitProjet(Produit,
                                                              idshop: idsop);

                                                  // Affichage d'un message en fonction de la réussite ou de l'échec de la soumission
                                                  if (success) {
                                                    EasyLoading.showSuccess(
                                                        'Produit soumis avec succès!');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Produit soumis avec succès!'),
                                                      ),
                                                    );
                                                  } else {
                                                    EasyLoading.showError(
                                                        'Erreur lors de la soumission du produit');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Erreur lors de la soumission du produit'),
                                                      ),
                                                    );
                                                  }
                                                  break;
                                                default:
                                              }
                                            },
                                            text: _model.step != "quatrieme"
                                                ? 'Enregistrer'
                                                : "Soumettre",
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 49,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 16, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color: Color(0xFFFF9500),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Inter Tight',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 0,
                                              borderRadius:
                                                  BorderRadius.circular(24),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
