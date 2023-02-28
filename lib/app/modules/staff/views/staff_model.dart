class BukuModel {
  int? idBuku, jumlahBuku;
  String? namaBuku;

  BukuModel({this.idBuku, this.namaBuku, this.jumlahBuku});

  factory BukuModel.fromjson(Map<String, dynamic> json) {
    return BukuModel(
        idBuku: json['id_buku'],
        namaBuku: json['namaBuku'],
        jumlahBuku: json['jumlahBuku']);
  }
}

class PinjamModel {
  int? idPinjam;
  String? namaBukup, namaPeminjam, tanggalPinjam;

  PinjamModel(
      {this.idPinjam, this.namaBukup, this.tanggalPinjam, this.namaPeminjam});

  factory PinjamModel.fromjson(Map<String, dynamic> json) {
    return PinjamModel(
        idPinjam: json['id_pinjam'],
        namaBukup: json['namaBukup'],
        namaPeminjam: json['namaPeminjam'],
        tanggalPinjam: json['tanggalPinjam']);
  }
}
