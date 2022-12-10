class Post {
  String authorId;
  String titulo;
  String? photo;
  String descricao;
  Post(
      {
      required this.authorId,  
      required this.titulo,
      required this.descricao,
      this.photo});
}
