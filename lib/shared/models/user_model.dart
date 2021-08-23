class UserModel {
  String? _name;
  String? _email;
  String? _password;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": this._name,
      "e-mail": this._email,
    };
    return map;
  }

  String? get name => this._name;
  set name(String? value) => this._name = value;

  String? get email => this._email;
  set email(String? value) => this._email = value;

  String? get password => this._password;
  set password(String? value) => this._password = value;
}
