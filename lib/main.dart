library restclient;

import 'dart:async';
import 'dart:convert';
import 'package:CommonRest/RestClient.dart';



void main() {
  fetchData();

}

fetchData() async {
  GreaterThan test = new GreaterThan("5");
  String a = JSON.encode(test);

  RestClient client = new RestClient();
  client.processMap({"userName":test});
  Future result2 = client.findByPropertyKey("com.busybee.toiletfinder.model.User", params: {"userName":"jgardner16@hotmail.com"});
  Future.wait([result2]).then((test) {
      Map result = test[0];
      Map user = result["models"][0];
      user["fullName"] = "test1";
      client.save(user).then((model) => print("fullName=" + model["fullName"]));
  });

}