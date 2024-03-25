package com.ssafy.backend.domain.user.service;

import java.util.Map;

public interface OauthInterface {
	String getURI();
	String getToken(String state, String code);
	Map<String, Object> getUserInfo(String accessToken);
}
