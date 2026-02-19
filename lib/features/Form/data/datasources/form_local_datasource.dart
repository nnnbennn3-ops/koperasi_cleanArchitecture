class FormLocalDataSource {
  Future<List<Map<String, dynamic>>> getForms() async {
    return [
      {"title": "Form 1", "updatedAt": "5 May 2024"},
      {"title": "Form 2", "updatedAt": "8 May 2024"},
      {"title": "Form 3", "updatedAt": "10 May 2024"},
      {"title": "Form 4", "updatedAt": "11 May 2024"},
      {"title": "Form 5", "updatedAt": "13 May 2024"},
    ];
  }
}
