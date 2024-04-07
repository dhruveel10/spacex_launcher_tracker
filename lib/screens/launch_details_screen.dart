import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/launch.dart';

class LaunchDetailsScreen extends StatelessWidget {
  final Launch launch;

  LaunchDetailsScreen({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (launch.imageUrl != null) ...[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      launch.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
              _buildInfoRow('Date:', DateFormat('MM-dd-yyyy').format(launch.dateUtc)),
              _buildInfoRow('Rocket:', launch.rocket),
              _buildInfoRow('Launchpad:', launch.launchpad),
              const SizedBox(height: 16.0),
              const Text(
                'Mission Details',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                launch.missionDetails,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              if (launch.webcastLink != null) ...[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(launch.webcastLink!)!,
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
