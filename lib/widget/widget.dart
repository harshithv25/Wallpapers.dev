import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpapersdev/modal/wallpaper.dart';
import 'package:wallpapersdev/views/wallpaper.dart';

Widget mainAppBar() {
  ScrollController _controller = new ScrollController();
  return Container(
    padding: EdgeInsets.only(top: 0),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            'Wallpapers',
            style: GoogleFonts.mcLaren(
              fontSize: 25,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 10,
          ),
          child: Text(
            '.dev',
            style: GoogleFonts.chelseaMarket(
              fontSize: 14,
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gridView(
    {List<Wallpaper> wallpapers, controller, context, bool notInternet}) {
  return Container(
    child: GridView.count(
      shrinkWrap: true,
      controller: controller,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      childAspectRatio: .6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(40, 54, 61, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WallpaperPreview(
                        imgSrc: wallpaper.src.portrait,
                        url: wallpaper.url,
                        original: wallpaper.src.original,
                      ),
                    ),
                  );
                },
                onDoubleTap: () {
                  Fluttertoast.showToast(msg: null);
                },
                child: Hero(
                  tag: wallpaper.src.portrait,
                  child: Image(
                    image: NetworkImage(
                      wallpaper.src.portrait,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
