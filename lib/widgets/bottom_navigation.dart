
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyNavigationBar extends StatefulWidget {  
//   const MyNavigationBar ({required Key key}) : super(key: key);  
  
//   @override  
//   _MyNavigationBarState createState() => _MyNavigationBarState();  
// }  
  
// class _MyNavigationBarState extends State<MyNavigationBar > {  
//   int _selectedIndex = 0;  
//   static const List<Widget> _widgetOptions = <Widget>[  
//     Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//     Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//     Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//   ];  
  
//   void _onItemTapped(int index) {  
//     setState(() {  
//       _selectedIndex = index;  
//     });  
//   }  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return   BottomNavigationBar(  
//           items: const <BottomNavigationBarItem>[  
//             BottomNavigationBarItem(  
//               icon: Icon(Icons.home),  
//              Text('Home'),  
//               backgroundColor: Colors.green  
//             ),  
//             BottomNavigationBarItem(  
//               icon: Icon(Icons.search),  
//               title: Text('Search'),  
//               backgroundColor: Colors.yellow  
//             ),  
//             BottomNavigationBarItem(  
//               icon: Icon(Icons.person),  
//               title: Text('Profile'),  
//               backgroundColor: Colors.blue,  
//             ),  
//           ],  
//           type: BottomNavigationBarType.shifting,  
//           currentIndex: _selectedIndex,  
//           selectedItemColor: Colors.black,  
//           iconSize: 40,  
//           onTap: _onItemTapped,  
//           elevation: 5  
//         ); 
     
//   }  
// }  