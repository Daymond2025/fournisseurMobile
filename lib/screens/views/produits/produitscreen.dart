import 'dart:convert';

import 'package:daymond_dis/screens/newScreens/creationproduit/creation_produit_widget.dart';
import 'package:daymond_dis/screens/views/commande/paginationcommande.dart';
import 'package:daymond_dis/screens/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/app_images.dart';
import '../../../constants/constantApp.dart';
import '../../../constants/modules.dart';
import '../../../constants/styles.dart';
import '../../../controllers/productController.dart';
import '../pagination_widget.dart';
import 'Addproduitform.dart';
import 'produitDetailinfo.dart';

class ProduitScreen extends StatefulWidget {
  const ProduitScreen({super.key});

  @override
  State<ProduitScreen> createState() => _ProduitScreenState();
}

class _ProduitScreenState extends State<ProduitScreen> {
  String selectedFilter = 'En stock';
  final ProductController productController = Get.put(ProductController());
  final ProducttController product2Controller = Get.put(ProducttController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product2Controller.fetchProducts(product2Controller.currentPage.value);
  }

  @override
  void didUpdateWidget(covariant ProduitScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    product2Controller.fetchProducts(product2Controller.currentPage.value);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppConstants.backgroundColor,
      onRefresh: () async {
        product2Controller.fetchProducts(product2Controller.currentPage.value);
      },
      child: Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Get.to(HomeSreen()),
              icon: Icon(Icons.arrow_back)),
          title: const Text(
            'Produits',
            style: AppConstants.headingTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const CreationProduitWidget());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue),
                                  color: hexToColor('#F7F8FE')),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Images.produits,
                                      height: 30,
                                    ),
                                    const SizedBox(width: 20),
                                    const Text(
                                      'Ajouter un produit',
                                      style: AppConstants.bodyTextStyle,
                                    ),
                                    const Spacer(),
                                    Image.asset(Images.add),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              filterButton('En stock'),
                              filterButton('Stock épuisés'),
                              filterButton('Inactif'),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredProducts =
                      product2Controller.productList.where((product) {
                    if (selectedFilter == 'En stock') {
                      return product.outStock == 0 && product.unavailable == 0;
                    } else if (selectedFilter == 'Stock épuisés') {
                      return product.outStock == 1 && product.unavailable == 0;
                    } else if (selectedFilter == 'Inactif') {
                      return product.unavailable == 1;
                    }
                    return true;
                  }).toList();
                  if (filteredProducts.isEmpty) {
                    return emptyMessage('Pas de produit disponibles');
                  }

                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.97,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        // Vérifiez si l'index est valide
                        if (index < 0 || index >= filteredProducts.length) {
                          return const SizedBox(); // Renvoie un widget vide si l'index est invalide
                        }

                        final product = filteredProducts[index];

                        // Vérifiez si product a la structure attendue
                        if (product == null ||
                            product.images == null ||
                            product.price == null) {
                          return emptyMessage(
                              'Pas de produit disponibles'); // Renvoie un widget vide si product est mal formé
                        }

                        final firstImage = product.images!.isNotEmpty
                            ? product.images!.first
                            : 'https://lasagadesaudacieux.com/wp-content/uploads/2021/07/produit.jpg';

                        return InkWell(
                          onTap: () {
                            Get.to(() => ProduitDetailInfo(product: product));
                          },
                          child: produitCard(
                            firstImage,
                            product.publish == 1 ? 'En vente' : 'Non en vente',
                            product.name ?? '',
                            product.price!.price != null
                                ? product.price!.price.toString()
                                : '0',
                            product.stock != null
                                ? product.orderstock.toString()
                                : '0',
                            product.views != null
                                ? product.stock.toString()
                                : '0',
                            product.shop!.business!.logo!,
                          ),
                        );
                      },
                    ),
                  );
                }),
                const SizedBox(height: 20),
                if (product2Controller.productList.length > 20)
                  PaginationorderWidget(
                    currentPage: product2Controller.currentPage.value,
                    lastPage: product2Controller.lastPage.value,
                    onPageChanged: (page) {
                      product2Controller.goToPage(page);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterButton(String status) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFilter = status;
        });
      },
      child: Text(
        status,
        style: TextStyle(
          color: selectedFilter == status ? Colors.orange : Colors.grey,
        ),
      ),
    );
  }

  Widget produitCard(
    String imageUrl,
    String status,
    String title,
    String price,
    String stock,
    String totalStock,
    String logoUrl,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: status == 'En vente'
                        ? Colors.green
                        : const Color.fromARGB(255, 220, 99, 99),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.length <= 14 ? title : '${title.substring(0, 14)}...',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$price ${AppConstants.currency}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock: $stock / $totalStock',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      ClipRRect(
                        child: Image.network(
                          logoUrl,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      )
                      // SizedBox(
                      //   child: Image.network(
                      //     logoUrl,
                      //     width: 25,
                      //     height: 25,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
