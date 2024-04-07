import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_launcher_tracker/widgets/launch_card.dart';

import '../models/launch.dart';
import '../services/firestore_service.dart';
import 'launch_details_screen.dart';

// Inside SavedCards

class SavedCards extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Launch>>(
        stream: _firestoreService.getSavedLaunches(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No saved launches'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final launch = snapshot.data![index];
              return LaunchCard(launch: launch);
            },
          );
        },
      ),
    );
  }
}




