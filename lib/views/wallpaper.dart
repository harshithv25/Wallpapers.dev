import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';

class WallpaperPreview extends StatefulWidget {
  final String imgSrc;
  final String url;
  final String original;
  WallpaperPreview({this.imgSrc, this.url, this.original});
  @override
  _WallpaperPreviewState createState() => _WallpaperPreviewState();
}

class _WallpaperPreviewState extends State<WallpaperPreview> {
  String _localpath;
  @override
  void initState() {
    super.initState();
  }

  static Future<bool> _checkAndGetPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }

  setWallpaper() async {
    if (_checkAndGetPermission() != null) {
      Dio dio = Dio();
      final Directory appDirectory = await getExternalStorageDirectory();
      final Directory directory =
          await Directory(appDirectory.path + '/wallpapers')
              .create(recursive: true);
      final String dir = directory.path;
      String localpath = "$dir/images.jpeg";

      try {
        dio.download(widget.imgSrc, localpath).then((value) {
          setState(() {
            _localpath = localpath;
          });
          Fluttertoast.showToast(
            msg: 'Setting wallpaper',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green,
          );
          Wallpaperplugin.setAutoWallpaper(localFile: _localpath).then(
            (value) {
              Fluttertoast.cancel();
              exit(0);
            },
          );
        });
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.all(80),
          minScale: 0.5,
          maxScale: 4,
          child: Hero(
            tag: widget.imgSrc,
            child: GestureDetector(
              onTap: () {
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                  msg: 'Double tap to set Wallpaper',
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.redAccent,
                );
              },
              onDoubleTap: () {
                setWallpaper();
              },
              child: Image(
                image: NetworkImage(
                  widget.imgSrc,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
