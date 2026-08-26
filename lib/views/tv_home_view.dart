import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../models/channel_model.dart';
import '../services/channel_service.dart';

class TvHomeView extends StatefulWidget {
  const TvHomeView({super.key});

  @override
  State<TvHomeView> createState() => _TvHomeViewState();
}

class _TvHomeViewState extends State<TvHomeView> {
  late final player = Player();
  late final controller = VideoController(player);

  List<Channel> channels = [];
  Channel? currentChannel;
  bool showSidebar = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  Future<void> _loadChannels() async {
    final list = await ChannelService.fetchChannels();
    if (mounted) {
      setState(() {
        channels = list;
        isLoading = false;
        if (channels.isNotEmpty) {
          _playChannel(channels.first);
        }
      });
    }
  }

  void _playChannel(Channel channel) {
    setState(() => currentChannel = channel);
    player.open(Media(channel.streamUrl));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () {
            setState(() => showSidebar = !showSidebar);
          },
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Video(controller: controller),
              ),
            ),
            if (showSidebar)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 320,
                  color: Colors.black.withOpacity(0.85),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Live Channels",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: channels.length,
                            itemBuilder: (context, index) {
                              final channel = channels[index];
                              final isSelected = currentChannel?.id == channel.id;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: InkWell(
                                  autofocus: index == 0,
                                  onTap: () => _playChannel(channel),
                                  borderRadius: BorderRadius.circular(8),
                                  focusColor: Colors.blueAccent,
                                  hoverColor: Colors.white24,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.white24 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        channel.logo.isNotEmpty
                                            ? Image.network(
                                                channel.logo,
                                                width: 36,
                                                height: 36,
                                                errorBuilder: (_, __, ___) => const Icon(Icons.tv, color: Colors.white),
                                              )
                                            : const Icon(Icons.tv, color: Colors.white),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            channel.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}