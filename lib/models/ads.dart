part of 'models.dart';

class Ads extends Equatable {
  final String id;
  final String ads;
  final String description;
  final String link;
  final String image;

  Ads(this.id, this.ads, this.description, this.link, this.image);

  @override
  List<Object> get props => [id, ads, description, link, image];
}
