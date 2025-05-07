import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../constants/app_images.dart';
import '../../../constants/constantApp.dart';
import '../../../controllers/parametreController.dart';
import '../../../controllers/productController.dart';
import '../../../models/promadel.dart';
import '../../../models/statemodel.dart';
import '../../../models/usermodel.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProduit extends StatefulWidget {
  final Product produit;
  const UpdateProduit({super.key, required this.produit});

  @override
  State<UpdateProduit> createState() => _UpdateProduitState();
}

class _UpdateProduitState extends State<UpdateProduit> {
  final ProductController produiController = Get.put(ProductController());
  final ConditionController etatcontroller = Get.put(ConditionController());
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
  //final TextEditingController _taillesController = TextEditingController();
  //final TextEditingController _couleurController = TextEditingController();
  final TextEditingController _codeProduitController = TextEditingController();

  // Controller pour les tailles
  final TextEditingController _tailleController = TextEditingController();
  List<XFile?> _imageFiles = List.filled(8, null);
  // Liste pour stocker les tailles ajoutées
  List<String> _taillesAjoutees = [];

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
    {'name': 'Rouge', 'color': Colors.red},
    {'name': 'Bleu', 'color': Colors.blue},
    {'name': 'Vert', 'color': Colors.green},
    {'name': 'Jaune', 'color': Colors.yellow},
    {'name': 'Noir', 'color': Colors.black},
    {'name': 'Blanc', 'color': Colors.white},
    {'name': 'Gris', 'color': Colors.grey},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Violet', 'color': Colors.purple},
    {'name': 'Rose', 'color': Colors.pink},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etatcontroller.fetchConditions().then((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          // Populate items list with category names
          lisEtat.addAll(etatcontroller.conditionList.value);
          //print('item new expense add:::::::::::::::::$items');
        });
      });
    });

    _nomController.text = widget
        .produit.name!; // Ajustez le nom de la propriété selon votre modèle
    _marqueController.text = widget
        .produit.subTitle!; // Ajustez le nom de la propriété selon votre modèle
    _descriptionController.text = widget.produit
        .description!; // Ajustez le nom de la propriété selon votre modèle
    _etatController.text = widget.produit.state!.id
        .toString(); // Ajustez le nom de la propriété selon votre modèle
    _quantiteController.text = widget.produit.totalstock
        .toString(); // Assurez-vous que la conversion est correcte
    _prixOfficielController.text = widget.produit.price!.price
        .toString(); // Assurez-vous que la conversion est correcte
    _prixPartenaireController.text = widget.produit.price!.partner
        .toString(); // Assurez-vous que la conversion est correcte
    _codeProduitController.text = widget
        .produit.code!; // Ajustez le nom de la propriété selon votre modèle

    // Si vous avez une liste de tailles à pré-remplir, faites-le ici
    //_taillesAjoutees.addAll(widget.produit.sizes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Modifier'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(255, 232, 226, 226))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(' Ajouter 8 Images'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: _ajouterImages,
                              child: Image.asset(
                                Images.addpict,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: _imagePaths[index].isEmpty
                                    ? Image.asset(
                                        Images.picgrey,
                                        height: 30,
                                        width: 30,
                                      )
                                    : Image.file(File(_imagePaths[index]),
                                        fit: BoxFit.cover),
                              ),
                              if (_imagePaths[index].isNotEmpty)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.dangerous,
                                        color: Colors.red),
                                    onPressed: () => _supprimerImage(index),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 16),

              // Nom de l'article
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _nomController,
                decoration: AppConstants.inputDecoration
                    .copyWith(labelText: 'Nom de l\'article'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'article';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Marque
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _marqueController,
                decoration:
                    AppConstants.inputDecoration.copyWith(labelText: 'Marque'),
              ),
              const SizedBox(height: 16),
              // Description
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _descriptionController,
                decoration: AppConstants.inputDecoration
                    .copyWith(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<StateParams>(
                          isExpanded: true,
                          hint: const Text(
                            "Etat",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 175, 175, 175),
                            ),
                          ),
                          items: lisEtat
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 175, 175, 175),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: selectedAccountValue,
                          onChanged: (value) {
                            setState(() {
                              selectedAccountValue = value;
                              // Pass the id to the controller instead of the name
                              int selectedId = value!.id;
                              print(
                                  'Selected ID: $selectedId'); // This is where you send it to the controller
                              // Example: controller.updateState(selectedId);
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 52,
                            width: MediaQuery.of(context).size.height * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 229, 229, 229)),
                            ),
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 300,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: _etatController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: _etatController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Rechercher un etat...',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromARGB(255, 175, 175, 175)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value!.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase());
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              _etatController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: AppConstants.inputTextStyle,
                      controller: _quantiteController,
                      decoration: AppConstants.inputDecoration
                          .copyWith(labelText: 'Quantité'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              // État du produit

              const SizedBox(height: 16),
              // Prix officiel
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _prixOfficielController,
                decoration: AppConstants.inputDecoration
                    .copyWith(labelText: 'Prix officiel'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Prix partenaire
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _prixPartenaireController,
                decoration: AppConstants.inputDecoration
                    .copyWith(labelText: 'Prix partenaire'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Tailles du produit
              // Tailles du produit - Ajout de plusieurs tailles

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 210, 210, 210)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ajouter une taille',
                          style: AppConstants.bodyTextStyle,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Center(
                                    child: Text(
                                      "Ajouter des tailles",
                                      style: AppConstants.headingTextStyle
                                          .copyWith(fontSize: 15),
                                    ),
                                  ),
                                  content: TextField(
                                      controller: _tailleController,
                                      decoration: AppConstants.inputDecoration
                                          .copyWith(
                                              labelText: 'Saisir la taille')),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Fermer le pop-up
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    ElevatedButton(
                                      style: AppConstants.validateButtonStyle,
                                      onPressed: () => _ajouterTaille(),
                                      child: const Text(
                                        "Valider",
                                        style: AppConstants.buttonTextStyle,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 25,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Afficher les tailles ajoutées
                    Wrap(
                      spacing: 8, // Espacement entre les éléments
                      alignment: WrapAlignment
                          .start, // Aligner les éléments de gauche à droite
                      children: _taillesAjoutees.map((taille) {
                        return Chip(
                          backgroundColor: Colors.white,
                          label: Text(taille),
                          onDeleted: () {
                            _supprimerTaille(taille);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Sélection des couleurs du produit
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 210, 210, 210)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Couleur du produit',
                          style: AppConstants.bodyTextStyle,
                        ),
                        InkWell(
                          onTap: () => _choisirCouleur(),
                          child: const Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 4,
                      children: _couleursAjoutees.map((couleur) {
                        return Chip(
                          backgroundColor: couleur['color'],
                          avatar: CircleAvatar(
                            backgroundColor: couleur['color'],
                          ),
                          label: Text(
                            couleur['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          onDeleted: () {
                            setState(() {
                              _couleursAjoutees.remove(couleur);
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              const SizedBox(height: 16),
              // Code produit
              TextFormField(
                style: AppConstants.inputTextStyle,
                controller: _codeProduitController,
                decoration: AppConstants.inputDecoration.copyWith(
                    labelText: 'CODE PRODUIT',
                    suffix: const Icon(
                      Icons.scanner,
                      color: Colors.orange,
                      size: AppConstants.iconSizeMedium,
                    )),
              ),

              const SizedBox(height: 20),

              // Boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: OutlinedButton(
                      style: AppConstants.outlineButtonStyle,
                      onPressed: () async {
                        // Implémentez la logique du scan
                        var result = await BarcodeScanner.scan();
                        if (result.rawContent.isNotEmpty) {
                          setState(() {
                            _codeProduitController.text = result.rawContent;
                          });
                        }
                      },
                      child: const Text(
                        'Scanner',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: AppConstants.validateButtonStyle,
                      onPressed: produiController.isLoadingproduit.value
                          ? null // Désactiver le bouton pendant le chargement
                          : () async {
                              // Validation du formulaire avant soumission

                              // Création d'une instance de Projet avec les valeurs des champs du formulaire
                              Projet projet = Projet(
                                marque: _nomController.text,
                                description: _descriptionController.text,
                                etat:
                                    1, // Ex. valeur fixe ou ajustée en fonction de tes besoins
                                quantite: int.parse(_quantiteController.text),
                                prixOfficiel:
                                    double.parse(_prixOfficielController.text),
                                prixPartenaire: double.parse(
                                    _prixPartenaireController.text),
                                tailles:
                                    _taillesAjoutees, // Liste des tailles ajoutées
                                couleurs:
                                    _couleursAjoutees, // Liste des couleurs ajoutées
                                codeProduit: _codeProduitController.text,
                                imagePaths:
                                    _imagePaths, // Chemins des images sélectionnées
                              );

                              // Appel de la méthode submitProjet du ProductController
                              ProducttController projetController =
                                  ProducttController();
                              bool success = await projetController
                                  .updateProjet(projet, widget.produit.id);

                              // Affichage d'un message en fonction de la réussite ou de l'échec de la soumission
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Projet soumis avec succès!'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Erreur lors de la soumission du projet'),
                                  ),
                                );
                              }
                            },
                      child: produiController.isLoadingproduit.value
                          ? const SpinKitCircle(
                              color: Colors.white,
                              size: 24.0,
                            )
                          : Text('Modifier',
                              style: AppConstants.buttonTextStyle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _choisirCouleur() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choisir une couleur',
            style: AppConstants.headingTextStyle.copyWith(fontSize: 15),
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
}
