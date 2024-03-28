package com.ssafy.backend.domain.approval.repository;

import java.util.List;

public interface ApprovalCustomRepository {
    void bootpaySave(String key, List<Long> value, long expiresDay);
    List<Long> bootpayFind(String key);
    void bootpayDelete(final String key);
}
