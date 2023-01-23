import 'package:flutter/material.dart';
import 'package:movies_n_tvshows_app/layar/layar_utama.dart';

class Opening extends StatelessWidget {
  const Opening({Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Movies & Tv Shows.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.purpleAccent, fontSize: 35),
                children: [
                  TextSpan(
                    text: "movies",
                  ),
                  TextSpan(
                    text: "&TVSHOWS.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LayarUtama(),
                    ),
                  );
                },
                child: TombolMasuk(
                  text: "Klik Masuk",
                  ukuranFont: 20,
                  verticalPadding: 16,
                  tekan: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TombolMasuk extends StatelessWidget {
  final String text;
  final Function tekan;
  final double verticalPadding;
  final double ukuranFont;

  const TombolMasuk({
    Key key,
    this.text,
    this.tekan,
    this.verticalPadding = 16,
    this.ukuranFont = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 15),
              blurRadius: 30,
              color: const Color(0xFF11BAC0).withOpacity(.84)),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: ukuranFont,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 20, 202, 117),
        ),
      ),
    );
  }
}
