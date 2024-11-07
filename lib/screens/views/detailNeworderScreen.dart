import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constantApp.dart';
import '../../constants/modules.dart';
import '../../controllers/commandeController.dart';
import '../../models/commandemodels.dart';
import '../../models/order_table.dart';

class CommandHome extends StatefulWidget {
  final Order command;
  final OrderItem items;
  final String titre;
  const CommandHome(
      {super.key,
      required this.command,
      required this.items,
      required this.titre});

  @override
  State<CommandHome> createState() => _CommandHomeState();
}

class _CommandHomeState extends State<CommandHome> {
  final OrderController cmdeControkler = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  formatCustomDate(widget.command.createdAtFr),
                  style: AppConstants.bodyTextStyle.copyWith(fontSize: 11),
                ),
                Text(
                  widget.command.delivery!.time.substring(0, 5),
                  style: AppConstants.bodyTextStyle.copyWith(fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            child: OutlinedButton(
              onPressed: () {},
              style: AppConstants.outlineButtonStyle.copyWith(
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              child: const Text('Imprimer une facture',
                  style: TextStyle(fontSize: 13, color: Colors.orange)),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Changer le Statut',
                            style: AppConstants.bodyTextStyle,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _showValidationSheet(
                                    context, "En cours de livraison");
                              },
                              style: AppConstants.validateButtonStyle.copyWith(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.blue),
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
                                Navigator.pop(context);
                                _showValidationSheet(
                                    context, "commande Livrées");
                              },
                              style: AppConstants.validateButtonStyle.copyWith(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.green),
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
                                Navigator.pop(context);
                                _showValidationSheet(
                                    context, "commande En attente");
                              },
                              style: AppConstants.validateButtonStyle.copyWith(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 175, 12, 129)),
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
                                Navigator.pop(context);
                                _showCancellationFormSheet(context);
                              },
                              style: AppConstants.validateButtonStyle.copyWith(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.red),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            produitCarddetail(
                '${widget.items.product.name}',
                '${widget.items.product.orderstock}/${widget.items.product.stock}',
                '${widget.items.product.views}',
                widget.items.product.images!.first,
                //timeFormatter.format(widget.command.createdate!.hour as DateTime),
                '${widget.items.product.price!.price} ',
                '${widget.command.confirmed!.date}, ${widget.command.delivery!.time.substring(0, 5)}',
                widget.items.reference,
                '',
                () {}),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Détail de la commande',
                        style: AppConstants.bodyTextStyle,
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Couleur'),
                          widget.items.product.colors != null
                              ? SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.items.product.colors!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppConstants
                                                    .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              widget
                                                  .items.product.colors![index],
                                              style: AppConstants.bodyTextStyle,
                                            ),
                                          ));
                                    },
                                  ),
                                )
                              : const Text('RAS',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quantité'),
                          Text('${widget.items.quantity} pièces'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Prix',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                          Text(
                              '${widget.items.totalproduct} ${AppConstants.currency}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Livraison'),
                          Text(
                              '${widget.items.totalfees} ${AppConstants.currency}'),
                        ],
                      ),
                      Divider(
                        color: AppConstants.backgroundColor,
                      ),
                      // Calcul du montant total à payer (prix + livraison)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('À payer',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                          // Calcul dynamique du total à payer
                          Text(
                            '${widget.items.total} ${AppConstants.currency}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
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
                              Text(widget.command.client!.name ?? '',
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
                              Text('${widget.command.delivery!.city!.name}',
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
                              Text(
                                  '${widget.command.client!.phoneNumber ?? 'aucun'}',
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
                                  widget.command.client!.phoneNumber2 ??
                                      'aucun',
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
                              Text('${widget.command.delivery!.date}',
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
                                  '${widget.command.delivery!.time.substring(0, 5)}',
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
                    ))),
            const SizedBox(
              height: 20,
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
              Text(
                  'voulez vous vraiment marqué Cette commande  : \n $status ?'),
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
                        0.45, // Prendre toute la largeur
                    child: ElevatedButton(
                      onPressed: () {
                        var changeStatus;
                        if (status == 'En cours de livraison') {
                          changeStatus = 'in_progress';
                        } else if (status == 'commande Livrées') {
                          changeStatus = 'validated';
                        } else if (status == 'commande En attente') {
                          changeStatus = 'pending';
                        }
                        // Logique pour "En cours"
                        cmdeControkler.updateOrderStatus(
                            widget.command.id, changeStatus, '');
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
      backgroundColor: Colors.white,
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
                        cmdeControkler.updateOrderStatus(
                            widget.command.id,
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
