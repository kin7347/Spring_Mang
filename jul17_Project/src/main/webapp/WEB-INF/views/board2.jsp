<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/board.css" rel="stylesheet">
<link href="./css/menu.css" rel="stylesheet">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//var list = [];  //보드 내용 가져오기
	let totalcount = 0;
	let pageNo = 1;
	
	ajax_call("1"); //ajax 호출
	function ajax_call(pageNo){	
	  $.ajax({
		url: "./boardList2", //http://localhost/boardList2?pageNo=1
		type: "get",
		data: {"pageNo" : pageNo},
		dataType: "json",
		success: function(data){
			totalCount = data.totalCount;
			pageNo = data.pageNo;
			let startPage = pageNo;
			let endPage = pageNo + 9;
			
			//console.log(totalCount);
			let list = data.list;
			$(".tableHead").empty();
			$(".paging").empty();
			let html = "";
			$.each(list, function(index){
			   html += "<tr>";
			   html += "<td>" + list[index].bno + "</td>";
			   html += "<td>" + list[index].btitle + "</td>";
			   html += "<td>" + list[index].m_name + "</td>";
			   html += "<td>" + list[index].bdate + "</td>";
			   html += "<td>" + list[index].blike + "</td>";
			   html += "</tr>";
			});
			$(".tableHead").append(html);
			
			/* for(let i = 0; i < list.length; i++){
				$(".tableHead").append(
				     "<tr><td>"+list[i].bno+"</td><td>"
					           +list[i].btitle+"</td><td>"
						       +list[i].m_name+"</td><td>"
						       +list[i].bdate+"</td><td>"
						       +list[i].blike+"</td></tr>"
					    );		
			} */
			//페이징하기
			let pages = totalCount / 10;
			//totalCount 나누기 10했을때 나머지가 있으면 pages + 1 해주기
			if(totalCount % 10 != 0){
				pages = pages + 1;
			}
			
			if(totalCount % 10 != 0){pages += 1;}
			startPage = pageNo;
			endPage = startPage + 10 < pages ? startPage + 9 : pages;
			
			//   << < 1 2 3 4 5 6 7 8 10 > >>
			if(pageNo - 10 > 0){
				$(".paging").append("<button class='start'>◀◀</button>");
			}else{
				$(".paging").append("<button disabled='disabled'>◀◀</button>");
			}
			if(pageNo - 1 > 0){
				$(".paging").append("<button class='backward'>◀</button>");
			}else{
				$(".paging").append("<button disabled='disabled'>◀</button>");
			}
			for (let i=startPage; i <= endPage; i++) {
				$(".paging").append("<button type='button' class='page'>" + i + "</button>");
			}
			if(pageNo + 1 < pages){						
				$(".paging").append("<button class='forward'>▶</button>");
			}else{
				$(".paging").append("<button disabled='disabled'>▶</button>");
			}
			if(pageNo + 10 < pages){
				$(".paging").append("<button class='end'>▶▶</button>");
			}else{
				$(".paging").append("<button disabled='disabled'>▶▶</button>");
			}
		},
		error: function(error){
			alert("에러가 발생했습니다. : " + error);
		}
	  }); //ajax end
	}//ajax_call
	
	$(document).on("click", ".page", function() {//동적으로 생성된 버튼 클릭하기
		pageNo = $(this).text();
		ajax_call(pageNo);
	});
	$(document).on("click", ".start", function(){
		pageNo = pageNo - 10;
		ajax_call(pageNo);
	});
	$(document).on("click", ".backward", function(){
		pageNo = pageNo - 1;
		ajax_call(pageNo);
	});
	$(document).on("click", ".forward", function(){
		pageNo = pageNo + 1;
		ajax_call(pageNo);
	});
	$(document).on("click", ".end", function(){
		pageNo = pageNo + 10;
		ajax_call(pageNo);
	});
	
});

</script>
</head>
<body>
<%@ include file="menu.jsp" %>
<h1>보드2</h1>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody class="tableHead">
		</tbody>
	</table>
	<div class="paging"></div>
			<footer>
				<div class="copyright-wrap">
					<span> Copyright © Mangom
						Corp. All Rights Reserved.
					</span>
				</div>
			</footer>
</body>
</html>