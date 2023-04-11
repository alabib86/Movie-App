

import 'package:flutter/material.dart';
import 'package:movies_app/Component/search.dart';

import 'comparison_screen.dart';
import 'favourite_screen.dart';
import 'movies_screen.dart';

class MyHomePage extends StatefulWidget {
   const MyHomePage({super.key, required this.title,});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  List<Widget> widgetPages = [
    const MoviesScreen(),
    const FavouriteScreen(),
    const ComparisonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          }, icon: const Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 0),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.white,
              selectedLabelStyle: const TextStyle(
                fontSize: 15,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 9),
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: "Home",
                    backgroundColor: Theme.of(context).splashColor),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite),
                    label: "Favorite",
                    backgroundColor: Theme.of(context).splashColor),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.compare),
                    label: "Compare",
                    backgroundColor: Theme.of(context).splashColor),
              ],
            ),
          )),
      body: widgetPages.elementAt(selectedIndex),
    );
  }
}

