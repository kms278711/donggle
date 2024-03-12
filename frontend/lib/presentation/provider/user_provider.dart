class UserProvider{
  String _email = "";
  String _access_token = "";
  String _refresh_token = "";

  void setEmail(String email){
    _email = email;
  }

  void setAccessToken(String accessToken){
    _access_token = accessToken;
  }

  void setRefreshToken(String refreshToken){
    _refresh_token = refreshToken;
  }

  String getEmail(){
    return _email;
  }

  String getAccessToken(){
    return _access_token;
  }

  String getRefreshToken(){
    return _refresh_token;
  }
}
