package com.study.board.search;

public class SearchResult {
    private String title;
    private String link;
    
    public SearchResult() {
        // 기본 생성자 내용 추가 (필요에 따라)
    }

    public SearchResult(String title, String link) {
        this.title = title;
        this.link = link;
    }

    // Getter 및 Setter 메서드

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    @Override
    public String toString() {
        return "SearchResult{" +
                "title='" + title + '\'' +
                ", link='" + link + '\'' +
                '}';
    }
}
