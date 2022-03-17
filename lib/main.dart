import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/widgets.dart';  //para poner u menu desplegable que nos permitira cerrar sesion AU2

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cat/Athenticator.dart';
import 'package:flutter_cat/widget/navigation_drawer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // para activar camara y escoger imagene
import 'package:image_cropper/image_cropper.dart'; // libreria para cortar imagen descargar en dependecies
import 'package:image_cropper/src/cropper.dart';
//import 'package:image_picker_type/image_picker_type.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      //.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
      //.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100&offset=200'));
      .get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
 /* final int userId;
  final int id;
  final String title;*/
  /*final int Count;
  final String Next;
  final String Previous;*/
  final String message;
  final String status;

  const Album({
    /*required this.userId,
    required this.id,
    required this.title,*/
  /* required this.Count,
    required  this.Next,
    required this.Previous,*/
    required this.message,
    required this.status,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      /*userId: json['userId'],
      id: json['id'],
      title: json['title'],*/
     /* Count: json['count'],
      Next: json['next'],
      Previous: json['previous'],*/
      message: json['message'] as String,
      status:  json['status'] as String,
    );
  }
}

/*void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}*/
//rutas
void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        //'/': (context) => const  SecondScreen(),
        '/' :(context) => const GoogleAthenticator(),
        '/image': (context) => const  Imagen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const MyApp(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}


//class _MyAppState extends State<MyApp>  {
class _MyAppState extends State<MyApp>  {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¿Qué Dog eres?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('¿Qué Dog eres?'),
          //una accion. boton
          actions:<Widget>[
            IconButton(
                icon: Icon(Icons.youtube_searched_for),
              iconSize: 50,
              onPressed: _pushSaved,// llama a la funcion pushsaved que creamos abajo dnetro de la clase misma

            ),

          ],

        ),
        body:

        Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return  Text(snapshot.data!.message);
                return Image.network(snapshot.data!.message);


              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),


        ),
        
      ),
    );

  }
  void _pushSaved(){ //funcion que permite actualizar la foto

      // Navigate back to first screen when tapped.
      Navigator.pushNamed(context, '/');

  }
}



class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}



//creamos una clase parauna nueva pantalla
//para escoger imagen y activar camra necesitaremos poner en dpendencias image_picker
//tambien necesitaremos importar la libreia import 'dart:io'

 class Imagen extends StatefulWidget{
   const Imagen({Key? key}) : super(key: key);
  @override
   _ImagenState createState()=> _ImagenState();

 }



class _ImagenState extends State<Imagen>{
  //creamos una funcione opciones
 File? imagens=null; //una variable de tipo file no puede comenzar en null e spor ello que agregamos ? y igualamos a null
 final picker=ImagePicker();

// creamos un funcion de tipo future poque necesitamos que espere un tiempo hasta que tiome una foto o sellecione

  Future selImagen(op) async{
    var pickerFile;
    if(op==1){
      pickerFile=await picker.pickImage(source:ImageSource.camera);
    }else{
      pickerFile=await picker.pickImage(source:ImageSource.gallery);
    }
    //actualizamos nuestra imagen
    setState(() {
      if(pickerFile != null){

       //imagens=File(pickerFile.path);//pone la imagen en la pantalla
        //AQUI PONEMOS EL CODIGO PARA CORTAR.
        //INSTALAR LA DEPENDENCIA IMAGEN CROPPER Y COPIAR LA ACTIVIDADES EN MANIFEST XML, Y PONER ALGUNOS PERMISOS
        //IMPORTAR LA LIBREIA IMAGEN CROPPER
        cortar(File(pickerFile.path)); //creamos una funcion cortar ahi abajo
      }else{
        print('No seleccionaste ninguna imagen');
      }
    });
    Navigator.of(context).pop();//cuando seleciona o no muestra la pantalla de la foto o principal
  }
   // creamos la funcion cortar
 /*cortar(picked)async {

    //Future <File?> cropImage;
    File? cortado = await ImageCropper().cropImage(sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if (cortado != null) {
      setState(() {
        imagens = cortado;
      });
    }
  }*/

  //mi forma mejorada
  cortar(picked)async {

    //Future <File?> cropImage;
    File? cortado = await ImageCropper().cropImage(sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9

        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar Imagen',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    if (cortado != null) {
      setState(() {
        imagens = cortado;
      });
    }
  }

  /*cortar(picked) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
  }*/

