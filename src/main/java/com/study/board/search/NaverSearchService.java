package com.study.board.search;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Collections;
import java.util.List;

@Service
public class NaverSearchService {

    private final RestTemplate restTemplate;
    private final String apiUrl;
    private final String clientId;
    private final String clientSecret;

    public NaverSearchService(RestTemplate restTemplate,

            @Value("${naver.api.url}") String apiUrl,
            @Value("${naver.api.client-id}") String clientId,
            @Value("${naver.api.client-secret}") String clientSecret) {
        this.restTemplate = restTemplate;
        this.apiUrl = apiUrl;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }

    public List<SearchResult> search(String query, int start) {
        // 네이버 API 호출 및 결과 처리 코드
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.setContentType(MediaType.APPLICATION_JSON);
        System.out.println(apiUrl);

        String uriString = apiUrl + "?query=" + query + "&start=" + start;

        URI uri;
        try {
            uri = new URI(uriString);
        } catch (URISyntaxException e) {
            // URI가 잘못 구성되었을 경우 처리할 예외 처리 코드 작성
            e.printStackTrace();
            return Collections.emptyList();
        }
      
        System.out.println(uri);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<SearchResultResponse> responseEntity = restTemplate.exchange(
                uri, HttpMethod.GET, entity, SearchResultResponse.class);

        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            SearchResultResponse responseBody = responseEntity.getBody();
            if (responseBody != null) {
                return responseBody.getItems();
            }
        }

        return Collections.emptyList();
    }
}
