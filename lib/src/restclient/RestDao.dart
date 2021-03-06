import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Dao.dart';
import 'AbstractRestriction.dart';

class RestClient implements Dao {
  static const String _host = "localhost";
  static const String _scheme = "http";
  static const String _path = "/";
  static const int _port = 8080;
  String loginToken;

  getLayout(String pageUri) async {
    var url = "layoutEngine/template${pageUri}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.get(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  findById(String className, num id) async {
    var url = "${className}/${id}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);

    var response = await http.get(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  getDefault(String className) async {
    var url = "${className}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);

    var response = await http.get(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  deleteById(String className, num id) async {
    var url = "${className}/${id}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);

    var response = await http.delete(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  findByPropertyKey(String className, {Map<String, String> params, num page : 0, num maxresults: 50}) async {
    processMap(params);
    var url = "${className}/find/${maxresults}/${page}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url, queryParameters: params);
    var response = await http.get(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;

  }

  findByPropertyKeyUnique(String className, {Map<String, String> params}) async {
    processMap(params);
    var url = "${className}/findunique";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url, queryParameters: params);
    var response = await http.get(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  save(Map model) async {
    var url = "save";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.post(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"}, body: json.encode(model));
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  saveList(List<Map> models) async {
    var url = "save";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.post(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"}, body: json.encode(models));
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }

  saveProperties(Map<String, String> params, String className, num id) async {
    var url = "save/${className}/${id}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url, queryParameters: params);
    var response = await http.put(uri.toString(), headers: {"Authorization": loginToken, "Content-Type" : "application/json"});
    setLoginToken(response);
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }


//  login() async {
//    String userName = "jgardner16@hotmail.com";
//    String password = "W1ndjammer*";
//
//    //var url = "http://192.168.1.6:8080/test/j_spring_security_check";
//    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    await firebaseAuth
//        .signInWithEmailAndPassword(email: userData.email, password: userData.password);
//
//  }

  setLoginToken(var response) {
    if (response.headers["Authorization"] != null) {
      loginToken = response.headers["Authorization"];
    } else {
      loginToken = response.headers["authorization"];
    }
  }

  Map<String, dynamic> processMap(Map<String, dynamic> params) {
    if (params != null) {
      for (final k in params.keys) {
        if (params[k] is AbstractRestriction) {
          String encoded = json.encode(params[k]);
          params[k] = encoded;
        }
      }
    }
    return params;
  }

}