package com.ssafy.backend.domain.approval.service.impl;

import com.ssafy.backend.domain.approval.dto.ApprovalDto;
import com.ssafy.backend.domain.approval.dto.request.ApprovalRequestDto;
import com.ssafy.backend.domain.approval.dto.request.BootpayRequestDto;
import com.ssafy.backend.domain.approval.dto.response.ApprovalResponseDto;
import com.ssafy.backend.domain.approval.entity.Approval;
import com.ssafy.backend.domain.approval.mapper.ApprovalMapper;
import com.ssafy.backend.domain.approval.repository.ApprovalRepository;
import com.ssafy.backend.domain.approval.service.ApprovalService;
import com.ssafy.backend.domain.book.entity.Book;
import com.ssafy.backend.domain.book.repository.book.BookRepository;
import com.ssafy.backend.domain.book.repository.bookpurchased.BookPurchasedRepository;
import com.ssafy.backend.domain.user.entity.User;
import com.ssafy.backend.domain.user.repository.UserRepository;
import com.ssafy.backend.global.error.exception.UserException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.ssafy.backend.global.error.exception.ExceptionType.INVALID_USER;
import static com.ssafy.backend.global.error.exception.ExceptionType.NOT_FOUND_BOOK;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {

    private final UserRepository userRepository;
    private final BookRepository bookRepository;
    private final ApprovalMapper approvalMapper;
    private final ApprovalRepository approvalRepository;
    private final BookPurchasedRepository bookPurchasedRepository;

    // 결제 내역 저장
    @Override
    public void saveApproval(Long loginUserId, ApprovalRequestDto approvalRequestDto) {
        User userId = userRepository.findById(loginUserId)
                .orElseThrow(() -> new UserException(INVALID_USER));
        Book purchasedBookId = bookRepository.findById(approvalRequestDto.bookId())
                .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));

        if (approvalRequestDto.bootpayRequestDto().status() == 1) {
            ApprovalDto approvalDto = ApprovalDto.builder()
                    .price(purchasedBookId.getPrice())
                    .user(userId)
                    .book(purchasedBookId)
                    .build();

            Approval approval = approvalMapper.toApproval(approvalDto);
            approvalRepository.save(approval);
        } else if (approvalRequestDto.bootpayRequestDto().status() == 5) {
            String key = approvalRequestDto.bootpayRequestDto().orderId();
            List<Long> value = new ArrayList<>();
            value.add(purchasedBookId.getBookId());
            value.add(userId.getUserId());
            approvalRepository.bootpaySave(key, value, 3);
        }
    }

    // 부트페이
    @Override
    public void bootpay(BootpayRequestDto bootpayRequestDto) {
        System.out.println("bootpayRequestDto : " + bootpayRequestDto);

        String key = bootpayRequestDto.orderId();
        List<Long> value = approvalRepository.bootpayFind(key);
        if (bootpayRequestDto.status() == 1 && value != null) {
            approvalRepository.bootpayDelete(key);

            Long userId = value.get(1);
            Long bookId = value.get(0);
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new UserException(INVALID_USER));
            Book purchasedBookId = bookRepository.findById(bookId)
                    .orElseThrow(() -> new UserException(NOT_FOUND_BOOK));

            ApprovalDto approvalDto = ApprovalDto.builder()
                    .price(purchasedBookId.getPrice())
                    .user(user)
                    .book(purchasedBookId)
                    .build();

            Approval approval = approvalMapper.toApproval(approvalDto);
            approvalRepository.save(approval);
        }
    }


    // 결제 내역 조회
    @Override
    public List<ApprovalResponseDto> searchApprovals(Long loginUserId) {
        List<Approval> approvals = approvalRepository.findByUser_userId(loginUserId);
        List<ApprovalResponseDto> approvalList = approvals.stream()
                .map(approvalMapper::toApprovalResponseDto)
                .toList();
        return approvalList;
    }

}
