package com.ssafy.backend.domain.user.controller;

import com.ssafy.backend.domain.user.service.AuthService;
import com.ssafy.backend.domain.user.service.OauthInterface;
import com.ssafy.backend.domain.user.service.impl.OauthNaverServieImpl;
import com.ssafy.backend.global.jwt.dto.TokenDto;
import com.ssafy.backend.global.jwt.dto.UserInfoDto;
import com.ssafy.backend.global.jwt.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/oauth")
public class OauthController {

	private final AuthService authService;
	private final JwtService jwtService;
	private OauthInterface oauthInterface;

	@GetMapping("/naver")
	public String naverConnect() {
		oauthInterface = new OauthNaverServieImpl();
		return "redirect:" + oauthInterface.getURI();
	}

	@RequestMapping(value = "/callback", method = {RequestMethod.GET,
			RequestMethod.POST}, produces = "application/json")
	public ResponseEntity<TokenDto> naverLogin(@RequestParam(value = "code") String code,
											   @RequestParam(value = "state") String state) {
		String token = oauthInterface.getToken(state, code);
		Map<String, Object> userinfo = oauthInterface.getUserInfo(token);
		UserInfoDto userInfoDto = authService.SNSLogin(userinfo);
		TokenDto tokenDto = jwtService.issueToken(userInfoDto);
		return ResponseEntity.ok(tokenDto);
	}

}