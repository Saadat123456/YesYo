import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Material(
      child: NavBar(),
      color: Colors.white,
    );
  }

}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    StoreWidget(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("YesYo", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),

      body: Container(
        child: _pages.elementAt(_selectedIndex),
        color: Colors.black38,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              label: 'Collection',
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Feed',
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              label: 'Market',
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pageview_rounded),
              label: 'Profile',
              backgroundColor: Colors.black
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),

    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


class StoreWidget extends StatelessWidget {
  const StoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child: Column(
         children: [
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(
               children: [
                 CardCustom(),
                 CardCustom(),
                 CardCustom(),
                 CardCustom(),
                 CardCustom(),
                 CardCustom()
               ],
             ),
           )

         ],
       )
    );
  }
}

class CardCustom extends StatelessWidget {
  const CardCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 130,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage('images/splash.png'))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text('Nouveautés')),
        ),
      ),
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
    );
  }
}



