import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_images.dart';
import '../../../constants/constantApp.dart';
import '../../../constants/modules.dart';
import '../../../constants/styles.dart';
import '../../../controllers/commandeController.dart';
import '../../../controllers/rechargeController.dart';
import '../../../controllers/walletController.dart';
import '../commande/detailcommandeScreen.dart';
import '../commande/detailcommandeScreen2.dart';
import '../homeScreen.dart';
import 'retrait.dart';
import 'soldeDetail.dart';

class ComptatScreen extends StatefulWidget {
  const ComptatScreen({super.key});

  @override
  State<ComptatScreen> createState() => _ComptatScreenState();
}

class _ComptatScreenState extends State<ComptatScreen> {
  final WalletController walletController = Get.find<WalletController>();
  final RechargeController transController = Get.put(RechargeController());

  final OrderController orderController = Get.find<OrderController>();
  String year = DateFormat('y').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());
  String selectedFilter = 'Non soldés';
  String selectedFil = 'validated';
  int selectedComAp = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == 'depot') {
                Get.to(const SoldeDetail());
              } else {
                Get.to(const RetraitScreen());
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'depot',
                  child: Text('Recharger'),
                ),
                const PopupMenuItem(
                  value: 'retrait',
                  child: Text('Rétirer'),
                ),
              ];
            },
          ),
        ],
        leading: IconButton(
            onPressed: () => Get.to(HomeSreen()),
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: hexToColor('#0055FF'),
        title: Text(
          'Comptable',
          style: AppConstants.headingTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
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
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: hexToColor('#0055FF'),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Obx(() {
                      if (walletController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var wallet = walletController?.wallet?.value;
                      var dash = walletController?.dash?.value;
                      print("dash est $dash");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '${formatwallet.format(dash?.chiffreAffaire ?? 0) ?? 0}',
                                          style: AppConstants.headingTextStyle
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                        ),
                                        const TextSpan(
                                          text: AppConstants.currency,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        )
                                      ],
                                    )),
                                Text(
                                  'Chiffre d’affaires',
                                  style: AppConstants.bodyTextStyle
                                      .copyWith(fontSize: 10)
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  '${month.capitalizeFirst} $year',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 70,
                                    margin: const EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 0, 10, 143)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${formatwallet?.format(dash?.aSolder) ?? 0}',
                                                    style: AppConstants
                                                        .headingTextStyle
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                  ),
                                                  const TextSpan(
                                                    text: AppConstants.currency,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'A solder',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Aujourd’hui',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      filterButton('Non soldés', 'pending'),
                      filterButton('Soldés', 'validated'),
                      filterButton('Transaction', ''),
                      //filterButton('Annulé'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            selectedFilter == 'Transaction'
                ? Column(
                    children: [
                      Obx(() {
                        if (transController.waiting.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        var trans = transController.transaction.value
                            .where((transaction) =>
                                transaction.status == 'validated' &&
                                transaction.commande == null)
                            .toList();

                        if (trans.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 110),
                            child:
                                emptyMessage(' Pas de transaction disponible.'),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap:
                                true, // Important to limit the size of the list within the Column
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trans.length,
                            itemBuilder: (context, index) {
                              final transaction = trans[index];
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors
                                        .transparent, // Rendre le fond transparent pour personnaliser
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FractionallySizedBox(
                                        heightFactor:
                                            0.5, // Définit la hauteur à 70% de l'écran
                                        child: Stack(
                                          children: [
                                            // Fond blanc en bas
                                            Container(
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 234, 234, 234),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              margin: const EdgeInsets.only(
                                                  top:
                                                      70), // Ajuster pour faire apparaître le bleu en haut
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    // Ajout d'espacement pour laisser la place au Card au-dessus
                                                    SizedBox(height: 80),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Header bleu avec un cercle et un titre
                                            Container(
                                              height: 140,
                                              decoration: BoxDecoration(
                                                color: hexToColor('#0055FF'),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              child: const Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  // Titre
                                                  Positioned(
                                                    top: 10,
                                                    child: Text(
                                                      'Détails de la Transaction',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Card superposé sur le bleu
                                            Positioned(
                                              top: 80, // Chevauche le bleu
                                              left: 16,
                                              right: 16,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.1), // Couleur de l'ombre légèrement sombre
                                                      spreadRadius:
                                                          1, // Diffusion légère
                                                      blurRadius:
                                                          2, // Flou doux pour un effet plus subtil
                                                      offset: const Offset(0,
                                                          3), // Ombre en bas (aucun décalage horizontal)
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      const Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Wave',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .orange),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Statut: ',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${transaction.status!.capitalizeFirst}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .orange),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Montant: ',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          RichText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              text: TextSpan(
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: formatwallet
                                                                        .format(
                                                                            transaction.amount ??
                                                                                0),
                                                                    style: AppConstants
                                                                        .headingTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.blue,
                                                                            fontSize: 12),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        '${AppConstants.currency}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .blue),
                                                                  )
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Soldes apres transaction: ',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${walletController.wallet.value!.amount}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Date et heure: ',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${transaction.updatedAtFr}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'References: ',
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' ${transaction.reference}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Cercle partiellement caché
                                            Positioned(
                                              top: 55,
                                              right: 50,
                                              left: 50,
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      Images.wave,
                                                    ),
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
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
                                  child: ListTile(
                                    title: Text(
                                      transaction.category == 'recharge'
                                          ? 'Dépôt'
                                          : 'Retrait',
                                      style: AppConstants.bodyTextStyle,
                                    ),
                                    subtitle: Text(
                                      transaction.updatedAtFr,
                                      style: AppConstants.headingTextStyle
                                          .copyWith(fontSize: 12),
                                    ),
                                    leading: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(Images.wave),
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    trailing: Text(
                                      transaction.category == 'recharge'
                                          ? '+${transaction.amount ?? 0} ${AppConstants.currency}'
                                          : '-${transaction.amount ?? 0} ${AppConstants.currency}',
                                      style: AppConstants.headingTextStyle
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    ],
                  )
                : Obx(() {
                    if (transController.waiting.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var orders = transController.transaction.value
                        .where((transaction) =>
                            transaction.status == selectedFil &&
                            ["sale_admin", "sale_business"]
                                .contains(transaction.category))
                        .toList();

                    if (orders.isEmpty) {
                      return emptyMessage('Pas de commande disponible.');
                    }
                    String getOrderStatus(orders) {
                      if (orders.canceled?.date != null) {
                        return 'Commande annulée';
                      } else if (orders.received?.date != null) {
                        return 'Commande livrée';
                      } else if (orders.pending?.date != null) {
                        return 'Commande en cours';
                      } else if (orders.confirmed?.date != null) {
                        return 'Nouvelle commande';
                      } else {
                        return '';
                      }
                    }

                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap:
                              true, // Important to limit the size of the list within the Column
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];

                            final orderst = order.commande;
                            final items = order.commande!.items;
                            if (items == null || items.isEmpty) {
                              return const Center(
                                  child: Text('Pas d\'articles disponibles'));
                            }

                            // Affichage des items
                            return ListView.builder(
                              shrinkWrap:
                                  true, // Pour que la ListView prenne juste la place nécessaire
                              physics:
                                  const NeverScrollableScrollPhysics(), // Eviter le défilement interne
                              itemCount: items.length,
                              itemBuilder: (context, itemIndex) {
                                final item = items[itemIndex]; // L'item actuel

                                return GestureDetector(
                                  onTap: () => Get.to(DetailCommande2(
                                    order: orderst,
                                    item: item,
                                    titre: 'Commande livrée',
                                  )),
                                  child: comptableCard(
                                    "${item.product.name} ${orderst?.commissionApplied}" ??
                                        '',
                                    '${item.product.stock}', // Quantité d'items
                                    '${item.product.views}',
                                    '${item.product.shop!.city!.name}',
                                    item.product.images?.isNotEmpty == true
                                        ? item.product.images!.first
                                        : 'https://www.lascom.com/wp-content/uploads/2021/03/Bland_Cosmetic_Product_Packaging_Unit_500x400.jpg',
                                    '${formatCustomDate(order.commande!.createdAtFr)} à ${order.commande!.delivery!.time.substring(0, 5)}',
                                    (item.price ?? 0) -
                                        (item.product.price!.price ?? 0) +
                                        (item.product.price?.partner ?? 0),
                                    // Exemples de temps fixe ou dynamique
                                    '${item.total}',
                                    '${item.product.code ?? 0}', // Prix total ou ajusté
                                    selectedFil == 'pending'
                                        ? ' A SOLDER'
                                        : 'Soldé',
                                    () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FractionallySizedBox(
                                            heightFactor:
                                                0.9, // Définit la hauteur comme 90% de la taille de l'écran
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: selectedFil ==
                                                              'pending'
                                                          ? hexToColor(
                                                              '#FFEBF7')
                                                          : const Color
                                                              .fromARGB(255, 35,
                                                              197, 119),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.pink
                                                              .withOpacity(
                                                                  0.1), // Couleur de l'ombre légèrement sombre
                                                          spreadRadius:
                                                              1, // Diffusion légère
                                                          blurRadius:
                                                              2, // Flou doux pour un effet plus subtil
                                                          offset: const Offset(
                                                              0,
                                                              3), // Ombre en bas (aucun décalage horizontal)
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      selectedFil == 'pending'
                                                          ? 'SOLDER'
                                                          : 'Soldé',
                                                      style: AppConstants
                                                          .headingTextStyle
                                                          .copyWith(
                                                              color: selectedFil ==
                                                                      'pending'
                                                                  ? Colors.pink
                                                                  : Colors
                                                                      .white,
                                                              fontSize: 18),
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      children: [
                                                        produitCarddetail(
                                                            '${item.product.name}',
                                                            '${item.product.orderstock}/ ${item.product.stock}',
                                                            '${item.product.views}',
                                                            item.product.images!
                                                                .first,
                                                            '${item.price}',
                                                            '${order.commande!.delivery!.date},${order.commande!.delivery!.time.substring(0, 2)}h',
                                                            '${item.product.code}',
                                                            'Information générale',
                                                            () {
                                                          Get.to(
                                                              DetailCommande2(
                                                            order: orderst,
                                                            item: item,
                                                            titre:
                                                                'Commande validée',
                                                          ));
                                                        }),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // const Text(
                                                                  //   'Prix partenaire',
                                                                  //   style: AppConstants
                                                                  //       .bodyTextStyle,
                                                                  // ),
                                                                  // Text(
                                                                  //   '${item.product.price!.partner}  ${AppConstants.currency} ',
                                                                  //   style: AppConstants
                                                                  //       .headingTextStyle,
                                                                  // ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  const Text(
                                                                    'Prix de vente ',
                                                                    style: AppConstants
                                                                        .bodyTextStyle,
                                                                  ),
                                                                  Text(
                                                                    '${item.product.price!.price}  ${AppConstants.currency}',
                                                                    style: AppConstants
                                                                        .headingTextStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  const Text(
                                                                    'Frais de livraison',
                                                                    style: AppConstants
                                                                        .bodyTextStyle,
                                                                  ),
                                                                  Text(
                                                                    '${item.totalfees}  ${AppConstants.currency} ',
                                                                    style: AppConstants
                                                                        .headingTextStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  const Text(
                                                                    'Total payé',
                                                                    style: AppConstants
                                                                        .bodyTextStyle,
                                                                  ),
                                                                  Text(
                                                                    '${item.total} ${AppConstants.currency}',
                                                                    style: AppConstants
                                                                        .headingTextStyle,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  const Text(
                                                                    'Commission Daymond ',
                                                                    style: AppConstants
                                                                        .bodyTextStyle,
                                                                  ),
                                                                  Text(
                                                                    '${item.product.price!.partner}  ${AppConstants.currency} ',
                                                                    style: AppConstants
                                                                        .headingTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.orange),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 70,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (selectedFil ==
                                                            'pending')
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                if (walletController
                                                                        .wallet
                                                                        .value!
                                                                        .totalAmount! >
                                                                    (item
                                                                        .product
                                                                        .price
                                                                        ?.partner as num)) {
                                                                  transController.submitsolder(
                                                                      order.id,
                                                                      (item.price ?? 0) -
                                                                          (item.product.price!.price ??
                                                                              0) +
                                                                          (item.product.price?.partner ??
                                                                              0));
                                                                } else {
                                                                  EasyLoading
                                                                      .showError(
                                                                          'Solde insuffisant');
                                                                }
                                                              },
                                                              style: AppConstants
                                                                  .validateButtonStyle,
                                                              child: const Text(
                                                                  'Solder',
                                                                  style: AppConstants
                                                                      .buttonTextStyle),
                                                            ),
                                                          ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        if (selectedFil ==
                                                            'pending')
                                                          if (walletController
                                                                  .wallet
                                                                  .value!
                                                                  .totalAmount! <
                                                              (item.price
                                                                  as num))
                                                            Text(
                                                              'Solde insuffisant ',
                                                              style: AppConstants
                                                                  .bodyTextStyle
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  })
          ],
        ),
      ),
    );
  }

  Widget filterButton(String status, String apiStatus) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFilter = status;
          selectedFil = apiStatus;
          // selectedComAp = commissionApp;
          // Update the selected filter
        });
      },
      child: Column(
        children: [
          Text(
            status,
            style: TextStyle(
              color: selectedFilter == status ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          selectedFilter == status
              ? Container(
                  height: 5,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue))
              : Container()
        ],
      ),
    );
  }
}
