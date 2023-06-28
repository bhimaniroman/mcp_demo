class ViewModel {
  List<bool>? data;
  String? message;

  ViewModel({this.data, this.message});

  ViewModel.fromJson(Map<bool, dynamic> json) {
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}