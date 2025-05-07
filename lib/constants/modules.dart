import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constantApp.dart';

GestureDetector produitCard(
    String titreProduit,
    String stock,
    String pieces,
    String maping,
    String imagep,
    String heurs,
    String montnt,
    String statut,
    String action,
    Function ontap) {
  return GestureDetector(
    onTap: () => ontap(),
    child: Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color.fromARGB(255, 241, 241, 241))),
      child: ListTile(
        title: Text(
          titreProduit.length <= 12
              ? titreProduit
              : '${titreProduit.substring(0, 12)}...',
          style: AppConstants.bodyTextStyle.copyWith(fontSize: 12),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  Row(
              children: [
                const Text(
                  'Stock ',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  ' $stock',
                  style: const TextStyle(fontSize: 10, color: Colors.blue),
                ),
                Text(
                  '/$pieces ',
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ), */
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  maping,
                  style:
                      AppConstants.bodyTextStyle.copyWith(color: Colors.blue),
                )),
            Row( // Changement de couleur pour les status
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  statut,
                  style: TextStyle(
                    color: (statut == 'Commande En attente')
                        ? hexToColor('#7B005D')
                        : (statut == 'Commande Livrée')
                            ? Colors.green
                            : (statut == 'Commande Annulée')
                                ? Colors.red
                                : (statut == 'Commande En cours')
                                    ? Colors.blue
                                    : Colors.orange,
                    fontSize: 9,
                  ),
                ),
              ],
            )
          ],
        ),
        trailing: Column(
          children: [
            Text(
              " $heurs",
              style: TextStyle(fontSize: 9),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$montnt ${AppConstants.currency}',
              style: AppConstants.headingTextStyle
                  .copyWith(fontSize: 15, color: Colors.blue),
            ),
            SizedBox(
              height: 2,
            ),
            /* Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                    color: hexToColor('#FCF5F5')),
                child: Center(
                  child: Text(
                    ' $action',
                    style: const TextStyle(fontSize: 12, color: Colors.orange),
                  ),
                ),
              ), */
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imagep,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

Padding comptableCard(
    String titreProduit,
    String stock,
    String pieces,
    String maping,
    String imagep,
    String heurs,
    int montnt,
    String montntVers,
    String statut,
    String action,
    Function ontap) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.1), // Couleur de l'ombre légèrement sombre
            spreadRadius: 1, // Diffusion légère
            blurRadius: 2, // Flou doux pour un effet plus subtil
            offset:
                const Offset(0, 3), // Ombre en bas (aucun décalage horizontal)
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          titreProduit.length <= 14
              ? titreProduit
              : '${titreProduit.substring(0, 14)}..',
          style: AppConstants.headingTextStyle.copyWith(fontSize: 11),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statut,
              style: AppConstants.bodyTextStyle
                  .copyWith(fontSize: 10, color: Colors.grey),
            ),
            Text(
              maping,
              style: AppConstants.bodyTextStyle
                  .copyWith(fontSize: 10, color: Colors.blue),
            ),
            Text(
              'Vendu à $montntVers ${AppConstants.currency}',
              style: const TextStyle(fontSize: 10, color: Colors.blue),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("$heurs",
                style: const TextStyle(
                  fontSize: 10,
                )),
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'A Solder ',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    TextSpan(
                      text: "$montnt",
                      style:
                          const TextStyle(fontSize: 11, color: Colors.orange),
                    ),
                    const TextSpan(
                      text: '${AppConstants.currency}',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    )
                  ],
                )),
            const SizedBox(
              height: 5,
            ),
            if (action != '')
              GestureDetector(
                  onTap: () => ontap(),
                  child: action != 'Soldé'
                      ? Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange),
                          child: Center(
                            child: Text(' $action',
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white)),
                          ),
                        )
                      : Text(
                          action,
                          style: AppConstants.bodyTextStyle.copyWith(
                              color: Colors.green, fontStyle: FontStyle.italic),
                        )),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imagep,
            fit: BoxFit
                .cover, // Permet de couvrir toute la taille donnée à l'image
          ),
        ),
      ),
    ),
  );
}

Padding produitCarddetail(
    String titreProduit,
    String stock,
    String pieces,
    String imagep,
    String montnt,
    String heurs,
    String codeproduit,
    String infor,
    Function gatpage) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.1), // Couleur de l'ombre légèrement sombre
            spreadRadius: 1, // Diffusion légère
            blurRadius: 2, // Flou doux pour un effet plus subtil
            offset:
                const Offset(0, 3), // Ombre en bas (aucun décalage horizontal)
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        title: Text(
          titreProduit.length <= 14
              ? titreProduit
              : '${titreProduit.substring(0, 14)}..',
          style: AppConstants.bodyTextStyle.copyWith(fontSize: 12),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                codeproduit,
                style: AppConstants.headingTextStyle.copyWith(fontSize: 13),
              ),
            ),
            //Text('data'),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Stock: $stock',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis, // Prevent overflow
              ),
            ),
          ],
        ),
        trailing: infor != ''
            ? Column(
                children: [
                  Text(''),
                  Spacer(),
                  InkWell(
                    onTap: () => gatpage(),
                    child: Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                          /*    boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), // Couleur de l'ombre légèrement sombre
                                  spreadRadius: 1, // Diffusion légère
                                  blurRadius:
                                      2, // Flou doux pour un effet plus subtil
                                  offset: const Offset(0,
                                      3), // Ombre en bas (aucun décalage horizontal)
                                ),
                              ], */
                          borderRadius: BorderRadius.circular(5),
                          color: hexToColor('#FBFAFF')),
                      child: Center(
                        child: Text(
                          '$infor',
                          style:
                              AppConstants.bodyTextStyle.copyWith(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Text(''),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imagep,
            fit: BoxFit
                .cover, // Permet de couvrir toute la taille donnée à l'image
          ),
        ),
      ),
    ),
  );
}

Card produitCarding(
  String imageUrl,
  String status,
  String title,
  String price,
  String stock,
  String totalStock,
  String logoUrl,
) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with status overlay
        Stack(
          children: [
            // Product Image
            Container(
              height: 110,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Status Overlay
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Product Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$price ${AppConstants.currency}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Stock info and logo in a Row
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock: $stock / $totalStock',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent overflow
                ),

                // Logo
                Image.asset(
                  logoUrl,
                  height: 20,
                  width: 20,
                ),
              ],
            ))
      ],
    ),
  );
}
