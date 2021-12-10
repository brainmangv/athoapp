//  s= Asset(timeEstimation:1);
class Asset {
  int id;
  AssetType assetType;
  // String title;
  String? body;

  /// **Tempo em segundos.**
  ///
  /// Para o tipo Article, o tempo é calculado dividido o numero de palavras
  /// por 1,5 (numero médio de leitura de palavras por segundo).
  ///
  /// Para o tipo Presentation o tempo é calculo 60 segundos por pagina.
  ///
  int timeEstimate;
  List<String>? slideUrls;
  String? mediaSource;

  /// Tamanho
  /// Para o tipos Video,Audio tempo em segundos.
  ///
  /// Para o tipo Presentation o numero de slides.
  ///
  /// Para o tipo Article o numero de palavras.
  ///
  int length;

  Asset(
      {required this.id,
      required this.assetType,
      // required this.title,
      required this.body,
      required this.timeEstimate,
      required this.slideUrls,
      required this.mediaSource,
      required this.length});

  Asset.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        assetType = getAssetTypeFromJson(json['asset_type']),
        // title = json['title'] ?? json['title'],
        body = json['body'] ?? json['body'],
        slideUrls = json['slide_urls'] ?? json['slide_urls'],
        mediaSource = json['media_source'] ?? json['media_source'],
        length = json['length'] ?? json['length'],
        timeEstimate = json['time_estimate'] ?? json['time_estimate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['asset_type'] = this.assetType;
    // data['title'] = this.title;
    data['media_source'] = this.mediaSource;
    data['time_estimate'] = this.timeEstimate;
    return data;
  }
}

enum AssetType {
  Audio,
  Ebook,
  Externallink,
  File,
  Presentation,
  SourceCode,
  Video,
  Article
}

getAssetTypeFromJson(String assetType) {
  for (AssetType element in AssetType.values) {
    if (element.toString() == 'AssetType.' + assetType) {
      return element;
    }
  }
  return null;
}
