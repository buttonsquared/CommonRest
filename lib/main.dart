library restclient;

import 'dart:async';
import 'package:CommonRest/RestClient.dart';



void main() {
  fetchData();

}

fetchData() async {
  RestClient client = new RestClient();
  await client.login();
  Future result2 = client.findByPropertyKey("com.busybee.toiletfinder.model.User", params: {"userName":"206408923"});
  Future.wait([result2]).then((test) {
      Map result = test[0];
      Map user = result["models"][0];
      user["fullName"] = "test1";
      client.save(user).then((model) => print("fullName=" + model["fullName"]));
  });

}