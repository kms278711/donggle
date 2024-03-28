package com.ssafy.backend.domain.approval.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.data.redis.core.RedisTemplate;

import java.time.Duration;
import java.util.List;

@RequiredArgsConstructor
@EnableAutoConfiguration(exclude = RedisAutoConfiguration.class)
public class ApprovalCustomRepositoryImpl implements ApprovalCustomRepository{

    private final RedisTemplate<String, Object> redisTemplate;

    public void bootpaySave(String key, List<Long> value, long expiresDay) {
        if (expiresDay > 0) {
            redisTemplate.opsForValue().set(key, value, Duration.ofDays(expiresDay));
        }
    }

    public List<Long> bootpayFind(String key) {
        List<Long> value = (List<Long>) redisTemplate.opsForValue().get(key);
        return value;
    }

    public void bootpayDelete(final String key) {
        redisTemplate.delete(key);
    }
}
