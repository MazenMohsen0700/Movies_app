class TorrentModel {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final String size;
  final int seeds;
  final int peers;

  TorrentModel({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.size,
    required this.seeds,
    required this.peers,
  });

  factory TorrentModel.fromJson(Map<String, dynamic> json) {
    return TorrentModel(
      url: json['url'] ?? '',
      hash: json['hash'] ?? '',
      quality: json['quality'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
    );
  }
}