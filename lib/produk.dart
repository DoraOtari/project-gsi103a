class Produk {
  final int id;
  final String title;
  final num price;
  final String description;
  final String image;
  final num rate;
  final int count;

  Produk({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Produk.fromJson(Map<String,dynamic> json){
    return Produk(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      rate: json['rating']['rate'],
      count: json['rating']['count'],
      );
  }
}
