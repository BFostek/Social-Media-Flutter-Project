class Post {
  String titulo;
  String? photo;
  String descricao;
  String likes;
  Post(
      {required this.titulo,
      required this.descricao,
      required this.likes,
      this.photo});
}
