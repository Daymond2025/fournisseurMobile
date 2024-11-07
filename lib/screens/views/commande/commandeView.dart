import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constants/constantApp.dart';
import '../../../constants/modules.dart';
import '../../../constants/styles.dart';
import '../../../controllers/commandeController.dart';
import '../../../models/order_table.dart';
import '../detailNeworderScreen.dart';
import '../homeScreen.dart';
import 'detailcommandeScreen.dart';
import 'detailcommandeScreen2.dart';
import 'paginationcommande.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  String selectedFilter = 'pending';
  String selectedFil = 'En attente';
  //late Future<List<Order>> futureOrders; // Future pour stocker les commandes
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.to(HomeSreen()),
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.white,
          title: const Text(
            'Commandes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        body: Column(
          children: [
            // Filtre pour changer l'état des commandes récupérées
            Container(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    filterButton('En attente', 'pending'),
                    filterButton('En cours', 'in_progress'),
                    filterButton('Livrée', 'validated'),
                    filterButton('Annulée', 'canceled'),
                  ],
                ),
              ),
            ),

            // Utilisation de FutureBuilder pour récupérer et afficher les commandes
            Expanded(
              child: Obx(
                () {
                  if (orderController.iswaiting.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Récupération et filtrage des commandes
                  final filteredOrders = orderController.orderList
                      .where((order) => order.status == '$selectedFilter')
                      .toList();
                  if (filteredOrders.isEmpty) {
                    return emptyMessage('Pas de Commande disponibles');
                  }

                  return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      final items = order.items;

                      if (items == null || items.isEmpty) {
                        return const Center(
                            child: Text('Pas d\'articles disponibles'));
                      }

                      // Affichage des items récupérés
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = items[itemIndex];

                            return produitCard(
                              item.product.name ?? '',
                              '${item.product.orderstock ?? 0}',
                              '${item.product.totalstock ?? 0} ',
                              '${order.delivery!.city!.name}',
                              item.product.images?.isNotEmpty == true
                                  ? item.product.images!.first
                                  : 'https://www.lascom.com/wp-content/uploads/2021/03/Bland_Cosmetic_Product_Packaging_Unit_500x400.jpg',
                              '${formatCustomDate(order.delivery!.date)},${order.delivery!.time.substring(0, 5)}',
                              '${item.product.price?.price ?? 0} ',
                              'Commande $selectedFil',
                              'Voir les détails',
                              () {
                                Get.to(DetailCommande2(
                                    order: order,
                                    item: item,
                                    titre: 'Commande ${selectedFil}'));
                              },
                            );
                          },
                          key: ValueKey(order.id));
                    },
                  );
                },
              ),
            ),
            PaginationorderWidget(
              currentPage: orderController.currentPage.value,
              lastPage: orderController.lastPage.value,
              onPageChanged: (page) {
                orderController.goToPage(page);
              },
            ),
          ],
        ));
  }

  // Bouton de filtre qui fait appel à la méthode de récupération avec le bon statut
  Widget filterButton(String statusText, String apiStatus) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFil = statusText;
          selectedFilter = apiStatus;
          // Mettre à jour le Future avec le nouveau filtre
        });
        print('object$apiStatus');
      },
      child: Text(
        statusText,
        style: TextStyle(
          color: selectedFilter == apiStatus ? Colors.orange : Colors.grey,
        ),
      ),
    );
  }
}
