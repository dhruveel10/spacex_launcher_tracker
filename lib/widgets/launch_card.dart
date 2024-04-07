import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import '../models/launch.dart';
import '../screens/launch_details_screen.dart';
import '../services/firestore_service.dart';

class LaunchCard extends StatefulWidget {
  final Launch launch;

  LaunchCard({required this.launch});

  @override
  _LaunchCardState createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  bool _isSaved = false;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaunchDetailsScreen(launch: widget.launch),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.launch.imageUrl != null)
              CachedNetworkImage(
                imageUrl: widget.launch.imageUrl!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.launch.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                      'Date: ${DateFormat('MM-dd-yyyy').format(widget.launch.dateUtc)}'),
                  SizedBox(height: 8.0),
                  Text('Rocket: ${widget.launch.rocket}'),
                  SizedBox(height: 8.0),
                  Text('Launchpad: ${widget.launch.launchpad}'),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder<bool>(
                        future: _firestoreService.isLaunchSaved(widget.launch),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Icon(Icons.error);
                          }
                          _isSaved = snapshot.data ?? false;
                          return ElevatedButton.icon(
                            onPressed: () async {
                              if (_isSaved) {
                                await _firestoreService.unsaveLaunch(widget.launch);
                              } else {
                                await _firestoreService.saveLaunch(widget.launch);
                              }
                              setState(() {
                                _isSaved = !_isSaved;
                              });
                            },
                            icon: Icon(_isSaved
                                ? Icons.bookmark_added
                                : Icons.bookmark_add_outlined),
                            label: Text(''),
                          );
                        },
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          Share.share(widget
                              .launch.webcastLink!);
                        },
                        icon: Icon(Icons.ios_share),
                        label: Text(''),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
