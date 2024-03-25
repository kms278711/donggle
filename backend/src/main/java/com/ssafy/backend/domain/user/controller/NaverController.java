package com.ssafy.backend.domain.user.controller;

import com.ssafy.backend.domain.user.service.AuthService;
import com.ssafy.backend.global.jwt.dto.TokenDto;
import com.ssafy.backend.global.jwt.dto.UserInfoDto;
import com.ssafy.backend.global.jwt.service.JwtService;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.reactive.function.client.WebClient;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/naver")
public class NaverController {

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

	private final AuthService authService;
	private final JwtService jwtService;

	@GetMapping("/oauth")
	public String naverConnect() {
		// state용 난수 생성
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);

		// redirect
		String url = naverURI + "?" +
				"client_id=" + clientId +
				"&response_type=code" +
				"&redirect_uri=" + redirectURI +
				"&state=" + state;
		return "redirect:" + url;
	}

	@RequestMapping(value = "/callback", method = {RequestMethod.GET,
			RequestMethod.POST}, produces = "application/json")
	public ResponseEntity<TokenDto> naverLogin(@RequestParam(value = "code") String code,
											   @RequestParam(value = "state") String state) {
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

		// 네이버에서 온 응답에서 토큰을 추출
		String token = (String) response.get("access_token");
		Map<String, Object> userinfo = getUserInfo(token);
		UserInfoDto userInfoDto = authService.SNSLogin(userinfo);
		TokenDto tokenDto = jwtService.issueToken(userInfoDto);
		return ResponseEntity.ok(tokenDto);
	}

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