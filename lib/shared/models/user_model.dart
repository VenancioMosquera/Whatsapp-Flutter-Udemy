class UserModel {
  String? _name;
  String? _email;
  String? _password;
  String? _pictureUrl;
  String? _id;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this._name,
      "e-mail": this._email,
    };
    if (this._pictureUrl != null) {
      map = {"pictureUrl": this._pictureUrl};
    }
    return map;
  }

  String? get name => this._name;
  set name(String? value) => this._name = value;

  String? get email => this._email;
  set email(String? value) => this._email = value;

  String? get password => this._password;
  set password(String? value) => this._password = value;

  String? get pictureUrl => this._pictureUrl;
  set pictureUrl(String? value) => this._pictureUrl = value;

  String? get id => this._id;
  set id(String? value) => this._id = value;
}
