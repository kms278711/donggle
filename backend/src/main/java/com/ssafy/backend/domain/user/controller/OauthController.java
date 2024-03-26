package com.ssafy.backend.domain.user.controller;

import com.ssafy.backend.domain.user.service.AuthService;
import com.ssafy.backend.domain.user.service.OauthInterface;
import com.ssafy.backend.global.jwt.dto.TokenDto;
import com.ssafy.backend.global.jwt.dto.UserInfoDto;
import com.ssafy.backend.global.jwt.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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

	@RequestMapping(value = "/callback", method = {RequestMethod.GET,
			RequestMethod.POST}, produces = "application/json")
	public ResponseEntity<TokenDto> naverLogin(@RequestParam String publisher,
											   @RequestParam String token) {
		Map<String, Object> userinfo = oauthInterface.getUserInfo(publisher, token);
		UserInfoDto userInfoDto = authService.SNSLogin(publisher, userinfo);
		TokenDto tokenDto = jwtService.issueToken(userInfoDto);
		return ResponseEntity.ok(tokenDto);
	}

}