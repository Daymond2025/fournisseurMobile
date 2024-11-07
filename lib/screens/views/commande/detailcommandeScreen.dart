import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constantApp.dart';
import '../../../constants/modules.dart';
import '../../../controllers/commandeController.dart';
import '../../../models/commandemodels.dart';
import '../../../models/order_table.dart';

class DetailCommande extends StatefulWidget {
  final Order? order;
  final OrderItem item;
  final String titre;
  const DetailCommande(
      {super.key,
      required this.order,
      required this.item,
      required this.titre});

  @override
  State<DetailCommande> createState() => _DetailCommandeState();
}

class _DetailCommandeState extends State<DetailCommande> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 114, 114, 114),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 148, 148),
        title: Text(
          '${widget.titre.capitalizeFirst}',
          style: AppConstants.headingTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            produitCarddetail(
                '${widget.item.product.name}',
                '${widget.item.product.stock}',
                '${widget.item.product.views}',
                widget.item.product.images!.first,
                '${widget.item.product.price!.price}',
                '${widget.order!.delivery!.time.substring(0, 2)}h',
                widget.item.reference,
                '',
                () {}),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 240, 237, 237),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Detail de la commande',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Couleur'),
                          Text('Noir',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('quantité'),
                          Text('${widget.item.quantity} pièces'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('prix',
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
                      Divider(),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Detail de la livraison',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(),
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
                              Text('Date de Livraison ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text('${widget.order!.delivery!.date}',
                                  style: AppConstants.bodyTextStyle),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Heure de Livraison',
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
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        'autre details',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(),
                      Text('data')
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: OutlinedButton(
                    onPressed: () {
                      // Afficher le modal
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                              const Text(
                                                'TYPE DE LIVRAISON',
                                                style: AppConstants
                                                    .headingTextStyle,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'A domicile',
                                                style:
                                                    AppConstants.bodyTextStyle,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${widget.item.product.code}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),

                                      // Bande verticale avec les états de la commande
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              // Cercle avec la première étape (ex: Commande passée)
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Icons
                                                          .check_circle_outline
                                                      : Icons.close,
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
                                                          : Colors
                                                              .grey, // Couleur selon l'état atteint
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                height: 75,
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
                                                        : Colors
                                                            .grey, // Bande atteinte
                                              ),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Icons
                                                          .check_circle_outline
                                                      : Icons.close,
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
                                                          : Colors
                                                              .grey, // Sinon, couleur rouge pour les autres cas
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                height: 75,
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
                                                        : Colors
                                                            .grey, // Bande non atteinte
                                              ),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Icons
                                                          .check_circle_outline
                                                      : Icons.close,
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
                                              Container(
                                                width: 2,
                                                height: 75,
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

                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  widget.order!.canceled
                                                              ?.date !=
                                                          null
                                                      ? Icons
                                                          .check_circle_outline
                                                      : Icons.close,
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
                                                      color: widget
                                                                  .order!
                                                                  .canceled
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .red // Si la commande est annulée, couleur grise
                                                          : widget
                                                                      .order!
                                                                      .confirmed
                                                                      ?.date !=
                                                                  null
                                                              ? Colors
                                                                  .green // Si la commande est en attente, couleur verte
                                                              : Colors.grey,
                                                    ),
                                                  ),
                                                  if (widget.order!.confirmed
                                                          ?.date !=
                                                      null)
                                                    Text(
                                                      '${widget.order!.confirmed!.date ?? ''} à ${widget.order!.confirmed!.time!.substring(0, 5) ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: widget
                                                                    .order!
                                                                    .canceled
                                                                    ?.date !=
                                                                null
                                                            ? Colors
                                                                .red // Si la commande est annulée, couleur grise
                                                            : widget
                                                                        .order!
                                                                        .confirmed
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
                                                      color: widget
                                                                  .order!
                                                                  .canceled
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .red // Si la commande est annulée, couleur grise
                                                          : widget
                                                                      .order!
                                                                      .pending
                                                                      ?.date !=
                                                                  null
                                                              ? Colors
                                                                  .green // Si la commande est en attente, couleur verte
                                                              : Colors.grey,
                                                    ),
                                                  ),
                                                  if (widget.order!.pending
                                                          ?.date !=
                                                      null)
                                                    Text(
                                                      '${widget.order!.pending!.date ?? ''} à ${widget.order!.pending!.time!.substring(0, 5) ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: widget
                                                                    .order!
                                                                    .canceled
                                                                    ?.date !=
                                                                null
                                                            ? Colors
                                                                .red // Si la commande est annulée, couleur grise
                                                            : widget
                                                                        .order!
                                                                        .pending
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
                                                      color: widget
                                                                  .order!
                                                                  .canceled
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .red // Si la commande est annulée, couleur grise
                                                          : widget
                                                                      .order!
                                                                      .inProgress
                                                                      ?.date !=
                                                                  null
                                                              ? Colors
                                                                  .green // Si la commande est en attente, couleur verte
                                                              : Colors.grey,
                                                    ),
                                                  ),
                                                  if (widget.order!.inProgress
                                                          ?.date !=
                                                      null)
                                                    Text(
                                                      '${widget.order!.inProgress!.date ?? ''} à ${widget.order!.inProgress!.time!.substring(0, 5) ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: widget
                                                                    .order!
                                                                    .canceled
                                                                    ?.date !=
                                                                null
                                                            ? Colors
                                                                .red // Si la commande est annulée, couleur grise
                                                            : widget
                                                                        .order!
                                                                        .inProgress
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
                                                      color: widget
                                                                  .order!
                                                                  .canceled
                                                                  ?.date !=
                                                              null
                                                          ? Colors
                                                              .red // Si la commande est annulée, couleur grise
                                                          : widget
                                                                      .order!
                                                                      .validated
                                                                      ?.date !=
                                                                  null
                                                              ? Colors
                                                                  .green // Si la commande est en attente, couleur verte
                                                              : Colors.grey,
                                                    ),
                                                  ),
                                                  if (widget.order!.validated
                                                          ?.date !=
                                                      null)
                                                    Text(
                                                      '${widget.order!.validated!.date ?? ''} à ${widget.order!.validated!.time!.substring(0, 5) ?? ''}',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: widget
                                                                    .order!
                                                                    .canceled
                                                                    ?.date !=
                                                                null
                                                            ? Colors
                                                                .red // Si la commande est annulée, couleur grise
                                                            : widget
                                                                        .order!
                                                                        .validated
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
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                    child: const Text('Suivi des commandes',
                        style: TextStyle(fontSize: 16, color: Colors.orange)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {
                      // Afficher le modal
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Changer le Statut',
                                  style: AppConstants.bodyTextStyle,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double
                                      .infinity, // Prendre toute la largeur
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Logique pour "En cours"
                                      Navigator.pop(context);
                                      _showValidationSheet(
                                          context, "in_progress");
                                    },
                                    style: AppConstants.validateButtonStyle
                                        .copyWith(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(Colors
                                              .blue), // Couleur "En cours"
                                    ),
                                    child: const Text('En cours de livraison',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Logique pour "Livré"
                                      Navigator.pop(context);
                                      _showValidationSheet(
                                          context, "validated");
                                    },
                                    style: AppConstants.validateButtonStyle
                                        .copyWith(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.green), // Couleur "Livré"
                                    ),
                                    child: const Text('commande Livrées',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Logique pour "En attente"
                                      Navigator.pop(context);
                                      _showValidationSheet(context, "pending");
                                    },
                                    style: AppConstants.validateButtonStyle
                                        .copyWith(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Color.fromARGB(255, 175, 12,
                                                  129)), // Couleur "En attente"
                                    ),
                                    child: const Text('commande En attente',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Logique pour "Annulé"
                                      Navigator.pop(context);
                                      _showCancellationFormSheet(
                                        context,
                                      );
                                    },
                                    style: AppConstants.validateButtonStyle
                                        .copyWith(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.red), // Couleur "Annulé"
                                    ),
                                    child: const Text('commande Annulées ',
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
            )
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'voulez vous vraiment changer le status de cette commande   ?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: OutlinedButton(
                      onPressed: () {},
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
                        'Produit endommagé',
                        'Incompatible avec leurs besoins'
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
