class Channel {
  final String id;
  final String name;
  final String streamUrl;
  final String logo;
  final String category;

  Channel({
    required this.id,
    required this.name,
    required this.streamUrl,
    required this.logo,
    required this.category,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Channel',
      streamUrl: json['streamUrl']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
    );
  }
}