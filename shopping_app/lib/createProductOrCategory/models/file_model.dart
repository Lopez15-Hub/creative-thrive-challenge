class FileModel {
  final String path;
  final String file;
  FileModel({required this.path, required this.file});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(path: json['path'], file: json['file']);
  }
  Map<String, dynamic> toJson() => {
        
      };
}
