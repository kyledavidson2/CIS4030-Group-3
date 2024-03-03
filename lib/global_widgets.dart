import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() =>
      MainNavigationBarState();
}

class MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}

class AddPhotosButton extends StatelessWidget {
  const AddPhotosButton({super.key});

  @override
  Widget build(BuildContext context){
    return FilledButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add_a_photo_outlined),
      label: const Text("Add Photos"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.primary
        ),
      )
    );
  }
}