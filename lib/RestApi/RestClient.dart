import 'dart:convert';
import 'package:crud/Style/style.dart';
import 'package:http/http.dart' as http;

Future<List> ProductGridViewListRequest() async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {'Content-Type': "application/json"};
  var response = await http.get(URL, headers: PostHeader);
  var Resultcode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (Resultcode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    return ResultBody['data'];
  } else {
    ErrorToast('Request Failed! Try Again');
    return [];
  }
}

Future<bool> ProductCreateRequest(FormValues) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody = json.encode(FormValues);
  var PostHeader = {'Content-Type': "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var Resultcode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (Resultcode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Failed! Try Again');
    return false;
  }
}

Future<bool> ProductUpdateRequest(FormValues, id) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/" + id);
  var PostBody = json.encode(FormValues);
  var PostHeader = {'Content-Type': "application/json"};
  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var Resultcode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (Resultcode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Update Success');
    return true;
  } else {
    ErrorToast('Update Failed! Try Again');
    return false;
  }
}

Future<bool> ProductDeleteRequest(id) async {
  var URL = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/' + id);
  var PostHeader = {'Content-Type': "application/json"};
  var response = await http.get(URL, headers: PostHeader);
  var Resultcode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (Resultcode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Failed! Try Again');
    return false;
  }
}
