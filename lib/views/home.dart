import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpapersdev/data/data.dart';
import 'package:wallpapersdev/modal/categories.dart';
import 'package:wallpapersdev/modal/wallpaper.dart';
import 'package:wallpapersdev/widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModal> categories = new List();
  List<Wallpaper> wallpapers = new List();
  bool isLoading = false;
  TextEditingController querry = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  ScrollController _controller = new ScrollController();
  Timer timer;

  @override
  void initState() {
    categories = getCategories();
    getWallpapers(false);
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: 'Double tap to set Wallpaper',
      backgroundColor: Colors.redAccent,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    new Timer(new Duration(minutes: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: Duration(seconds: 5),
      );
    });
    new Timer(new Duration(seconds: 75), () {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: Duration(seconds: 5),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  getWallpapers(bool loadMore) async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(
      'https://api.pexels.com/v1/curated?per_page=55',
      headers: {'Authorization': API_KEY},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData['photos'].forEach((item) {
        Wallpaper wallpaper = new Wallpaper();
        setState(() {
          isLoading = false;
          wallpaper = Wallpaper.fromMap(item);
          wallpapers.add(wallpaper);
        });
      });
    });
  }

  searchWallpapers() async {
    if (querry.text.isNotEmpty) {
      setState(() {
        isLoading = true;
        wallpapers = [];
      });
      var response = await http.get(
        'https://api.pexels.com/v1/search?query=${querry.text}&per_page=60&page=1',
        headers: {'Authorization': API_KEY},
      ).then((value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData['photos'].forEach((item) {
          Wallpaper wallpaper = new Wallpaper();
          setState(() {
            isLoading = false;
            wallpaper = Wallpaper.fromMap(item);
            wallpapers.add(wallpaper);
          });
        });
      });
    }
  }

  searchCategs(String categ) async {
    setState(() {
      isLoading = true;
      wallpapers = [];
    });
    if (categ.toLowerCase() == 'all') {
      var response = await http.get(
        'https://api.pexels.com/v1/curated?per_page=55',
        headers: {'Authorization': API_KEY},
      ).then((value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData['photos'].forEach((item) {
          Wallpaper wallpaper = new Wallpaper();
          setState(() {
            isLoading = false;
            wallpaper = Wallpaper.fromMap(item);
            wallpapers.add(wallpaper);
          });
        });
      });
    } else {
      var response = await http.get(
        'https://api.pexels.com/v1/search?query=$categ&per_page=60&page=1',
        headers: {'Authorization': API_KEY},
      ).then((value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData['photos'].forEach((item) {
          Wallpaper wallpaper = new Wallpaper();
          setState(() {
            isLoading = false;
            wallpaper = Wallpaper.fromMap(item);
            wallpapers.add(wallpaper);
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 28, 33, 1),
        title: mainAppBar(),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(210, 210, 210, 1),
                  border: Border.all(
                    color: Colors.lightBlueAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: querry,
                          decoration: InputDecoration(
                            hintText: 'Search Images',
                            hintStyle: TextStyle(color: Colors.black45),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.black,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 13,
                        ),
                        child: Icon(Icons.search),
                      ),
                      onTap: () {
                        if (querry.text.isNotEmpty) {
                          searchWallpapers();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              wallpapers.length == 0
                  ? Container(
                      height: 80,
                    )
                  : Container(
                      height: 80,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              searchCategs(categories[index].categoryName);
                            },
                            child: Categs(
                              imgUrl: categories[index].categoryImg,
                              title: categories[index].categoryName,
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 20,
                  top: 0,
                ),
                child: wallpapers.length == 0
                    ? Container(
                        width: double.maxFinite,
                        child: Center(
                          widthFactor: double.maxFinite,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black87,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.lightGreenAccent,
                              ),
                            ),
                          ),
                        ),
                      )
                    : gridView(
                        context: context,
                        wallpapers: wallpapers,
                        controller: _controller,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categs extends StatelessWidget {
  final String imgUrl, title;
  Categs({this.imgUrl, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(40, 54, 61, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgUrl,
                colorBlendMode: BlendMode.srcOver,
                color: Color.fromRGBO(0, 0, 0, .6),
                height: 70,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.chelseaMarket(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
