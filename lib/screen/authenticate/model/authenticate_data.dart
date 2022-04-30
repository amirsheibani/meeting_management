class AuthenticateData{
  String? username;
  String? password;

  String? accessToken;
  String? refreshToken;
  String? error;
  String? result;

  AuthenticateData({String? username, String? password, String? accessToken, String? refreshToken,String? error,int? result})
      :
        username = username ?? '',
        password = password ?? '',
        accessToken = accessToken ?? '',
        refreshToken = refreshToken ?? '',
        error = error ?? '',
        result = result != null ? result.toString() : ''
  ;

  AuthenticateData.fromJson(dynamic json) {
    accessToken = json['accessToken'] ?? '';
    refreshToken = json['refreshToken'] ?? '';
    result = json['result'] != null ?  (json['result'] as int).toString() : '';
    error = json['error'] ?? '';
  }
}