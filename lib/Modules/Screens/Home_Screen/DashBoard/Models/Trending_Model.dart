class Trending {
  List<TrendingData>? data;
  String? message;

  Trending({this.data, this.message});

  Trending.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TrendingData>[];
      json['data'].forEach((v) {
        data!.add(new TrendingData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class TrendingData {
  int? skinId;
  int? categoryId;
  String? skinName;
  String? skinThumbnail;
  String? skinBundle;
  String? skinDownloads;
  String? skinLikes;
  String? skinViews;
  String? skinType;
  String? skinStatus;
  bool? isLike = false;

  TrendingData(
      {this.skinId,
        this.categoryId,
        this.skinName,
        this.skinThumbnail,
        this.skinBundle,
        this.skinDownloads,
        this.skinLikes,
        this.skinViews,
        this.skinType,
        this.isLike,
        this.skinStatus});

  TrendingData.fromJson(Map<String, dynamic> json) {
    skinId = json['skin_id'];
    categoryId = json['category_id'];
    skinName = json['skin_name'];
    skinThumbnail = json['skin_thumbnail'];
    skinBundle = json['skin_bundle'];
    skinDownloads = json['skin_downloads'];
    skinLikes = json['skin_likes'];
    skinViews = json['skin_views'];
    skinType = json['skin_type'];
    skinStatus = json['skin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skin_id'] = this.skinId;
    data['category_id'] = this.categoryId;
    data['skin_name'] = this.skinName;
    data['skin_thumbnail'] = this.skinThumbnail;
    data['skin_bundle'] = this.skinBundle;
    data['skin_downloads'] = this.skinDownloads;
    data['skin_likes'] = this.skinLikes;
    data['skin_views'] = this.skinViews;
    data['skin_type'] = this.skinType;
    data['skin_status'] = this.skinStatus;
    return data;
  }

}