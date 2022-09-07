import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_day3/api.dart';
import 'package:flutter_day3/res_get_berita.dart';
import 'news_page.dart';

class DetailBerita extends StatefulWidget {
  final Datum? data;

  const DetailBerita(this.data, {Key? key}) : super(key: key);

  @override
  State<DetailBerita> createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Detail Berita"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                    tag: "$imageUrl${widget.data?.foto}",
                    child: Image.network("$imageUrl${widget.data?.foto}")),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.data?.judul}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "${widget.data?.isi}",
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
