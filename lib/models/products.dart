part of 'models.dart';

class Products extends Equatable {
  final String id;
  final String ads;
  final String description;
  final String image;

  Products(this.id, this.ads, this.description, this.image);

  @override
  List<Object> get props => [id, ads, description, image];
}
