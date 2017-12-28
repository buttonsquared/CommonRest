import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Dao.dart';

class RestClient implements Dao {
  static const String _host = "192.168.1.3";
  static const String _scheme = "http";
  static const String _path = "/test/rest/v1/";
  static const int _port = 8080;
  String sessionId;

  getLayout(String pageUri) async {
    var url = "layoutEngine/template/${pageUri}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.read(uri.toString(), headers: {"cookie": sessionId});
    Map<String, dynamic> result = JSON.decode(response);
    return result;
  }

  findById(String className, num id) async {
    if (sessionId == null) {
      await login();
    }
    var url = "${className}/${id}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);

    var response = await http.read(uri.toString(), headers: {"cookie": sessionId});
    Map<String, dynamic> result = JSON.decode(response);
    return result;
  }

  deleteById(String className, num id) async {
    if (sessionId == null) {
      await login();
    }
    var url = "${className}/${id}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);

    var response = await http.delete(uri.toString(), headers: {"cookie": sessionId});
    Map<String, dynamic> result = JSON.decode(response);
    return result;
  }

  findByPropertyKey(String className, {Map<String, String> params, num page : 0, num maxresults: 50}) async {
    var url = "${className}/find/${maxresults}/${page}";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url, queryParameters: params);
    var response = await http.read(uri.toString(), headers: {"cookie": sessionId});
    Map<String, dynamic> result = JSON.decode(response);
    return result;

  }

  findByPropertyKeyUnique(String className, {Map<String, String> params}) async {
    var url = "${className}/findunique";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url, queryParameters: params);
    var response = await http.read(uri.toString(), headers: {"cookie": sessionId});
    Map<String, dynamic> result = JSON.decode(response);
    return result;
  }

  save(Map model) async {
    var url = "save";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.post(uri.toString(), headers: {"cookie": sessionId, "Content-Type" : "application/json"}, body: JSON.encode(model));
    Map<String, dynamic> result = JSON.decode(response.body);
    return result;
  }

  saveList(List<Map> models) async {
    var url = "save";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: _path + url);
    var response = await http.post(uri.toString(), headers: {"cookie": sessionId}, body: JSON.encode(models));
    Map<String, dynamic> result = JSON.decode(response);
    return result;
  }


  login() async {
    String userName = "206408923";
    String password = "W1ndjammer*";

    //var url = "http://192.168.1.6:8080/test/j_spring_security_check";
    Uri uri = new Uri(scheme: _scheme, host: _host, port: _port, path: "/test/j_spring_security_check");
    Map params = {"username":"206408923","password":"W1ndjammer*"};
    var response = await http.post(uri.toString(), body: params);
    String temp = response.headers['set-cookie'];
    sessionId = temp.substring(0, temp.indexOf(";"));
    print("sessionId=" + sessionId);
    
  }
}