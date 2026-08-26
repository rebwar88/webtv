import '../models/channel_model.dart';

class ChannelService {
  static Future<List<Channel>> fetchChannels() async {
    return [
      Channel(
        id: '1',
        name: 'Big Buck Bunny (HLS Test 1080p)',
        streamUrl: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        logo: '',
        category: 'Test',
      ),
      Channel(
        id: '2',
        name: 'Akamai HLS Live Stream',
        streamUrl: 'https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8',
        logo: '',
        category: 'Test',
      ),
      Channel(
        id: '3',
        name: 'Al Jazeera English',
        streamUrl: 'https://live-hls-web-aje.getaj.net/AJE/01.m3u8',
        logo: 'https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Al_Jazeera_English_logo.svg/300px-Al_Jazeera_English_logo.svg.png',
        category: 'News',
      ),
      Channel(
        id: '4',
        name: 'Sintel Open Source Stream',
        streamUrl: 'https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8',
        logo: '',
        category: 'Movie',
      ),
    ];
  }
}