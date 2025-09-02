// certificates_model.dart
import 'dart:convert';

/// Root object that wraps the whole JSON payload
class CertificateResponse {
  final bool status;
  final List<Certificate> certificates;
  final Meta meta;

  CertificateResponse({
    required this.status,
    required this.certificates,
    required this.meta,
  });

  /// Factory: parse from raw decoded JSON map
  factory CertificateResponse.fromJson(Map<String, dynamic> json) {
    return CertificateResponse(
      status: json['status'] as bool,
      certificates: (json['certificates'] as List<dynamic>)
          .map((e) => Certificate.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  /// Encode back to JSON-compatible map
  Map<String, dynamic> toJson() => {
        'status': status,
        'certificates': certificates.map((e) => e.toJson()).toList(),
        'meta': meta.toJson(),
      };

  /// Convenience helpers for raw json strings
  static CertificateResponse fromRawJson(String source) =>
      CertificateResponse.fromJson(jsonDecode(source));

  String toRawJson() => jsonEncode(toJson());
}

/// Single certificate entry
class Certificate {
  final String title;
  final String? url;
  final String obtainDate;

  Certificate({
    required this.title,
    required this.url,
    required this.obtainDate,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        title: json['title'] as String,
        url: json['url'] ,
        obtainDate: json['obtain_date'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'obtain_date': obtainDate,
      };
}

/// Pagination metadata
class Meta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current_page'] as int,
        lastPage: json['last_page'] as int,
        perPage: json['per_page'] as int,
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
      };
}
