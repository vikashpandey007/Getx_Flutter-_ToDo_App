import 'dart:convert';

import 'package:get/get.dart';

import '../task_model.dart';
import 'package:http/http.dart' as http;

class TaskProvider {
  Future getTask() async {
    var headers = {
      'Authorization': 'token b7d395c0c20beae74101da3d07ed69cc93926e7d',
      'Accept': 'application/json',
      "Content-Type": 'application/x-www-form-urlencoded'
    };

    var url =
        Uri.parse('https://bodhiai.live/api/content/teacher_get_subjects/');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print(response.body.runtimeType);
      var jsonstring = jsonDecode(response.body);

      var data = jsonstring["subjects"] as List<dynamic>;
      print(data);

      return data;
    }
  }

  Future addTask(subjectName) async {
    print(subjectName);

    var headers = {
      'Authorization': 'token b7d395c0c20beae74101da3d07ed69cc93926e7d',
      'Accept': 'application/json',
      "Content-Type": 'application/x-www-form-urlencoded'
    };
    var body = {
      'subject_name': jsonEncode(subjectName),
    };

    var url = Uri.parse(
        'https://bodhiai.live/api/basicinformation/teacher_add_subject/');
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonstring = jsonDecode(response.body);
      print(jsonstring);

      return jsonstring;
    } else {
      print("No data");
    }
  }

  Future updateTask(subjectid, subjectname) async {
    print(subjectid);

    var headers = {
      'Authorization': 'token b7d395c0c20beae74101da3d07ed69cc93926e7d',
      'Accept': 'application/json',
      "Content-Type": 'application/x-www-form-urlencoded'
    };
    var body = {
      'subject_id': jsonEncode(subjectid),
      'subject_name': subjectname,
    };

    var url = Uri.parse(
        'https://bodhiai.live/api/basicinformation/teacher_edit_subject_name/');
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonstring = json.decode(response.body);
      print(jsonstring);

      return jsonstring;
    } else {
      print("No data");
    }
  }

  Future deleteTask(subjectId) async {
    print(subjectId);

    var headers = {
      'Authorization': 'token b7d395c0c20beae74101da3d07ed69cc93926e7d',
      'Accept': 'application/json',
      "Content-Type": 'application/x-www-form-urlencoded'
    };
    var body = {
      'subject_id': jsonEncode(subjectId),
    };

    var url = Uri.parse(
        'https://bodhiai.live/api/basicinformation/teacher_delete_subject/');
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonstring = jsonDecode(response.body);
      print(jsonstring);

      return jsonstring;
    } else {
      print("No data");
    }
  }
}
