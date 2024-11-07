import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constantApp.dart';
import '../../../constants/modules.dart';
import '../../../controllers/commandeController.dart';
import '../../../models/commandemodels.dart';
import '../../../models/order_table.dart';

class DetailCommande2 extends StatefulWidget {
  final Order? order;
  final OrderItem item;
  final String titre;
  const DetailCommande2(
      {super.key,
      required this.order,
      required this.item,
      required this.titre});

  @override
  State<DetailCommande2> createState() => _DetailCommande2State();
}

class _DetailCommande2State extends State<DetailCommande2> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.titre.capitalizeFirst}',
          style: AppConstants.headingTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCustomDate(widget.order!.createdAtFr),
                  style: AppConstants.bodyTextStyle.copyWith(fontSize: 11),
                ),
                Text(
                  widget.order!.delivery!.time.substring(0, 5),
                  style: AppConstants.bodyTextStyle.copyWith(fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: OutlinedButton(
              onPressed: () {
                // Afficher le modal
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {
                    return FractionallySizedBox(
                        heightFactor:
                            0.8, // Définit la hauteur à 70% de l'écran
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Row avec l'image du produit et le nom
                                Container(
                                    height: 5,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey)),
                                Row(
                                  children: [
                                    Image.network(
                                      widget.item.product.images!
                                          .first, // URL de l'image du produit
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'TYPE DE LIVRAISON',
                                          style: AppConstants.headingTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'A domicile',
                                          style: AppConstants.bodyTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${widget.item.product.code}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Bande verticale avec les états de la commande
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          widget.order!.canceled?.date != null
                                              ? Icons.close
                                              : widget.order!.confirmed?.date !=
                                                      null
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                          color: widget.order!.canceled?.date !=
                                                  null
                                              ? Colors.red
                                              : widget.order!.confirmed?.date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        Container(
                                          width: 2,
                                          height: 70,
                                          color: widget.order!.canceled?.date !=
                                                  null
                                              ? Colors.red
                                              : widget.order!.confirmed?.date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        Icon(
                                          // Si la commande est annulée, afficher l'icône "close" en rouge
                                          widget.order!.canceled!.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Icons.close
                                              // Sinon, afficher l'icône en fonction de l'état "pending"
                                              : widget.order!.pending!.date !=
                                                      null
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                          color: widget.order!.canceled?.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Colors.red
                                              // Si la commande n'est pas annulée, afficher en fonction de l'état "pending"
                                              : widget.order!.pending!.date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        Container(
                                          width: 2,
                                          height: 70,
                                          // Si la commande est annulée, la couleur devient rouge
                                          color: widget.order!.canceled!.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Colors.red
                                              // Sinon, afficher la couleur selon l'état "pending"
                                              : widget.order!.pending!.date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        Icon(
                                          // Si la commande est annulée, afficher l'icône "close" en rouge
                                          widget.order!.canceled!.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Icons.close
                                              // Sinon, afficher l'icône en fonction de l'état "pending"
                                              : widget.order!.inProgress!
                                                          .date !=
                                                      null
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                          color: widget.order!.canceled?.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Colors.red
                                              // Si la commande n'est pas annulée, afficher en fonction de l'état "pending"
                                              : widget.order!.inProgress!
                                                          .date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        Container(
                                          width: 2,
                                          height: 75,
                                          color: widget.order!.canceled?.date !=
                                                  null
                                              ? Colors
                                                  .red // Si la commande est annulée, couleur grise
                                              : widget.order!.inProgress
                                                          ?.date !=
                                                      null
                                                  ? Colors
                                                      .green // Si la commande est en attente, couleur verte
                                                  : Colors.grey,
                                        ),
                                        Icon(
                                          // Si la commande est annulée, afficher l'icône "close" en rouge
                                          widget.order!.canceled!.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Icons.close
                                              // Sinon, afficher l'icône en fonction de l'état "pending"
                                              : widget.order!.validated!.date !=
                                                      null
                                                  ? Icons.check_circle
                                                  : Icons.check_circle_outline,
                                          color: widget.order!.canceled?.date !=
                                                      null &&
                                                  parseDate(widget.order!
                                                          .canceled!.date!) !=
                                                      null
                                              ? Colors.red
                                              // Si la commande n'est pas annulée, afficher en fonction de l'état "pending"
                                              : widget.order!.validated!.date !=
                                                      null
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    // Les descriptions des étapes
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nouvelle commande',
                                              style: TextStyle(
                                                color: widget.order!.canceled
                                                            ?.date !=
                                                        null
                                                    ? Colors
                                                        .red // Si la commande est annulée, couleur grise
                                                    : widget.order!.confirmed
                                                                ?.date !=
                                                            null
                                                        ? Colors
                                                            .green // Si la commande est en attente, couleur verte
                                                        : Colors.grey,
                                              ),
                                            ),
                                            if (widget.order!.confirmed?.date !=
                                                null)
                                              Text(
                                                '${formatCustomDate(widget.order!.confirmed!.date) ?? ''} à ${widget.order!.confirmed!.time!.substring(0, 5) ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Colors
                                                          .red // Si la commande est annulée, couleur grise
                                                      : widget.order!.confirmed
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .green // Si la commande est en attente, couleur verte
                                                          : Colors.black,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 66),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'En attente',
                                              style: TextStyle(
                                                color: widget.order!.canceled
                                                            ?.date !=
                                                        null
                                                    ? Colors
                                                        .red // Si la commande est annulée, couleur grise
                                                    : widget.order!.pending
                                                                ?.date !=
                                                            null
                                                        ? Colors
                                                            .green // Si la commande est en attente, couleur verte
                                                        : Colors.grey,
                                              ),
                                            ),
                                            if (widget.order!.pending?.date !=
                                                null)
                                              Text(
                                                '${formatCustomDate(widget.order!.pending!.date) ?? ''} à ${widget.order!.pending!.time!.substring(0, 5) ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Colors
                                                          .red // Si la commande est annulée, couleur grise
                                                      : widget.order!.pending
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .green // Si la commande est en attente, couleur verte
                                                          : Colors.black,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 66),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'En cours de livraison',
                                              style: TextStyle(
                                                color: widget.order!.canceled
                                                            ?.date !=
                                                        null
                                                    ? Colors
                                                        .red // Si la commande est annulée, couleur grise
                                                    : widget.order!.inProgress
                                                                ?.date !=
                                                            null
                                                        ? Colors
                                                            .green // Si la commande est en attente, couleur verte
                                                        : Colors.grey,
                                              ),
                                            ),
                                            if (widget
                                                    .order!.inProgress?.date !=
                                                null)
                                              Text(
                                                '${formatCustomDate(widget.order!.inProgress!.date) ?? ''} à ${widget.order!.inProgress!.time!.substring(0, 5) ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Colors
                                                          .red // Si la commande est annulée, couleur grise
                                                      : widget.order!.inProgress
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .green // Si la commande est en attente, couleur verte
                                                          : Colors.black,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 63),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Livrée',
                                              style: TextStyle(
                                                color: widget.order!.canceled
                                                            ?.date !=
                                                        null
                                                    ? Colors
                                                        .red // Si la commande est annulée, couleur grise
                                                    : widget.order!.validated
                                                                ?.date !=
                                                            null
                                                        ? Colors
                                                            .green // Si la commande est en attente, couleur verte
                                                        : Colors.grey,
                                              ),
                                            ),
                                            if (widget.order!.validated?.date !=
                                                null)
                                              Text(
                                                '${formatCustomDate(widget.order!.validated!.date) ?? ''} à ${widget.order!.validated!.time!.substring(0, 5) ?? ''}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Colors
                                                          .red // Si la commande est annulée, couleur grise
                                                      : widget.order!.validated
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .green // Si la commande est en attente, couleur verte
                                                          : Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                );
              },
              style: AppConstants.outlineButtonStyle.copyWith(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              child: Text('Suivi des commandes',
                  style: AppConstants.bodyTextStyle
                      .copyWith(color: AppConstants.buttonColor)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            child: ElevatedButton(
              onPressed: () {
                // Afficher le modal
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
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
                            style: AppConstants.bodyTextStyle,
                          ),
                          const SizedBox(height: 20),

                          // Condition pour "Commande en cours"
                          if (widget.titre.trim().toLowerCase() !=
                              'commande en cours'.toLowerCase())
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logique pour "En cours"
                                  Navigator.pop(context);
                                  _showValidationSheet(context, "in_progress");
                                },
                                style:
                                    AppConstants.validateButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.blue),
                                ),
                                child: const Text('En cours de livraison',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),

                          const SizedBox(height: 10),

                          // Condition pour "Commande livrée"
                          if (widget.titre.trim().toLowerCase() !=
                              'commande livrée'.toLowerCase())
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logique pour "Livré"
                                  Navigator.pop(context);
                                  _showValidationSheet(context, "validated");
                                },
                                style:
                                    AppConstants.validateButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.green),
                                ),
                                child: const Text('commande Livrées',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),

                          const SizedBox(height: 10),

                          // Condition pour "Commande en attente"
                          if (widget.titre.trim().toLowerCase() !=
                              'commande en attente'.toLowerCase())
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logique pour "En attente"
                                  Navigator.pop(context);
                                  _showValidationSheet(context, "pending");
                                },
                                style:
                                    AppConstants.validateButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Color.fromARGB(255, 175, 12, 129)),
                                ),
                                child: const Text('commande En attente',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),

                          const SizedBox(height: 10),

                          // Condition pour "Commande annulée"
                          if (widget.titre.trim().toLowerCase() !=
                              'commande annulée'.toLowerCase())
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Logique pour "Annulé"
                                  Navigator.pop(context);
                                  _showCancellationFormSheet(context);
                                },
                                style:
                                    AppConstants.validateButtonStyle.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.red),
                                ),
                                child: const Text('commande Annulées',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: AppConstants.validateButtonStyle,
              child: const Text('Changer le Statut',
                  style: AppConstants.buttonTextStyle),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            produitCarddetail(
                '${widget.item.product.name}',
                '${widget.item.product.orderstock}/${widget.item.product.stock}',
                '${widget.item.product.views}',
                widget.item.product.images!.first,
                '${widget.item.product.price!.price}',
                '',
                widget.item.reference,
                '',
                () {}),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  /*   boxShadow: [
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
                      Text(
                        'Detail de la commande',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Couleur'),
                          widget.item.product.colors != null
                              ? SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.item.product.colors!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppConstants
                                                      .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                widget.item.product
                                                    .colors![index],
                                                style:
                                                    AppConstants.bodyTextStyle,
                                              )));
                                    },
                                  ),
                                )
                              : Text('RAS',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantité'),
                          Text('${widget.item.quantity} Pièces'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Prix',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                          Text(
                              '${widget.item.totalproduct} ${AppConstants.currency}',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Livraison'),
                          Text(
                              '${widget.item.totalfees} ${AppConstants.currency}'),
                        ],
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('A payer',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                          Text('${widget.item.total} ${AppConstants.currency}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  /*  boxShadow: [
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
                        'Detail de la livraison',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Nom',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(widget.order!.client?.name ?? '',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Livraison',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text('${widget.order!.delivery!.city!.name}',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contact 1',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(widget.order!.client?.phoneNumber ?? 'aucun',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contact 2',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                  widget.order!.client?.phoneNumber2 ?? 'aucun',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Date de Livraison ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                  formatCustomDate(
                                      widget.order!.delivery!.date),
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Heure de Livraison',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                  '${widget.order!.delivery!.time.substring(0, 5)}',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  /*  boxShadow: [
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
                      Text(
                        'autre details',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('RAS')),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showValidationSheet(BuildContext context, String status) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: Text(
                  'voulez vous vraiment changer le status de cette commande?',
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: AppConstants.outlineButtonStyle.copyWith(
                        side: MaterialStatePropertyAll(
                            BorderSide(color: Colors.blue)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      child: const Text('Non',
                          style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.4, // Prendre toute la largeur
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "En cours"
                        orderController.updateOrderStatus(
                            widget.order!.id, status, '');
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

// Fonction pour afficher le formulaire d'annulation
  void _showCancellationFormSheet(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
    String selectedOption = 'Produit non conforme aux attentes.';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      items: <String>[
                        'Produit non conforme aux attentes.',
                        "Changement d'avis sur le produit.",
                        'Trouvé un meilleur prix ailleurs.',
                        'Délai de livraison trop long .',
                        'Problème de paiement.',
                        'Incompatibilité du produit avec leurs besoins.'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    maxLines: 4,
                    controller: reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Motif d\'annulation',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: AppConstants.cancelButtonStyle,
                      onPressed: () {
                        orderController.updateOrderStatus(
                            widget.order!.id,
                            'canceled',
                            selectedOption ?? reasonController.text);
                        // Logique pour envoyer l'annulation
                        // Utiliser 'selectedOption' et 'reasonController.text' ici
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Envoyer',
                        style: AppConstants.buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
