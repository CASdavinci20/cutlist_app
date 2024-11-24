import 'dart:convert';

import 'package:app_framework/app_framework.dart';
import 'package:http/http.dart' as http;

import '../models/PublicVar.dart';
import '../models/error_messages.dart';
import '../models/urls.dart';
import '../utils/app_actions.dart';
import 'app_bloc.dart';

class Server {
  PubRequest _request = PubRequest();


  loadMyProject({AppBloc? appBloc, context}) async {
    await Server().getAction(appBloc: appBloc, url: Urls.cutProjects);
    var data= appBloc!.mapSuccess;
    appBloc.cutProject=data.reversed.toList();
    appBloc.hasProjects=true;

  }

  loadAllTask({AppBloc? appBloc, context,projectID}) async {
    await Server().getAction(appBloc: appBloc, url: Urls.allCutList);
    var respond=[];
    if(projectID!=null){
      respond= appBloc?.mapSuccess.where((item) {
        return item['project'] == projectID;
      }).toList();
      appBloc?.cutlistData=respond.reversed.toList();
    }else{
      respond=appBloc?.mapSuccess;
      appBloc?.cutAllTask=respond.reversed.toList();
    }


    appBloc?.hasTasks=true;
  }







  loadAData({AppBloc? appBloc, url}) async {
    var data =
        await _request.getRoute("${url}"!).timeout(Duration(seconds: 15));

    return data;
  }

  Future<bool> postAction({AppBloc? bloc, String? url, var data}) async {
    bool sent = false;
    if (PublicVar.appToken != "") {
      data.addAll({"token": PublicVar.appToken});
    }
    try {
      await _request.post(url!, data, (res) {
        print(res);
        if (getDataType(res) && res["error"] != null ) {
          bloc!.errorMsg = res["error"];
          sent = false;
        } else if ( res["msg"]!=null && res["data"] == null) {
          bloc!.errorMsg = res["msg"];
          sent = false;
        } else if ( res["msg"]!=null && res["type"] != "SUCCESS" && res["code"] != null) {

          bloc!.errorMsg = res["msg"];
          sent = false;
        } else {
          bloc!.mapSuccess = res;
          sent = true;
        }
      }).timeout(Duration(seconds: 15));
    } catch (e) {
      if (!PublicVar.onProduction)
        print('===========>>Post error ${e.toString()} $url');
      bloc!.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

  Future<bool> putAction({AppBloc? bloc, String? url, var data}) async {
    bool sent = false;
    if (PublicVar.appToken != "") {
      data.addAll({"token": PublicVar.appToken});
    }
    try {
      await _request.put(url!, data, (res) {
        if (!PublicVar.onProduction) print(res);
        if (getDataType(res) && res["error"] != null) {
          sent = false;
          bloc!.errorMsg = res["error"];
        } else {
          sent = true;
        }
      }).timeout(Duration(seconds: 15));
    } catch (e) {
      if (!PublicVar.onProduction)
        print('=========>>Put error ${e.toString()}');
      bloc!.errorMsg = PublicVar.serverError;
      sent = false;
    }

    return sent;
  }

  getDataType(data) {
    var has = false;
    if (data.runtimeType.toString() ==
        "_InternalLinkedHashMap<String, dynamic>") {
      has = true;
    }
    return has;
  }

  Future<bool> getAction({AppBloc? appBloc, String? url}) async {
    bool sent = false;
    try {
      var data = await _request.getRoute(url!, headers: {
        "authorization": "token ${PublicVar.appToken}"
      }).timeout(Duration(seconds: 15));

      if (getDataType(data) && data["error"] != null) {
        sent = false;
        appBloc!.errorMsg = data["error"];
      }else if(getDataType(data) && data["type"] == "UNAUTHORIZED"){
        sent = false;
        appBloc!.errorMsg = data["error"];
      } else {
        appBloc!.mapSuccess = data;
        sent = true;
      }
    } catch (e) {
      if (!PublicVar.onProduction) print('get error ${e.toString()}');
      appBloc!.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }

  uploadImg<bool>({AppBloc? appBloc, url, required Map data}) async {
    bool sent = false as bool;
    try {
      List fields = data.keys.toList();
      List files = data.values.toList();
      var request = http.MultipartRequest("POST", Uri.parse(url));
      for (var i = 0; i < fields.length; i++) {
        if (fields[i] == "image" || fields[i] == "kyc") {
          var pic = await http.MultipartFile.fromPath(
            fields[i],
            files[i].path,
          );
          request.files.add(pic);
        } else {
          request.fields.addAll({fields[i]: files[i]});
        }
      }

      var response = await request.send();
      var responseData =
          await response.stream.toBytes().timeout(Duration(seconds: 30));
      var responseString = String.fromCharCodes(responseData);
      var res = jsonDecode(responseString);
      if (getDataType(res) && ErrorMessages().getStatus(status: res["type"])) {
        sent = false as bool;
        appBloc!.errorMsg = res["message"];
      } else {
        appBloc!.mapSuccess = res;
        sent = true as bool;
      }
      if (!PublicVar.onProduction) print(responseString);
      return sent;
    } catch (e) {
      appBloc!.errorMsg = e.toString();
      if (!PublicVar.onProduction) print('Upload error ${e.toString()}');
      return sent;
    }
  }

  Future<bool> deleteAction({AppBloc? appBloc, var url, var data}) async {
    bool sent = false;

    try {
      if (PublicVar.appToken != "") {
        data.addAll({"token": PublicVar.appToken});
      }
      await _request.delete(url, data, (res) {
        print(res);
        if (getDataType(data) && data["error"] != null) {
          sent = false;
          appBloc!.errorMsg = data["error"];
        } else {
          appBloc!.mapSuccess = data;
          if (!PublicVar.onProduction) print('=========>>delete Success $res');
          sent = true;
        }
      }).timeout(Duration(seconds: 15));
    } catch (e) {
      if (!PublicVar.onProduction)
        print('=========>>delete error ${e.toString()}');
      appBloc!.errorMsg = PublicVar.serverError;
      sent = false;
    }
    return sent;
  }
}
