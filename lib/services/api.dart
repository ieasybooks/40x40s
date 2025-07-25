import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import '../helpers/consts.dart';

class Api {
  Future<Response> get(String url, Map body) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print(
        "GET URL: ${ //url.contains("auth") ? '$baseUrl$url?lang=$localCode' :
        '$baseUrl$url'}",
      );
    }
    Response response = await http.get(
      Uri.parse(
        //  url.contains("auth") ? '$baseUrl$url?lang=$localCode' :
        '$baseUrl$url',
      ),
      headers: {
        // HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
        'Accept': "application/json",
        'Content-Type': 'application/json',
        HttpHeaders.hostHeader: "raw.githubusercontent.com",
        HttpHeaders.acceptEncodingHeader: "gzip, deflate, br",
        HttpHeaders.connectionHeader: "keep-alive",
      },
    );
    if (response.statusCode == 401) {
      var refreshed = await refreshToken();
      if (refreshed.first) {
        return get(url, body);
      } else {}
    }
    if (kDebugMode) {
      print("GET SENT BODY : $body");
      print("GET STATUS CODE : ${response.statusCode}");
      print("GET RES BODY : ${response.body}");
    }

    return response;
  }

  Future<Response> post(String url, Map body) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    Response response = await http.post(
      Uri.parse(
        // url.contains("auth") ? '$baseUrl$url?lang=$localCode' :
        '$baseUrl$url',
      ),
      body: jsonEncode(body),
      headers: {
        // HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
        'Accept': "application/json",
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 401) {
      var refreshed = await refreshToken();
      if (refreshed.first) {
        return post(url, body);
      } else {}
    }

    if (kDebugMode) {
      print("POST URL: $baseUrl$url ");
      print("POST SENT BODY : $body");
      print("POST STATUS CODE : ${response.statusCode}");
      print("POST RES BODY : ${response.body}");
    }

    return response;
  }

  Future<Response> put(String url, Map body) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print(
        "PUT URL: $baseUrl$url ${ //url.contains("auth") ? '?lang=$localCode' :
        ''}",
      );
    }
    Response response = await http.put(
      Uri.parse(
        // '$baseUrl$url?lang=$localCode'.contains("auth")
        //     ? '$baseUrl$url?lang=$localCode'
        // :
        '$baseUrl$url',
      ),
      body: jsonEncode(body),
      headers: {
        // HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
        'Accept': "application/json",
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 401) {
      var refreshed = await refreshToken();
      if (refreshed.first) {
        return post(url, body);
      } else {}
    }
    if (kDebugMode) {
      print("PUT URL: $url ");
      print("PUT SENT BODY : $body");
      print("PUT STATUS CODE : ${response.statusCode}");
      print("PUT RES BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> delete(String url, Map body) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? localCode = prefs.getString('langCode');

    if (kDebugMode) {
      print(
        "DELETE URL: $baseUrl$url ${ //url.contains("auth") ? '?lang=$localCode' :
        ''}",
      );
    }
    Response response = await http.delete(
      Uri.parse(
        // url.contains("auth") ? '$baseUrl$url?lang=$localCode' :
        '$baseUrl$url',
      ),
      body: jsonEncode(body),
      headers: {
        // HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
        'Accept': "application/json",
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 401) {
      var refreshed = await refreshToken();
      if (refreshed.first) {
        return post(url, body);
      } else {}
    }
    if (kDebugMode) {
      print("DELETE URL: $url ");
      print("DELETE SENT BODY : $body");
      print("DELETE STATUS CODE : ${response.statusCode}");
      print("DELETE RES BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> upload(File file) async {
    var postUri = Uri.parse("$baseUrl/user/uploader");

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );

    request.headers['Accept'] = 'application/json';
    request.headers['content-type'] = 'application/json';
    request.headers['mostanad-auth-key'] = '0';
    request.files.add(multipartFile);

    StreamedResponse response = await request.send();

    return Response.fromStream(response);
  }

  Future<List> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print("REFRESH TOKEN URL: '/client/auth/refresh'");
    }
    bool refreshed = false;

    var response = await post("/client/auth/refresh", {});

    if (kDebugMode) {
      print("REFRESH RES API: ${response.body}");
    }

    if (response.body.toString() != 'null' && response.statusCode == 200) {
      if (response.body.toString().contains("access_token")) {
        await prefs.setString(
          "token",
          json.decode(response.body.toString())["access_token"],
        );
        refreshed = true;
      }
      refreshed = false;
    } else {}
    return [refreshed, response];
  }
}
