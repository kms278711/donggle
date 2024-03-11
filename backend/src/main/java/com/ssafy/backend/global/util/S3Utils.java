package com.ssafy.backend.global.util;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.ssafy.backend.global.error.exception.ExceptionType;
import com.ssafy.backend.global.error.exception.FileException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;

@Service
public class S3Utils {

    @Value("${cloud.aws.s3.bucket}")
    String bucket;

    @Autowired
    private AmazonS3Client amazonS3Client;

    // 폴더 생성
    public void createFolder(String bucketName, String folderName) {
        amazonS3Client.putObject(bucketName, folderName + "/", new ByteArrayInputStream(new byte[0]), new ObjectMetadata());
    }

    // 파일 업로드
    public void fileUpload(String folderName, String fileName, MultipartFile file) throws Exception {
        if(amazonS3Client != null) {

            if(!file.isEmpty()) {
                createFolder(bucket + "/contact", folderName);
            }

            ObjectMetadata objectMetadata = new ObjectMetadata();
            objectMetadata.setContentType(file.getContentType());
            objectMetadata.setContentLength(file.getSize());
            objectMetadata.setHeader("filename", file.getOriginalFilename());
            amazonS3Client.putObject(new PutObjectRequest(bucket + "/" + folderName, file.getName(), file.getInputStream(), objectMetadata));
        } else {
            throw new FileException(ExceptionType.AWS_UPLOAD_FAIL);
        }
    }

    // 다중 파일 삭제
    public void fileDelete(String filePath, String fileName) {
        if(amazonS3Client != null) {
            amazonS3Client.deleteObject(new DeleteObjectRequest(filePath, fileName));
        } else {
            throw new FileException(ExceptionType.AWS_DELETE_FAIL);
        }
    }
    
}
