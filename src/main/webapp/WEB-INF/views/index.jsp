<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>네이버 검색 API 예제</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      #searchForm {
        margin-bottom: 20px;
      }
      #query {
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 200px;
      }
      #searchButton {
        padding: 5px 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }
      #searchButton:hover {
        background-color: #0056b3;
      }
      #searchResults {
        margin-top: 20px;
      }
      #resultsList {
        list-style-type: none;
        padding: 0;
      }
      #resultsList li {
        margin-bottom: 10px;
      }
      #resultsList li a {
        color: #007bff;
        text-decoration: none;
      }
      #resultsList li a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <h1>네이버 검색 API 예제</h1>
    <form id="searchForm">
      <label for="query">검색어:</label>
      <input type="text" id="query" name="query" required />
      <label for="blogUrl">블로그 URL:</label>
      <input type="text" id="blogUrl" name="blogUrl" required />
      <button type="button" id="searchButton">검색</button>
    </form>

    <div id="searchResults">
      <h2>검색 결과</h2>
      <ul id="resultsList"></ul>
      <div id="pagination">
        <button type="button" id="prevButton">이전</button>
        <button type="button" id="nextButton">다음</button>
      </div>
    </div>

    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
      (() => {

        let start = 1;

        const searchBtn = document.querySelector("#searchButton");
        const searchForm = document.querySelector("#searchForm");
        const resultsList = document.querySelector("#resultsList");
        const nextBtn = document.getElementById('nextButton');
        const prevBtn = document.getElementById('prevButton');

        // 검색 버튼 클릭 이벤트 리스너
        searchBtn.addEventListener("click", () => {
          const $query = document.querySelector("#query").value.trim();
          const blogUrl = document.querySelector("#blogUrl").value.trim();
          if ($query !== "" && blogUrl !== "") {
            start = 1;
            searchResults($query, blogUrl, start);
          }
        });

        // 검색 폼 제출 이벤트 리스너
        searchForm.addEventListener("submit", (event) => {
          event.preventDefault(); // 기본 제출 동작 막기
          const $query = document.querySelector("#query").value.trim();
          const blogUrl = document.querySelector("#blogUrl").value.trim();
          if ($query !== "" && blogUrl !== "") {
            start = 1;
            searchResults($query, blogUrl, start);
          }
        });
        function searchResults(query, blogUrl, start) {
          $.ajax({
            url: "/searchResults",
            type: "POST",
            data: { query: query, blogUrl: blogUrl, start: start },
            success: function (results) {
              resultsList.innerHTML = ""; // 기존 결과 비우기
              if (results.length > 0) {
                let blogPosition = null;
                results.forEach((result, index) => {
                  const listItem = document.createElement("li");
                  const link = document.createElement("a");
                  link.href = result.link;
                  link.target = "_blank";
                  link.textContent = removeHtmlTags(result.title);
                  listItem.appendChild(link);
                  resultsList.appendChild(listItem);

                  // 블로그의 위치가 계산되었으면 더 이상의 계산은 필요하지 않음
                  if (result.link === blogUrl) {
                    blogPosition = index + 1;
                    if (blogPosition !== null) {
                      const positionItem = document.createElement("span");
                      positionItem.textContent = " - 이 블로그는 검색 결과 중 " + blogPosition + "번째에 있습니다.";
                      resultsList.querySelector("li:last-child").appendChild(positionItem);
                      }
                    else {
                      const listItem = document.createElement("li");
                      listItem.textContent = "검색 결과가 없습니다.";
                      resultsList.appendChild(listItem);
                    } 
                  } 
                  else{
                    return;
                  }
                });
            }},
            error: function (xhr, status, error) {
              console.error("Request failed:", error);
            },
          });
        }


        // 다음 버튼 클릭 이벤트
        nextBtn.addEventListener('click', ()=>{
          start += 10;
          const query = document.querySelector("#query").value.trim();
          const blogUrl = document.querySelector("#blogUrl").value.trim();
          searchResults(query, blogUrl, start);
        })

        // 이전 버튼 클릭 이벤트
        prevBtn.addEventListener('click', ()=>{
          start -= 10;
          if (start < 1) {
            start = 1;
          }
          const query = document.querySelector("#query").value.trim();
          const blogUrl = document.querySelector("#blogUrl").value.trim();
          searchResults(query, blogUrl, start);
        })

        // HTML 태그 제거 함수
        function removeHtmlTags(text) {
          return text.replace(/<[^>]*>?/gm, "");
        }

      })();
    </script>
  </body>
</html>
