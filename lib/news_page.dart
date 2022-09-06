import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day3/api.dart';
import 'detail_berita.dart';
import 'res_get_berita.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isLoading = false;
  List<Datum> listBerita = [];

  Future<ResGetBerita?> getBerita() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse("$baseUrl/getBerita.php"));
      List<Datum>? data = resGetBeritaFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listBerita = data ?? [];
        log('data berita $listBerita');
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: const Text(
                "Popular",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            CarouselSlider(
                items: listBerita.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DetailBerita(e)));
                      },
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "$imageUrl${e.gambarBerita}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            e.judul.toString(),
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              backgroundColor: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                    height: 200, autoPlay: true, enlargeCenterPage: true)),
            const Text(
              "News Update",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listBerita.length,
                    itemBuilder: (context, index) {
                      Datum data = listBerita[index];
                      return Card(
                        color: Colors.white70,
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailBerita(data)));
                          },
                          leading: Hero(
                            tag: "$imageUrl${data.gambarBerita}",
                            child: Image.network(
                              "$imageUrl${data.gambarBerita}",
                              fit: BoxFit.fitWidth,
                              width: 100,
                            ),
                          ),
                          title: Text(
                            data.judul ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          subtitle: Text(data.tglBerita.toString()),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
