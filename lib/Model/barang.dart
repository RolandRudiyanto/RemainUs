class Barang{

  String nama;
  String gambarPath;
  int harga;
  int quantity;

  Barang({required this.nama, required this.gambarPath, required this.harga,required this.quantity});
}

List<Barang> barang =[
  Barang(nama: "Sabun",gambarPath: "asstes/1.jpeg",harga: 3000, quantity: 0),
  Barang(nama: "Shampoo",gambarPath: "asstes/2.jpeg",harga: 30000,quantity: 0),
  Barang(nama: "Datergen",gambarPath: "asstes/3.jpeg",harga: 50000,quantity: 0),
  Barang(nama: "Odol",gambarPath: "asstes/4.jpeg",harga: 5000,quantity: 0),
  Barang(nama: "Nugget",gambarPath: "asstes/5.jpeg",harga: 30000,quantity: 0),
  Barang(nama: "Sambal",gambarPath: "asstes/6.jpeg",harga: 20000,quantity: 0),
  Barang(nama: "Indomie",gambarPath: "asstes/7.jpeg",harga: 110000,quantity: 0),
  Barang(nama: "Minyak",gambarPath: "asstes/8.jpeg",harga: 45000,quantity: 0),
  Barang(nama: "Beras",gambarPath: "asstes/9.jpeg",harga: 64000,quantity: 0),
  Barang(nama: "Kecap",gambarPath: "asstes/10.jpeg",harga: 10000,quantity: 0),

];