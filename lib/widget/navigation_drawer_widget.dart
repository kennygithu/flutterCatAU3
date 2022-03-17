import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/favourites_page.dart';
import '../page/people_page.dart';
import '../page/user_page.dart';

class NavigationDrawerWidget extends StatelessWidget{
  final padding = EdgeInsets.symmetric(horizontal: 20); //esto es para empujar hacia la derecha el icono personas
  @override
  Widget build(BuildContext context){
    //para crear el foto de perfil en la pantalla desplegable(drawer) esa son variable de tipo final
    final name='Sara Abs';
    final email='sara@abs.com';
    final urlImage='https://static.onecms.io/wp-content/uploads/sites/20/2021/04/21/dog-nose.jpg';
    
    return Drawer(            //se crea la pantalla desplegable AU2


      child: Material(//para que suene el boton al presionar
        color: Color.fromRGBO(50, 75, 205, 1), //se pone color a la pantalla desplegable au2
        child: ListView(
          //padding: padding, //aqui se le llama
          children: <Widget>[
            //este es metodo que se va ha crear abajoa para qu se muestre en pantalla desplegable la foto y sus datos
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked:()=>Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>UserPage(//llama al script user_page y a la clse que se encuentra dentro qeu se llama UserPage y pasa datos name y urlImage
                    name:name,
                    urlImage:urlImage,
                  ),
              )),
              
            ),
            Container( //para poner usar el paddin que se borrro arriba
              padding:padding,
            child: Column(//es ncesario usar ello sino  votara error
              children:[//igual es necesario usaralo para usar el paading
                const SizedBox(height: 12),
                buildSearchField(), //metodo creado para buscar lo que ponga o escriba , este metod esta abajo
            const SizedBox(height: 20),
            buildMenuItem(  //es un metodo que se crea bajo para el menu au2
              text:'People',
              icon:Icons.people,
              onClicked: ()=> selectedItem(context, 0), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla personas mediante el intem 0 usando un case

            ),
            //para crear el boton y icono favoritos
            const SizedBox(height: 16),//espaciado uqe habra entre el siguiente boton
            buildMenuItem(  //es un metodo que se crea bajo para el menu au2
              text:'Favourites',
              icon:Icons.favorite_border,
              onClicked: ()=> selectedItem(context, 1), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla FAVOTITOR mediante el intem 1 usando un case

            ),
            //para crear el boton y icono workflow

            const SizedBox(height: 16),//espaciado uqe habra entre el siguiente boton
            buildMenuItem(  //es un metodo que se crea bajo para el menu au2
              text:'Workflow',
              icon:Icons.workspaces_outline,
              onClicked: ()=> selectedItem(context, 2), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla WORKFLOW mediante el intem 2 usando un case

            ),
          //para crear el boton y icono updates

      const SizedBox(height: 16),//espaciado uqe habra entre el siguiente boton
      buildMenuItem(  //es un metodo que se crea bajo para el menu au2
        text:'Updates',
        icon:Icons.update,
        onClicked: ()=> selectedItem(context, 3), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla updTES mediante el intem 3 usando un case

      ),
            const SizedBox(height: 24,),
            Divider(color:Colors.white70),   //esto divide con una linea los botones de los otros

            //para crear el boton y icono plugins

            const SizedBox(height: 16),//espaciado uqe habra entre el siguiente boton
            buildMenuItem(  //es un metodo que se crea bajo para el menu au2
              text:'Plugins',
              icon:Icons.account_tree_outlined,
              onClicked: ()=> selectedItem(context, 4), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla plugins mediante el intem 0 usando un case

            ),
            //para crear el boton y icono Notificacion

            const SizedBox(height: 16),//espaciado uqe habra entre el siguiente boton
            buildMenuItem(  //es un metodo que se crea bajo para el menu au2
              text:'Notifications',
              icon:Icons.notifications_outlined,
              onClicked: ()=> selectedItem(context, 5), //es para que el metodo selectedItem que creamos abajo pueda direecionarnos a la pantalla NOTIFICACION mediante el intem 0 usando un case

            ),
              ],
            )
            )
          ],

          ),
        ),
      );


  }
  //este metdo sirve para que se muestre la foto de perfil
  Widget buildHeader({
  required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
})=>
  InkWell( // sirve para crear las acciones y atributo del boton
    onTap: onClicked,
    child: Container(
      padding: padding.add(EdgeInsets.symmetric(vertical: 40)), //este define el tamao de box verticalmente donde dentro estara centrado verticalmente la foto
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage),), //para la imagen
          SizedBox(width: 20), //espacio entre la foto y el texto(dibuja un caja de 20 de ancho)
          Column( // crea un a columna donde van ha estar los textos
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20,color: Colors.white), //muestra name
              ),
              const SizedBox(height: 4), //espacio entre ambos textos
              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.white), //muestra email

              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(30,60, 168, 1),
            child: Icon(Icons.add_comment_outlined, color: Colors.white,),
          )

        ],
      ),
    ),
  );

  //este metodo sire para el cuadro de dialogo creado para buscar lo que se escriba
  Widget buildSearchField(){
    final color =Colors.white;
    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
  //este metodo sirve para crear un listtile donce podemosporner colores obviamente recibiendo los datos que se envian de arriba
  Widget buildMenuItem({
  required String text,
    required IconData icon,
    VoidCallback? onClicked,  //para cuando se hagla en uno de los botones del menu
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color), //se crea una lista de titulos, esto es para el icono
      title: Text(text,style: TextStyle(color: color),),
      hoverColor: hoverColor,
      onTap: onClicked,

    );
  }
 //metodo que sirve para navegar entre pantallas del menu creado
  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); //es para cuando volvemos de la pantalla de algun menu nos mande a la pantalla principal sin que se muestre la pantalla despleganle donde esta el menu
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>PeoplePage(),

        )
        );
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>FavouritesPage(),
        ));
        break;

    }
  }
}