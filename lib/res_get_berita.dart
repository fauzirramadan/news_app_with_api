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
    this.idBerita,
    this.judul,
    this.isi,
    this.foto,
    this.tglBerita,
  });

  String? idBerita;
  String? judul;
  String? isi;
  String? foto;
  DateTime? tglBerita;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idBerita: json["id_berita"] == null ? null : json["id_berita"],
        judul: json["judul"] == null ? null : json["judul"],
        isi: json["isi"] == null ? null : json["isi"],
        foto: json["foto"] == null ? null : json["foto"],
        tglBerita: json["tgl_berita"] == null
            ? null
            : DateTime.parse(json["tgl_berita"]),
      );

  Map<String, dynamic> toJson() => {
        "id_berita": idBerita == null ? null : idBerita,
        "judul": judul == null ? null : judul,
        "isi": isi == null ? null : isi,
        "foto": foto == null ? null : foto,
        "tgl_berita": tglBerita == null ? null : tglBerita!.toIso8601String(),
      };
}
