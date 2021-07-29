class ImageURL {
  final String filePath;
  final String errorCodes;

  ImageURL({
    this.filePath,
    this.errorCodes,
  });

  factory ImageURL.fromJson(Map<String, dynamic> json) {
    return ImageURL(
      filePath: json['filePath'],
      errorCodes: json['errorCodes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filePath'] = this.filePath;
    data['errorCodes'] = this.errorCodes;
    return data;
  }
}
