

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/WIDGETS/menu_widget.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/prodcuto_model.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey= GlobalKey<FormState>();
  final scaffoldKey= GlobalKey<ScaffoldState>();
  ProductosBloc productosBloc;
  ProductoModel prodcuto = new ProductoModel();
  bool _guardando= false;
  File foto;
  @override
  Widget build(BuildContext context) {

    productosBloc= Provider.productosBloc(context);

    final ProductoModel prodData= ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      prodcuto=prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions:<Widget> [
          IconButton (
            icon: Icon(Icons.photo_size_select_actual),
            onPressed:_seleccionarFoto,
          ),
          IconButton (
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: prodcuto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value)=> prodcuto.titulo=value,
      validator: (value){
        if(value.length<3){
          return ('Ingrese el nombre del producto');
        } else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: prodcuto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
       onSaved: (value)=> prodcuto.valor= double.parse(value),
      validator: (value){
        if(utils.isNumeric(value)) {
          return null;
        } else{
          return 'Solo números';
        }
      },
    );
  }

 Widget _crearDisponible() {
   return SwitchListTile(
     value: prodcuto.disponible,
     title: Text('Disponible'),
     activeColor: Colors.blueAccent,
     onChanged: (value)=> setState((){
       prodcuto.disponible=value;
     }),
   );
 }
 Widget  _crearBoton() {
   return RaisedButton.icon(
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
     color: Colors.blueAccent,
     textColor: Colors.white,
     label: Text('Guardar'),
     icon: Icon(Icons.save),
     onPressed: (_guardando) ? null : _submit ,
   );
 } 

 void _submit() async {

   if(!formKey.currentState.validate()) return;
   formKey.currentState.save();
  // formKey.currentState.validate();
 setState(() {_guardando=true;});

  if(foto!=null){
    prodcuto.fotoUrl= await  productosBloc.subirFoto(foto);
  }


  if(prodcuto.id ==null){
    productosBloc.agregarProducto(prodcuto);
    Duration(seconds: 3);
    //utils.mostrarAlerta(context, 'Producto agregado con exito');
  } else{
    productosBloc.editarProducto(prodcuto);
  }
 // setState(() {_guardando=false;});
   mostratSnackBar('Registro guardado');
    Navigator.pushNamed(context, 'tabs').then((value) {setState((){
      });} );
    
 }
void mostratSnackBar( String mensaje){
     final snackbar= SnackBar(
       content: Text(mensaje),
       duration: Duration(milliseconds: 1500),
     );
    scaffoldKey.currentState.showSnackBar(snackbar);
   }
 _mostrarFoto() {
 
    if (prodcuto.fotoUrl != null) {
 
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
         image: NetworkImage(prodcuto.fotoUrl),
         height: 300.0,
         fit: BoxFit.contain,
         );
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }


_seleccionarFoto(){
  _processImage(ImageSource.gallery);
}
_tomarFoto() async {
    _processImage(ImageSource.camera);
  }
   

  _processImage(ImageSource origen) async {
    foto= await ImagePicker.pickImage(
      source: origen
    );
 
    if (foto != null) {
      prodcuto.fotoUrl = null;
    }
   
    setState(() {});
  }
  }
