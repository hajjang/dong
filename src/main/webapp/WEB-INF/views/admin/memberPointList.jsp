<%@page import="com.pro.dong.common.util.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<script>
$(function (){
	loadMemberPointList();
	
	$("#searchMemberPoint").click(function (){
		var cPage = $("#cPage").val();
		var searchType = $("#searchType").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if(searchKeyword.length == 0){
			alert("검색어를 입력하세요.");
			$("#searchKeyword").focus();
			return;
		}else{
			loadMemberPointList(searchType,searchKeyword,cPage);
		}
	});
	
	$("#memberPointAll").click(function (){
		location.reload();		
	});
});


function loadMemberPointList(searchType,searchKeyword, cPage){
	var cPage = cPage;
	var searchType = searchType;
	var searchKeyword = searchKeyword;
	
	$("#cPage").val(cPage);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/memberPointListEnd",
		type: "GET",
		data: {
			cPage:cPage,
			searchType: searchType,
			searchKeyword: searchKeyword
		},
		success: data => {
			console.log("memberPointList@ajax실행즁"+data);
			let header = "<tr><th>아이디</th><th>충전금액</th><th>충전날짜</th><th>잔여포인트</th><th>상태(입/출)</th></tr>";
			let $table = $("#member-pointList-tbl");
			$table.html("");
			let html = "";
			data.list.forEach(cate => {
				html += "<tr><td>"+cate.MEMBER_ID+"</td><td>"+cate.POINT_AMOUNT+"</td><td>"+cate.REG_DATE+"</td><td>"+cate.POINT+"</td><td>"+cate.STATUS+"</td></tr>";
			});
			$table.append(header+html);
			$("#pageBar").html(data.pageBar);
			$("#totalPoint").text(data.totalPoint);
			
		},error : (x,s,e) => {
			console.log("memberPointList@ajax 실패실패!!!");
		}
	});
}

</script>

<h1>회원포인트 관리</h1>

	<div class="col-md-6 ">
	    <div class="input-group">
		  <label for="searchKeyword" class="sr-only">검색</label>
		  <select class="custom-select" id="searchType" required>
	     	<option value="member_id">아이디</option>
	     	<option value="reg_date">충전날짜</option>
	     	<option value="status">입/출내역</option>
	      </select>
	      
	      <!-- <div id="search-status">
	      	<input type="hidden" name="searchType" value="status"/>
	      	<input type="radio" name="searchKeyword" value="I" checked/> 입급내역
	      	<input type="radio" name="searchKeyword" value="O"/> 출금내역
	      </div> -->
	      
		  <input style="margin-left: 20px;" type="text" size="30" id="searchKeyword" placeholder="검색어를 입력하세요">
		  <div class="input-group-append">
	      <button style="margin-left: 20px;" class="btn btn-primary btn-sm" id="searchMemberPoint">검색하기</button> 
	      <button style="margin-left: 30px;" class="btn btn-primary btn-sm" id="memberPointAll">전체보기</button>
          </div>
	    </div>
    </div>

<div class="table-responsive">
<br /><br />
	<table class="table text-center" id="member-pointList-tbl">
		
	</table>
</div>
<div id="pageBar">
	
</div>
<input type="hidden" name="cPage" id="cPage"/>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>