  //FUNCION PARA SUBIR IMAGEN
 Dio dio=new Dio();
  Future<void> subir_imagen()async{
    try{
      String filename= imagens!.path.split('/').last;
      FormData formData=new FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imagens!.path, filename:filename
        )
      });
      await dio.post('http://joussalonso.com/clase/subir_imagen.php',
      data:formData).then((value){
        if(value.toString()=='1'){
          print('la foto se subio correctamente');
          Navigator.pushNamed(context, '/second');

        }else{
          print('huno un error');
        }
      });

  }catch(e){
    }
  }
  //aqui se muestra los botones en forma de dialogos(flotantes)
  opciones(context){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(//aqui dentro crearemos los atributos del boton alerta
              child: Column(
                children: [
                  //CREAREMOS LOS ATRIBUTOS DEL CUADRO Y DEL BOTON
                  InkWell( // se usa para definir atributos y acciones del boton
                    onTap: (){
                      //ACCION DEL BOTON TOMAR UN FOTO
                      selImagen(1); //es una funcion creada arriba
                    },
                    child:Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width:1, color: Colors.grey))
                      ),
                      //aqui creamos una fila en la misma colomuna donde definiremos encima del boton tomara foto el texto, el estilo y icono

                      child:Row(
                        children: [
                          Expanded(
                              child: Text('Tomar una foto', style: TextStyle(fontSize: 16),
                              ),),
                          Icon(Icons.camera_alt,color: Colors.blue)
                        ],
                      ) ,
                    )
                  ),

                  //OTRO FILA Y OTRO BOTON SELECIONA IMAGEN
                  InkWell(
                      onTap: (){
                         selImagen(2);// funcion creada arriba y pasamos un parametro 2
                      },
                      child:Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width:1, color: Colors.grey))
                        ),
                        //aqui creamos una fila en la misma colomuna donde definiremos encima del bOTON SELECCION DE IMAGEN el texto, el estilo y icono

                        child:Row(
                          children: [
                            Expanded(
                              child: Text('Seleccionar Imagen', style: TextStyle(fontSize: 16),
                              ),),
                            Icon(Icons.image,color: Colors.blue)
                          ],
                        ) ,
                      )
                  ),
                  //otra fila y boton cancelar
                  InkWell(
                      onTap: (){
                        //aqui creamos la accion que realizara el boton cancelar
                        Navigator.of(context).pop();

                      },
                      child:Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                           color: Colors.blue,
                            border: Border(bottom: BorderSide(width:1, color: Colors.grey))
                        ),
                        //aqui creamos una fila en la misma colomuna donde definiremos encima del boton tomara foto el texto, el estilo y icono

                        child:Row(
                          children: [
                            Expanded(
                              child: Text('Cancelar', style: TextStyle(fontSize: 16, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),),

                          ],
                        ) ,
                      )
                  )
                ],
              ),

            ),
          );
        }
        );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una Imegen'),
      ),
      body: ListView( //para que tenga movilidad para abajo
        children: [
          Padding( //para que tenga un margen y no este pegado a los costados
              padding: EdgeInsets.all(20),
              child:Column(
                children: [
                  ElevatedButton(
                      onPressed:(){
                        opciones(context); //funcion que se crea arriba
                      },
                 child: Text('Seleccione Imagen'),
    ),
              SizedBox(height:10,), //es para que haya un espacio entre el objeto de abajo
               ElevatedButton( //boton para subir una imagen
                    onPressed:(){
                      //opciones(context); //funcion que se crea arriba
                      //Navigator.pushNamed(context, '/second');
                      subir_imagen();
                    },
                    child: Text('subir imagen'),
                  ),
                  SizedBox(height:10,),
                  //Center() //es para centrar la image

                  //ESTO SOLUCIONA EL ERROR DE NULL IMICIALIZADO CON LO DE ARRIBA A LA HORA DE DELCARAR LA VARIA BLE FILE? IMAGENS
              imagens!= null ? Image.file(imagens!):Center() //si imagne es igual a null va ha centrar la imagne de lo contrario pondra la imagne perno en ningun momento sera nula =imagen!

    ],

    ),
    ),
    ],

      ),
        //CREAMOS UN MENU PARA CERRAR SESION DE GOOGLE AU2 con drawer
        //_drawerHouse(BuildContext context, Color colorHeader){
    //return Drawer(
   /*   drawer: Drawer(
    child: ListView(
    children:<Widget> [
    DrawerHeader(
    decoration:  BoxDecoration(
    //gradient: DesignWidgets.linearGradientMain(context),
    color: Colors.blue,
    ),
    child: Text('Drawer cabecera',
    style: TextStyle(color: Colors.white, fontSize: 24),)),
    ListTile(
    leading: Icon(Icons.account_balance),
    title: Text('Perfil'),
    ),
    ListTile(
    leading: Icon(Icons.message),
    title: Text('Mensajes'),
    ),
    ],
    ),
    ),*/
//FORMA MAS EFICIENTE DE CONSTRUIR UN DRAWER - UN MENU AU2
    drawer: NavigationDrawerWidget(),
    );
  }

}


//CREAMOS UN NUEVA PANTALLA PARA LA AUTENTICACION DE GOOGLE
/*void main(){
  runApp(MaterialApp(home: GoogleAthenticator(),));
}*/
class GoogleAthenticator extends StatelessWidget{
  const GoogleAthenticator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    Firebase.initializeApp();
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async{
               User? user= await Authenticator.iniciarSesion(
                 context: context );

               print(user?.displayName);
               Navigator.pushNamed(context, '/image');


          },
          color:  Colors.blue,
          child: Icon(FontAwesomeIcons.google),
          textColor: Colors.white,
        ),
      )
    );
  }

}
