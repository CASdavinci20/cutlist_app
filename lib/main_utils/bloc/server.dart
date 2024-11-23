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

  }

  loadResources({AppBloc? appBloc, context}) async {
    var hasResult = false;
    if (await Server().getAction(url: Urls.resourcesPublic, appBloc: appBloc)) {
      var res = appBloc!.mapSuccess;
      appBloc.resources = res;
      appBloc.hasResources = true;
      if (!PublicVar.onProduction) print(appBloc.resources);
      hasResult = true;
    } else {
      AppActions().showErrorToast(
        text: appBloc!.errorMsg,
        context: context,
      );
    }
    return hasResult;
  }

  searchResources({AppBloc? appBloc, context, data}) async {
    var hasResult = false;
    if (await Server().getAction(
        url: Urls.searchResources + "?query=${data}", appBloc: appBloc)) {
      var res = appBloc!.mapSuccess;
      appBloc.searchResources = res;
      appBloc.hasSearch = true;
      if (!PublicVar.onProduction) print(appBloc.searchResources);
      hasResult = true;
    } else {
      AppActions().showErrorToast(
        text: appBloc!.errorMsg,
        context: context,
      );
    }
    return hasResult;
  }

  loadCategoryResources({
    AppBloc? appBloc,
    context,
    queryType,
    queryData,
  }) async {
    var hasResult = false;
    print(Urls.resourcesPublic + "?${queryType}=${queryData}");

    if (await Server().getAction(
        url: Urls.resourcesPublic + "?${queryType}=${queryData}",
        appBloc: appBloc)) {
      var res = appBloc!.mapSuccess;

      appBloc.categoryResources = res;
      appBloc.hasCategoryResources = true;

      if (!PublicVar.onProduction) print(appBloc.categoryResources);
      hasResult = true;
    } else {
      AppActions().showErrorToast(
        text: appBloc!.errorMsg,
        context: context,
      );
    }
    return hasResult;
  }



  loadCategories({AppBloc? appBloc, context}) async {
    var hasResult = false;

    if (await Server().getAction(url: Urls.getCategories, appBloc: appBloc)) {
      appBloc!.categories = appBloc!.mapSuccess;
      await Server().getAction(url: Urls.resourcesTypes, appBloc: appBloc);
      appBloc!.resourceTypes = appBloc!.mapSuccess;

      appBloc.hasCategories = true;

      if (!PublicVar.onProduction) print(appBloc.categories);
      if (!PublicVar.onProduction) print(appBloc.mapSuccess);
      hasResult = true;
    } else {
      AppActions().showErrorToast(
        text: appBloc!.errorMsg,
        context: context,
      );
    }
    return hasResult;
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
      await _request.delete(url, data, (res) {
        if (getDataType(res) &&
            ErrorMessages().getStatus(status: res["type"])) {
          sent = false;
          appBloc!.errorMsg = res["error"];
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
