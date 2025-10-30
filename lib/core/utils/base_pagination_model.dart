class Pagination {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPosts;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int? nextPage;
  final int? previousPage;

  Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPosts,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.nextPage,
    this.previousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalItems: int.tryParse(json['totalItems'].toString()) ?? 0,
      totalPosts: int.tryParse(json['totalPosts'].toString()) ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      nextPage: json['nextPage'],
      previousPage: json['previousPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'totalPosts': totalPosts,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
      'nextPage': nextPage,
      'previousPage': previousPage,
    };
  }
}
