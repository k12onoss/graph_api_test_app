class PageAPIResponse {
  List<FacebookPage> listOfPages;

  PageAPIResponse({required this.listOfPages});

  factory PageAPIResponse.fromJson(Map<String, dynamic> json) {
    return PageAPIResponse(
      listOfPages: List.generate(
        (json['data'] as List).length,
        (index) => FacebookPage.fromJson(json['data'][index]),
      ),
    );
  }
}

class FacebookPage {
  String name;
  String id;
  String category;

  FacebookPage({
    required this.name,
    required this.id,
    required this.category,
  });

  factory FacebookPage.fromJson(Map<String, dynamic> json) {
    return FacebookPage(
      name: json['name'],
      id: json['id'],
      category: json['category'],
    );
  }
}
