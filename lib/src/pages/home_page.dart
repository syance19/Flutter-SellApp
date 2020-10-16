import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/WIDGETS/menu_widget.dart';
import 'package:formvalidation/src/bloc/provider.dart';

import 'package:formvalidation/src/models/prodcuto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
//import 'package:formvalidation/src/providers/productos_provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
   
   final productosBloc= Provider.productosBloc(context);
   productosBloc.cargarProductos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton (
            icon: Icon(Icons.exit_to_app),
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login')
            ),
          
        ],
      ),
      drawer: MenuWidget(),
      body: _crearListado(productosBloc),
      // floatingActionButton: _crearBoton(context),
      );
  }

  // _crearBoton(BuildContext context) {
  //   return FloatingActionButton(
  //     child: Icon(Icons.replay),
  //     backgroundColor: Colors.blueAccent,
  //     onPressed: ()=> Navigator.pushNamed(context, 'producto'),
  //     );
  // }

 Widget _crearListado(ProductosBloc productosBloc) {
 return StreamBuilder(
   stream: productosBloc.productosStream ,
   builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
     if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i], productosBloc ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
   },
 );
  }

Widget _crearItem(BuildContext context ,ProductoModel producto, ProductosBloc productosBloc){
  return Dismissible(
    key: UniqueKey(),
    background: Container(
      color: Colors.red,
    ),
    onDismissed: (direccion){
    productosBloc.borrarProducto(producto.id);
    },
     child:  Card(
       child: Column(
         children:<Widget> [
           (producto.fotoUrl == null) 
           ? Image(image: AssetImage('assets/no-image.png'))
           : FadeInImage(
             image: NetworkImage(producto.fotoUrl),
             placeholder: AssetImage('assets/jar-loading.gif'),
             height: 300.0,
             width: double.infinity,
             fit: BoxFit.cover,
           ),
           ListTile(
      title: Text('${producto.titulo} - ${producto.valor}'),
      subtitle: Text(producto.id),
      onTap: ()=> Navigator.pushNamed(context, 'producto',arguments: producto).then((value) {setState((){
      });}),
    ),
    _boton()
         ],
       ),
     )


    
  );
}

 Widget  _boton() {
   return RaisedButton(
     onPressed: () => {},
   child: Icon(FontAwesomeIcons.creditCard),
   );
 }
}