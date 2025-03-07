import '';
import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'livreurs_widget.dart' show LivreursWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LivreursModel extends FlutterFlowModel<LivreursWidget> {
  ///  Local state fields for this page.

  List<dynamic> livreurs = [];
  void addToLivreurs(dynamic item) => livreurs.add(item);
  void removeFromLivreurs(dynamic item) => livreurs.remove(item);
  void removeAtIndexFromLivreurs(int index) => livreurs.removeAt(index);
  void insertAtIndexInLivreurs(int index, dynamic item) =>
      livreurs.insert(index, item);
  void updateLivreursAtIndex(int index, Function(dynamic) updateFn) =>
      livreurs[index] = updateFn(livreurs[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
