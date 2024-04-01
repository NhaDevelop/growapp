class SliderData {
  int? id;
  String? link;
  int? linkId;
  String? name;
  int? status;
  String? type;
  String? sliderImage;

  SliderData(
      {this.id,
      this.link,
      this.linkId,
      this.name,
      this.status,
      this.type,
      this.sliderImage});

  factory SliderData.fromJson(Map<String, dynamic> json) {
    return SliderData(
      id: json['id'],
      link: json['link'],
      linkId: json['link_id'],
      name: json['name'],
      status: json['status'],
      type: json['type'],
      sliderImage: json['slider_image'],
    );
  }
}
