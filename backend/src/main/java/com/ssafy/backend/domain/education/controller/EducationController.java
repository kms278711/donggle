package com.ssafy.backend.domain.education.controller;

import com.ssafy.backend.domain.education.dto.response.EducationResponseDto;
import com.ssafy.backend.domain.education.service.EducationService;
import com.ssafy.backend.domain.user.dto.LoginUserDto;
import com.ssafy.backend.global.util.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/educations")
@RequiredArgsConstructor
public class EducationController {
	private final EducationService educationService;

	@GetMapping("/{educationId}")
	public ResponseEntity<EducationResponseDto> getEducation(Authentication authentication, @PathVariable Long educationId) {
		Long userId = AuthenticationUtil.getCurrentUserId(authentication);
		return ResponseEntity.ok(educationService.getEducation(userId, educationId));
	}
}
