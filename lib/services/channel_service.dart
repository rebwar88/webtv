import 'package:http/http.dart' as http;
import '../models/channel_model.dart';

class ChannelService {
  /// Iraq playlist from the community-maintained iptv-org project.
  /// Includes Kurdish-language channels alongside national ones.
  /// Source: https://github.com/iptv-org/iptv
  static const String playlistUrl = 'https://iptv-org.github.io/iptv/countries/iq.m3u';

  static Future<List<Channel>> fetchChannels() async {
    final response = await http.get(Uri.parse(playlistUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load playlist (${response.statusCode})');
    }

    return _parseM3U(response.body);
  }

  static List<Channel> _parseM3U(String content) {
    final lines = content.split('\n').map((l) => l.trim()).toList();
    final channels = <Channel>[];

    String name = 'Unknown Channel';
    String logo = '';
    String category = 'General';
    int idCounter = 0;

    for (final line in lines) {
      if (line.isEmpty) continue;

      if (line.startsWith('#EXTINF')) {
        logo = _extractAttribute(line, 'tvg-logo') ?? '';
        category = _extractAttribute(line, 'group-title') ?? 'General';

        final commaIndex = line.indexOf(',');
        name = commaIndex != -1 && commaIndex + 1 < line.length
            ? line.substring(commaIndex + 1).trim()
            : 'Unknown Channel';
      } else if (!line.startsWith('#')) {
        idCounter++;
        channels.add(
          Channel(
            id: idCounter.toString(),
            name: name,
            streamUrl: line,
            logo: logo,
            category: category,
          ),
        );
        name = 'Unknown Channel';
        logo = '';
        category = 'General';
      }
    }

    return channels;
  }

  static String? _extractAttribute(String line, String key) {
    final regex = RegExp('$key="([^"]*)"');
    final match = regex.firstMatch(line);
    return match?.group(1);
  }
}