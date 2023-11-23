class Barang{

  String nama;
  String gambarPath;
  int harga;

  Barang({required this.nama, required this.gambarPath, required this.harga});
}

List<Barang> belanjalist =[
  Barang(nama: "Sabun",gambarPath: "img/1.jpeg",harga: 3000),
  Barang(nama: "Shampoo",gambarPath: "img/2.jpeg",harga: 30000),
  Barang(nama: "Datergen",gambarPath: "img/3.jpeg",harga: 50000),
  Barang(nama: "Odol",gambarPath: "img/4.jpeg",harga: 5000),
  Barang(nama: "Nugget",gambarPath: "img/5.jpeg",harga: 30000),
  Barang(nama: "Sambal",gambarPath: "img/6.jpeg",harga: 20000),
  Barang(nama: "Indomie",gambarPath: "img/7.jpeg",harga: 110000),
  Barang(nama: "Minyak",gambarPath: "img/8.jpeg",harga: 45000),
  Barang(nama: "Beras",gambarPath: "img/9.jpeg",harga: 64000),
  Barang(nama: "Kecap",gambarPath: "img/10.jpeg",harga: 10000),

];