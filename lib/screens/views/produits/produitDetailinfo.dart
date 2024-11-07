import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constants/constantApp.dart';
import '../../../controllers/productController.dart';
import '../../../models/promadel.dart';
import 'updateProduit.dart';

class ProduitDetailInfo extends StatelessWidget {
  final Product product; // Receive the product

  ProduitDetailInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    final ProducttController productController = Get.find();
    // Use the first image as the main image
    final firstImage = product.images!.isNotEmpty
        ? product.images!.first
        : 'https://lasagadesaudacieux.com/wp-content/uploads/2021/07/produit.jpg'; // Default image if no image available

    // Get other images excluding the first one
    final otherImages = product.images!.length > 1
        ? product.images!.sublist(1)
        : []; // Sublist from the second image onward

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Produits',
          style: AppConstants.headingTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: 5,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey)),
                          SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Changer le Statut',
                            style: AppConstants.headingTextStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 10),
                          if (product.publish != 1)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logique pour "Livré"
                                  Get.off(
                                      () => UpdateProduit(produit: product));
                                },
                                style: AppConstants.outlineButtonStyle.copyWith(
                                    side: const MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Color.fromARGB(
                                                185, 7, 143, 255))),
                                    backgroundColor: MaterialStatePropertyAll(
                                      hexToColor('#E2F5FF'),
                                    ) // Couleur "Livré"
                                    ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Modifier les infos',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                185, 7, 143, 255))),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (product.outStock != 0 || product.unavailable == 1)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      TextEditingController numberController =
                                          TextEditingController();

                                      return AlertDialog(
                                        title: const Text("Saisir le stocks"),
                                        content: TextField(
                                            controller: numberController,
                                            keyboardType: TextInputType.number,
                                            decoration: AppConstants
                                                .inputDecoration
                                                .copyWith(
                                                    hintText:
                                                        'Saisir le stock')),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Fermer le pop-up
                                            },
                                            child: const Text("Annuler"),
                                          ),
                                          ElevatedButton(
                                            style: AppConstants
                                                .validateButtonStyle,
                                            onPressed: () {
                                              String enteredNumber =
                                                  numberController.text;
                                              String params;
                                              if (product.outStock == 1) {
                                                params = 'out_stock';
                                              } else if (product.unavailable ==
                                                  1) {
                                                params = 'unavailable';
                                              } else {
                                                params =
                                                    'out_stock'; // ou une autre valeur par défaut
                                              }

// Vous pouvez traiter le chiffre ici (ex: mise à jour du stock)
                                              productController.stoksUpdate(
                                                  product.id,
                                                  enteredNumber,
                                                  params);

                                              print(
                                                  "Chiffre saisi: $enteredNumber");

                                              // Fermer le pop-up après soumission
                                            },
                                            child: const Text(
                                              "Valider",
                                              style:
                                                  AppConstants.buttonTextStyle,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: AppConstants.outlineButtonStyle.copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                  hexToColor('#FFEFD5'),
                                )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        product.unavailable != 1
                                            ? 'Mettre à jour le stock'
                                            : 'Activer le produit',
                                        style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (product.outStock == 0)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showstockSheet(context);

                                  // Logique pour "Annulé"

                                  /*   */
                                },
                                style: AppConstants.outlineButtonStyle.copyWith(
                                    side: MaterialStatePropertyAll(BorderSide(
                                        color: hexToColor('#F7F8FE'))),
                                    backgroundColor: MaterialStatePropertyAll(
                                      hexToColor('#C4C4C4'),
                                    ) // Couleur "Livré"
                                    ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text('Marqué Stock épuisé',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 96, 96, 96))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    /* boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.1), // Couleur de l'ombre légèrement sombre
                        spreadRadius: 1, // Diffusion légère
                        blurRadius: 2, // Flou doux pour un effet plus subtil
                        offset: const Offset(
                            0, 3), // Ombre en bas (aucun décalage horizontal)
                      ),
                    ], */
                  ),
                  child: Column(
                    children: [
                      SizedBox(child: Image.network(firstImage)),
                      // Horizontal ListView for other images
                      const SizedBox(
                        height: 10,
                      ),
                      if (otherImages.isNotEmpty)
                        SizedBox(
                          height:
                              100, // Height for the horizontal list of images
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: otherImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.network(
                                  otherImages[index],
                                  width: 100, // Width of each image
                                  height: 100, // Height of each image
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            product.name!,
                            style: AppConstants.headingTextStyle
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ),

                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 10),
                        child: Row(
                          children: [
                            const Text('Prix partenaire: ',
                                style: AppConstants.headingTextStyle),
                            Text(
                              '  ${product.price!.supplier} ${AppConstants.currency} ',
                              style: AppConstants.headingTextStyle
                                  .copyWith(color: Colors.orange),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 15, bottom: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Stock ${product.orderstock} / ${product.stock} Pieces ',
                                style: AppConstants.bodyTextStyle),
                            Text(
                              'N° ${product.code!}',
                              style: AppConstants.bodyTextStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
/*                   boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.1), // Couleur de l'ombre légèrement sombre
                      spreadRadius: 1, // Diffusion légère
                      blurRadius: 2, // Flou doux pour un effet plus subtil
                      offset: const Offset(
                          0, 3), // Ombre en bas (aucun décalage horizontal)
                    ),
                  ], */
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        ' CARACTÉRISTIQUES PRINCIPALES',
                        style: AppConstants.headingTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: product.description,
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              TextSpan(
                                text: product.subTitle,
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              TextSpan(
                                text: product.alias,
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  /* boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.1), // Couleur de l'ombre légèrement sombre
                      spreadRadius: 1, // Diffusion légère
                      blurRadius: 2, // Flou doux pour un effet plus subtil
                      offset: const Offset(
                          0, 3), // Ombre en bas (aucun décalage horizontal)
                    ),
                  ], */
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'INFORMATIONS',
                        style: AppConstants.headingTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Row(
                        children: [
                          const Text('Etat du produit : ',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text('${product.state!.name}',
                              style: AppConstants.bodyTextStyle
                                  .copyWith(color: Colors.orange)),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Taille du produit',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              product.sizes != null
                                  ? SizedBox(
                                      height: 28,
                                      width: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: product.sizes!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: AppConstants
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    product.sizes![index],
                                                    style: AppConstants
                                                        .bodyTextStyle,
                                                  )));
                                        },
                                      ),
                                    )
                                  : Text('RAS'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Couleur du produit ',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              product.colors != null
                                  ? SizedBox(
                                      height: 28,
                                      width: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: product.colors!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: AppConstants
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    product.colors![index],
                                                    style: AppConstants
                                                        .bodyTextStyle,
                                                  )));
                                        },
                                      ),
                                    )
                                  : Text('RAS')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.1), // Couleur de l'ombre légèrement sombre
                        spreadRadius: 1, // Diffusion légère
                        blurRadius: 2, // Flou doux pour un effet plus subtil
                        offset: const Offset(
                            0, 3), // Ombre en bas (aucun décalage horizontal)
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: formatDate(product.createdAt)),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showValidationSheet(BuildContext context, int? id) {
    final TextEditingController _stockController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('voulez vous vraiment marqué Cette commande  ?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      //controller.numeroWave.value = value;
                    },
                    keyboardType: TextInputType.number,
                    style: AppConstants.inputTextStyle,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: AppConstants.outlineButtonStyle,
                      child: const Text('Non',
                          style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.45, // Prendre toute la largeur
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "En cours"
                        Navigator.pop(context);
                      },
                      style: AppConstants.validateButtonStyle.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(
                            Colors.blue), // Couleur "En cours"
                      ),
                      child: const Text('OUI',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showstockSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Voulez-vous marquer Stock épuisé pour ce produit ?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      style: AppConstants.outlineButtonStyle,
                      child: const Text('Non',
                          style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.45, // Prendre toute la largeur
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "En cours"
                        final ProducttController productController = Get.find();
                        productController.stoksoutUpdate(product.id);
                        Navigator.pop(context);
                      },
                      style: AppConstants.validateButtonStyle.copyWith(
                        backgroundColor: const MaterialStatePropertyAll(
                            Colors.blue), // Couleur "En cours"
                      ),
                      child: const Text('OUI',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
