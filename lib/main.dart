import 'package:flutter/material.dart';

//import 'package:photos/model/photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    debugShowCheckedModeBanner: false,
    home: Photohome(),
  ));
}

class Photohome extends StatefulWidget {
  @override
  _PhotohomeState createState() => _PhotohomeState();
}

class _PhotohomeState extends State<Photohome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((data) {
      print(data);
    });
  }

  Future<String> getData() async {
    var url = "https://api.unsplash.com/photos/random/?client_id=e6f76dc639988b58680bf99205fa8fd9bf8d46b44d8d97d70debaf906456d0ab";
    String ret;
    var res = await http.get(url).then((data) {
      if (data.statusCode == 200) {
        ret = json.decode(data.body)['urls']['full'];
      } else {
        print('Not Found');
      }
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Photo')),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
          }),
      body: FutureBuilder<String>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data);
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
            //return Text('');
          }),
    );
  }
}


