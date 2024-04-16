package com.study.board.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
public class SearchResultsController {

    @Autowired
    private NaverSearchService naverSearchService;

    @PostMapping("/searchResults")
    @ResponseBody
    public List<SearchResult> getSearchResults(@RequestParam String query, @RequestParam int start) {
        try {
            // 검색어를 UTF-8로 인코딩
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);
            // 인코딩된 검색어를 네이버 검색 서비스에 전달
            return naverSearchService.search(encodedQuery, start);
        } catch (Exception e) {
            e.printStackTrace();
            // 검색 실패 시 처리할 코드 작성
            return null;
        }
    }
}