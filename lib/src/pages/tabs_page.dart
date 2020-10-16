import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';

import 'package:provider/provider.dart';


 
 
class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}
class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegacionModel= Provider.of<_NavegacionModel>(context);
    


    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i)=>navegacionModel.paginaActual=i,
      items: [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.moneyBill), title: Text('Comprar')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.boxOpen), title: Text('Vender')),
      ]
    );
  }
}
class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel= Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget> [
        HomePage(),
        
        ProductoPage()
      ],
    );
  }
}
  class _NavegacionModel with ChangeNotifier {

  int _paginaActual=0;
  PageController _pageController = new PageController();
   
  int get paginaActual => this._paginaActual;
  
  set paginaActual(int valor){
    this._paginaActual=valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController=> this._pageController;
}