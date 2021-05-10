import 'package:equatable/equatable.dart';

class Recipt extends Equatable {
  final String id;
  final String judul;
  final String owner;
  final String highlight;
  final String code;
  final String imageH;

  Recipt(
      this.id,
      this.judul,
      this.owner,
      this.highlight,
      this.code,
      this.imageH);

  @override
  List<Object> get props => [
        id,
        judul,
        owner,
        highlight,
        code,
        imageH
      ];
}
