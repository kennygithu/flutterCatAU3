import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';

class FavouritesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context)=> Scaffold(
    //drawer: NavigationDrawerWidget(), //es para llamar a la clase que creamos en el script navigation_drawer:widget y asi nos morstra la pantalla desplegable donde esta el menu en esta pantalla

    appBar: AppBar(
      title: Text('Favourites'),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
  );
}