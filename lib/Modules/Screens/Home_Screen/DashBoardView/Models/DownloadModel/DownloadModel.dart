class Download {
  List<bool>? data;
  String? message;

  Download({this.data, this.message});

  Download.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<bool>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}