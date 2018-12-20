import 'dart:convert';
import 'dart:async';

import '../models/picture.dart';
import 'package:http/http.dart' as http;
import '../config.dart' ;


class PicsumService{

    List<Picture> _parsePhotos(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

      return parsed.map<Picture>((json) => Picture.fromJson(json)).toList();
    }

    Future<List<Picture>> getPictures() async{
        var response = await http.get(Config.picsumListUrl);
        if(response.statusCode == 200){
          return _parsePhotos(response.body);
        }

        throw Exception("Failed to load!");
    }
}