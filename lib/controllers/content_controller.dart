import 'package:maths_language/models/content_model.dart';

class ContentController {
  Future<List<dynamic>> fetchContents(int id) async {
    final List<ContentModel> mockContentList = [
      ContentModel(
        thumbnailPath:
            "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
        name: "Conteúdo 1",
        description: "Descrição do conteúdo 1",
        updatedAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      ContentModel(
        thumbnailPath:
            "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
        name: "Conteúdo 2",
        description: "Descrição do conteúdo 2",
        updatedAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      ContentModel(
        thumbnailPath:
            "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
        name: "Conteúdo 3",
        description: "Descrição do conteúdo 3",
        updatedAt: DateTime.now().subtract(Duration(days: 3)),
      ),
      ContentModel(
        thumbnailPath:
            "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
        name: "Conteúdo 4",
        description: "Descrição do conteúdo 4",
        updatedAt: DateTime.now().subtract(Duration(days: 4)),
      ),
      ContentModel(
        thumbnailPath:
            "https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg",
        name: "Conteúdo 5",
        description: "Descrição do conteúdo 5",
        updatedAt: DateTime.now().subtract(Duration(days: 5)),
      ),
    ];
    return mockContentList;
  }
}
