// To parse this JSON data, do
//
//     final resGetBerita = resGetBeritaFromJson(jsonString);

import 'dart:convert';

ResGetBerita resGetBeritaFromJson(String str) =>
    ResGetBerita.fromJson(json.decode(str));

String resGetBeritaToJson(ResGetBerita data) => json.encode(data.toJson());

class ResGetBerita {
  ResGetBerita({
    this.isSucces,
    this.message,
    this.data,
  });

  bool? isSucces;
  String? message;
  List<Datum>? data;

  factory ResGetBerita.fromJson(Map<String, dynamic> json) => ResGetBerita(
        isSucces: json["is succes"] == null ? null : json["is succes"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is succes": isSucces == null ? null : isSucces,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.judul,
    this.isiBerita,
    this.gambarBerita,
    this.tglBerita,
  });

  String? id;
  String? judul;
  String? isiBerita;
  String? gambarBerita;
  DateTime? tglBerita;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        judul: json["judul"] == null ? null : json["judul"],
        isiBerita: json["isi_berita"] == null ? null : json["isi_berita"],
        gambarBerita:
            json["gambar_berita"] == null ? null : json["gambar_berita"],
        tglBerita: json["tgl_berita"] == null
            ? null
            : DateTime.parse(json["tgl_berita"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "judul": judul == null ? null : judul,
        "isi_berita": isiBerita == null ? null : isiBerita,
        "gambar_berita": gambarBerita == null ? null : gambarBerita,
        "tgl_berita": tglBerita == null ? null : tglBerita!.toIso8601String(),
      };
}
