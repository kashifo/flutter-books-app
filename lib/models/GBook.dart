class GBook {
  String? id;
  VolumeInfo? volumeInfo;
  int isFavorite = 0;

  GBook({required this.id, required this.volumeInfo, required this.isFavorite});

  GBook.fromJson(Map<String, dynamic> json) {
    // print('GBook fromJson');

    id = json['id'];
    isFavorite = 0;
    volumeInfo = json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : VolumeInfo();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFavorite'] = this.isFavorite;
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'GBook{id: $id, volumeInfo: $volumeInfo, isFavorite: $isFavorite}';
  }
}

class VolumeInfo {

  String? title;

  List<String>? authors;
  String? authorStr;

  String? publisher;

  ImageLinks? imageLinks;

  int? pageCount;
  String? publishedDate;
  String? description;

  List<IndustryIdentifiers>? industryIdentifiers;
  String? printType;
  String? language;
  String? previewLink;
  String? infoLink;

  String getThumbnail({bool small = true}) {
    if (imageLinks!=null) {
      if(imageLinks!.thumbnail!=null && imageLinks!.thumbnail!=null){
        return imageLinks!.thumbnail!;
      } else if(imageLinks!.smallThumbnail!=null && imageLinks!.smallThumbnail!=null){
        return imageLinks!.smallThumbnail!;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  String getAuthors() {
    if (authorStr != null && authorStr!.isNotEmpty) {
      return authorStr!;
    }

    if (authors == null || authors!.isEmpty) {
      authorStr = 'Author N/A';
    } else {
      authorStr = authors!.toString();
      var replace1 = authorStr!.replaceAll('[', '');
      var replace2 = replace1.replaceAll(']', '');
      authorStr = 'by $replace2';
    }

    return authorStr!;
  }

  @override
  String toString() {
    return 'VolumeInfo{title: $title, authors: $authors, publisher: $publisher, imageLinks: $imageLinks, publishedDate: $publishedDate, description: $description, industryIdentifiers: $industryIdentifiers, pageCount: $pageCount, printType: $printType, language: $language, previewLink: $previewLink, infoLink: $infoLink}';
  }

  VolumeInfo(
      {this.title,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.description,
      this.industryIdentifiers,
      this.pageCount,
      this.printType,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink});

  VolumeInfo.lite(
      {this.title,
        this.authorStr,
        this.publisher,
        this.imageLinks,
      });

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    // print('GBook VolumeInfo fromJson');

    try {
      title = json['title'] as String?;
      // print('parsed_json title=$title');

      if (json['authors'] != null) {
            authors = json['authors'].cast<String>();
          }
      publisher = json['publisher'] as String?;
      publishedDate = json['publishedDate'] as String?;
      description = json['description'] as String?;
      if (json['industryIdentifiers'] != null) {
            industryIdentifiers = <IndustryIdentifiers>[];
            json['industryIdentifiers'].forEach((v) {
              industryIdentifiers!.add(new IndustryIdentifiers.fromJson(v));
            });
          }
      pageCount = json['pageCount'] as int?;
      printType = json['printType'] as String?;

      if (json['imageLinks'] != null) {
            imageLinks = ImageLinks.fromJson(json['imageLinks']);
          } else {
            imageLinks = ImageLinks();
          }

      language = json['language'] as String?;
      previewLink = json['previewLink'] as String?;
      infoLink = json['infoLink'] as String?;
    } catch (e) {
      print(e);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['publisher'] = this.publisher;
    data['publishedDate'] = this.publishedDate;
    data['description'] = this.description;
    if (this.industryIdentifiers != null) {
      data['industryIdentifiers'] =
          this.industryIdentifiers!.map((v) => v.toJson()).toList();
    }
    data['pageCount'] = this.pageCount;
    data['printType'] = this.printType;
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.toJson();
    }
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['infoLink'] = this.infoLink;
    return data;
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    identifier = json['identifier'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['identifier'] = this.identifier;
    return data;
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.lite({this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'] as String?;
    thumbnail = json['thumbnail'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallThumbnail'] = this.smallThumbnail;
    data['thumbnail'] = this.thumbnail;
    return data;
  }

  @override
  String toString() {
    return 'ImageLinks{smallThumbnail: $smallThumbnail, thumbnail: $thumbnail}';
  }
}
