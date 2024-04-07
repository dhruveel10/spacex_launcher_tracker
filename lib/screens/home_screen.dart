import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/spacex_api_service.dart';
import '../widgets/launch_card.dart';
import 'saved_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    SavedCards(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<SpaceXApiService>(context, listen: false).fetchUpcomingLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Launches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpaceXApiService>(
      builder: (context, apiService, child) {
        if (apiService.launches.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: apiService.launches.length,
          itemBuilder: (context, index) {
            final launch = apiService.launches[index];
            return LaunchCard(launch: launch);
          },
        );
      },
    );
  }
}
