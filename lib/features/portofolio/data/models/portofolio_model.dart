class PortofolioItem {
  final String title;
  final int total;
  final String type;

  PortofolioItem({
    required this.title,
    required this.total,
    required this.type,
  });

  factory PortofolioItem.fromJson(Map<String, dynamic> json) {
    return PortofolioItem(
      title: json['title'],
      total: json['total'],
      type: json['type'],
    );
  }
}
