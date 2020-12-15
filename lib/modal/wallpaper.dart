class Wallpaper {
  String photographer;
  String photographer_url;
  String url;
  int photographer_id;
  SrcModal src;

  Wallpaper({
    this.photographer,
    this.url,
    this.photographer_id,
    this.photographer_url,
    this.src,
  });

  factory Wallpaper.fromMap(Map<String, dynamic> jsonData) {
    return Wallpaper(
      src: SrcModal.fromMap(jsonData['src']),
      url: jsonData['url'],
      photographer_url: jsonData['photographer_url'],
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
    );
  }
}

class SrcModal {
  String original;
  String portrait;
  String small;

  SrcModal({this.original, this.small, this.portrait});

  factory SrcModal.fromMap(Map<String, dynamic> jsonData) {
    return SrcModal(
      original: jsonData['original'],
      portrait: jsonData['portrait'],
      small: jsonData['small'],
    );
  }
}
