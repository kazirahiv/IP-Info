import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ip_info/IPInfoModel.dart';


class IPInfoRepo
{
  Future<IPInfoModel> getIPInfo(String ip) async
  {
    final result = await http.Client().get("http://www.ip-api.com/json/"+ip.trim());
    if(result.statusCode != 200)
      throw Exception();
    return parsedJson(result.body);
  }

  IPInfoModel parsedJson(final response)
  {
    final jsonIPInfo = json.decode(response);
    return IPInfoModel.fromJson(jsonIPInfo);
  }



}