
class BusinessDetailModel{
  String _name="";
  String _address="";
  String _phone="";
  String _type="";
  String _logo="";
  static bool hasBusinessDetail=false;

  BusinessDetailModel._constructor();
  static final _obj=BusinessDetailModel._constructor();

  factory BusinessDetailModel(){
    return _obj;
  }

  static fromJsonToModel(Map<String,dynamic>? map){
    _obj.name=map?["name"];
    _obj.address=map?["address"];
    _obj.phone=map?["phone"];
    _obj.type=map?["type"];
    _obj.logo=map?["logo"];
  }

  String get logo => _logo;

  String get type => _type;

  String get phone => _phone;

  String get address => _address;

  String get name => _name;

  set logo(String value) {
    _logo = value;
  }

  set type(String value) {
    _type = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set address(String value) {
    _address = value;
  }

  set name(String value) {
    _name = value;
  }
}