import 'dart:math';

import 'package:ham_tools/pages/vika/vika_db.dart';
import 'package:ham_tools/pages/vika/vika_properties.dart';
import 'package:ham_tools/pojos/vika_data.dart';

import '../../pojos/user.dart';

class LoginData {
  Map<String, dynamic> vikaProps = VikaProperties().properties;


  /// find user
  Future<User> find(String userId) async {
    final String datasheetId = vikaProps['vika.user-db.datasheetId'];

    VikaRecord record = await VikaData().findRecord(datasheetId, userId);

    return User.fromJson(record.fields);
  }

  /// register user
  Future<User> register({String? name}) async {
    name ??= 'cqcq_${Random.secure().nextInt(999999)}';

    final String datasheetId = vikaProps['vika.user-db.datasheetId'];

    Map<String, dynamic> body = {
      "name": name,
      "createAt": DateTime.now().millisecondsSinceEpoch,
    };
    VikaRecord record = await VikaData().addRecord(datasheetId, body);

    return User.fromJson(record.fields);
  }
}
