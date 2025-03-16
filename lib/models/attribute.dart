class ApiResponse {
  final JsonResponse jsonResponse;

  ApiResponse({required this.jsonResponse});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      jsonResponse: JsonResponse.fromJson(json['json_response']),
    );
  }
}

class JsonResponse {
  final List<Attribute> attributes;

  JsonResponse({required this.attributes});

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    final attributes = (json['attributes'] as List)
        .map((item) => Attribute.fromJson(item))
        .toList();
    return JsonResponse(attributes: attributes);
  }
}

class Attribute {
  final String id;
  final String title;
  final String type;
  final List<String> options;
  final String? selected;
  final String? placeholder;

  Attribute({
    required this.id,
    required this.title,
    required this.type,
    required this.options,
    this.selected,
    this.placeholder,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json['id'].toString(),
        title: json['title'],
        type: json['type'],
        options: List<String>.from(json['options']),
        selected: json['selected'],
        placeholder: json['placeholder'],
      );
}
