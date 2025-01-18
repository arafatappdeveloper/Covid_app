import 'package:flutter/material.dart';

import '../view_models/world_covid.dart';
class BottomPageView extends StatefulWidget {
  const BottomPageView({super.key});

  @override
  State<BottomPageView> createState() => _BottomPageViewState();
}

class _BottomPageViewState extends State<BottomPageView> {
  static  List<Widget> _widgetList=[
    Text('data'),
    WorldCovid(),
    Text('data'),
  ];
  void _ontapped(int index)async{
    setState(() {
      _selectedIndex=index;
    });
  }
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetList.elementAt(_selectedIndex),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
          onTap: _ontapped,
          selectedItemColor: Colors.amber[800],
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded),label: ''),
          ]),
    );
  }
}
