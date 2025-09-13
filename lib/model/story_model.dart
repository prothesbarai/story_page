class StoryModel{
  final String image;
  final String title;
  final String subtitle;
  final int duration;
  final String navigatePage;

  StoryModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.navigatePage,
  });

  factory StoryModel.fromJson(Map<String,dynamic> json){
    return StoryModel(
        image: json['image'],
        title: json['title'],
        subtitle: json['subtitle'],
        duration: json['duration'],
        navigatePage: json['navigatePage']
    );
  }

  Map<String, dynamic> toJson()=>{
    'image': image,
    'title': title,
    'subtitle': subtitle,
    'duration': duration,
    'navigatePage': navigatePage,
  };

}