package com.ssafy.backend.domain.user.service.impl;

import com.ssafy.backend.domain.user.service.OauthInterface;
import net.minidev.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriBuilder;

import java.util.Map;

public class OauthServieImpl implements OauthInterface {
	@Override
	public Map<String, Object> getUserInfo(String publisher ,String accessToken) {
		String baseUrl = "";
		if(publisher.equals("NAVER")) {
			baseUrl = "https://openapi.naver.com/v1/nid/me";
		} else if(publisher.equals("GOOGLE")) {
			baseUrl = "https://oauth2.googleapis.com/tokeninfo";
		}

		// 사용자 정보 요청하기
		WebClient webclient = WebClient.builder()
				.baseUrl(baseUrl)
				.defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.build();

		JSONObject response = webclient.get()
				.uri(UriBuilder::build)
				.header("Authorization", "Bearer " + accessToken)
				.retrieve()
				.bodyToMono(JSONObject.class).block();
		return (Map<String, Object>) response.get("response");
	}
}
