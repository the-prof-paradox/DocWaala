import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:open_file/open_file.dart';

class Scanning_Page extends StatefulWidget {
  @override
  _Scanning_PageState createState() => _Scanning_PageState();
}

class _Scanning_PageState extends State<Scanning_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan Documents'),
        ),
        body: Center(
          child: RaisedButton.icon(
            onPressed: () {
              FlutterGeniusScan.scanWithConfiguration({
                'source': 'camera',
                'multiPage': true,
              }).then((result) {
                String pdfUrl = result['pdfUrl'];
                OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
                        (result) => debugPrint(result.toString()),
                    onError: (error) => displayError(context, error));
              }, onError: (error) => displayError(context, error));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('START SCANNING',
              style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.scanner, color: Colors.white,),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.lightBlue,),
        )
    );
  }

  void displayError(BuildContext context, PlatformException error) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
  }
}
