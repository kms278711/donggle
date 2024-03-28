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
	private final OauthInterface oauthInterface;

	@RequestMapping(value = "/sns-login", method = {RequestMethod.GET,
			RequestMethod.POST}, produces = "application/json")
	public ResponseEntity<TokenDto> oauthLogin(@RequestParam String publisher,
											   @RequestParam(required = false) String token,
											   @RequestParam(required = false) String email) {
		UserInfoDto userInfoDto = null;
		if(publisher.equals("NAVER")) {
			userInfoDto = authService.SNSLogin(publisher, email);
		} else {
			Map<String, Object> userinfo  = oauthInterface.getUserInfo(publisher, token);
			userInfoDto = authService.SNSLogin(publisher, (String) userinfo.get("email"));
		}
		TokenDto tokenDto = jwtService.issueToken(userInfoDto);
		return ResponseEntity.ok(tokenDto);
	}

}