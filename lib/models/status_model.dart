
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusModel{
  String _packet="";
  String _quotation="";
  String _reference="";
  String _translation="";
  String _date="";
  StatusModel._constructor();

  static final _obj=StatusModel._constructor();
  factory StatusModel(){
    return _obj;
  }


  static StatusModel fromJsonToModel(List<QueryDocumentSnapshot<Map<String,dynamic>>>? docs){
    var status;
    docs?.forEach((doc) {
      Map<String,dynamic> v = doc.data();
      status = StatusModel();
      status.packet=v['packet'];
      status.quotation=v['quotation'];
      status.reference=v['reference'];
      status.translation=v['translation'];
      status.date=v['date'].toString();
    });
    print("after making obj");
    print(status);
    return status;
  }

  String get date => _date;

  String get translation => _translation;

  String get reference => _reference;

  String get quotation => _quotation;

  String get packet => _packet;

  set date(String value) {
    _date = value;
  }

  set translation(String value) {
    _translation = value;
  }

  set reference(String value) {
    _reference = value;
  }

  set quotation(String value) {
    _quotation = value;
  }

  set packet(String value) {
    _packet = value;
  }
}