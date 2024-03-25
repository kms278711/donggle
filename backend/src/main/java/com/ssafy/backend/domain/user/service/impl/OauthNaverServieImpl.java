package com.ssafy.backend.domain.user.service.impl;

import com.ssafy.backend.domain.user.service.OauthInterface;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Map;

public class OauthNaverServieImpl implements OauthInterface {
	@Value("${spring.security.oauth2.client.provider.naver.authorization-uri}")
	private String naverURI;
	@Value("${spring.security.oauth2.client.registration.naver.client-id}")
	private String clientId;
	@Value("${spring.security.oauth2.client.registration.naver.client-secret}")
	private String clientSecret;
	@Value("${spring.security.oauth2.client.registration.naver.redirect-uri}")
	private String redirectURI;
	@Value("${spring.security.oauth2.client.registration.naver.authorization-grant-type}")
	private String grantType;

	public String getURI() {
		// state용 난수 생성
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);

		String URI = naverURI + "?" +
				"client_id=" + clientId +
				"&response_type=code" +
				"&redirect_uri=" + redirectURI +
				"&state=" + state;
		return URI;
	}

	@Override
	public String getToken(String state, String code) {
		// 네이버에 요청 보내기
		WebClient webclient = WebClient.builder()
				.baseUrl("https://nid.naver.com")
				.defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.build();

		JSONObject response = webclient.post()
				.uri(uriBuilder -> uriBuilder
						.path("/oauth2.0/token")
						.queryParam("client_id", clientId)
						.queryParam("client_secret", clientSecret)
						.queryParam("grant_type", grantType)
						.queryParam("state", state)
						.queryParam("code", code)
						.build())
				.retrieve().bodyToMono(JSONObject.class).block();
		return (String) response.get("access_token");
	}

	@Override
	public Map<String, Object> getUserInfo(String accessToken) {
		// 사용자 정보 요청하기
		WebClient webclient = WebClient.builder()
				.baseUrl("https://openapi.naver.com")
				.defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.build();

		JSONObject response = webclient.get()
				.uri(uriBuilder -> uriBuilder
						.path("/v1/nid/me")
						.build())
				.header("Authorization", "Bearer " + accessToken)
				.retrieve()
				.bodyToMono(JSONObject.class).block();
		// 원하는 정보 추출하기
		return (Map<String, Object>) response.get("response");
	}
}
