class Chat {
  String _name;
  String _message;
  String _pictureURL;

  Chat(this._name, this._message, this._pictureURL);

  String get name => this._name;
  set name(String value) => this._name = value;

  String get message => this._message;
  set message(String value) => this._message = value;

  String get pictureURL => this._pictureURL;
  set pictureURL(String value) => this._pictureURL = value;
}
