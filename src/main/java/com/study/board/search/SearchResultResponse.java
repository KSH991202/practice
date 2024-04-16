package com.study.board.search;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class SearchResultResponse {

    @JsonProperty("items")
    private List<SearchResult> items;

    // Getter 및 Setter 메서드

    public List<SearchResult> getItems() {
        return items;
    }

    public void setItems(List<SearchResult> items) {
        this.items = items;
    }
}
