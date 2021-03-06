<%@page import="java.util.ArrayList"%>
<%@page import="com.pro.dong.board.model.vo.BoardCategory"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
	List<BoardCategory> list = new ArrayList<>();
	list = (List<BoardCategory>)request.getAttribute("boardCategoryList");
	
	System.out.println("listt="+list);
	
	String option = "";
	option += "<option value=''/>전체</option>";
	for(BoardCategory bc: list){
		if("Y".equals(memberLoggedIn.getIsAdmin())){
			option += "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
		}
		else{
			if(bc.getCategoryId().equals("A03")){
				continue;
			}
			else{
			option += "<option value=\""+bc.getCategoryId()+"\">"+bc.getCategoryName()+"</option>";
				
			}
		} 
	}
%>

<script>
function validate(){
	var contents = $("#boardContents").val();
	if(contents.trim().length==0){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(function(){
	//파일명 노출하기
	$("#upFile").on("change", function(){
		//파일 취소
		if($(this).prop("files")[0] === undefined){
			$(this).next(".custom-file-label")
				   .html("파일을 선택하세요.");
			return;
		}
		
		var fileName = $(this).prop('files')[0].name;
		
		$(this).next(".custom-file-label")
			   .html(fileName);
	});
});
</script>

<div id="boardWrite-contanier" class="text-center">
	<form action="${pageContext.request.contextPath}/board/writeBoardEnd.do"
		  method="post"
		  enctype="multipart/form-data"
		  onsubmit="return validate();">
        <div id="boardWrite-contant">
                <div class="boardWrite-pad col-auto">
                        <label class="sr-only" for="inlineFormInputGroup">Username</label>
                        <div class="input-group mb-2">
                          <div class="input-group-prepend">
                            <div class="input-group-text">제목&nbsp;&nbsp;&nbsp;&nbsp;</div>
                          </div>
                          <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요" required>
                        </div>
                      </div>
                <div class="boardWrite-pad col-auto">
                    <label class="sr-only" for="inlineFormInputGroup">Username</label>
                    <div class="input-group mb-2">
                        <div class="input-group-prepend">
                        <div class="input-group-text">작성자</div>
                        </div>
                        <input type="text" class="form-control" value="${memberLoggedIn.memberId}" name="memberId" placeholder="Username" readonly>
                    </div>
                </div>
               <div class="input-group mb-3">
				 <div class="input-group-prepend">
				    <label class="input-group-text" for="inputGroupSelect01">카테고리</label>
				 </div>
				 <select class="custom-select" id="boardCategory" name="boardCategory" required>
				   <%=option%> 
				 </select>
				</div>
               <div class="input-group mb-3" >
				  <div class="input-group-prepend" >
				    <span class="input-group-text">첨부파일</span>
				  </div>
				  <div class="custom-file">
				    <input type="file" class="custom-file-input" name="upFile" id="upFile" >
				    <label class="custom-file-label" for="upFile">파일을 선택하세요</label>
				  </div>
				</div>
				
                <div class="form-group">
                        <label for="exampleFormControlTextarea1">내용</label>
                        <textarea class="form-control" id="boardContents" name="boardContents" rows="10"></textarea>
                </div>
            
            <input type="submit" class="btn btn-success " value="글쓰기">
        </div>
       </form>
    </div>
    


	














</body>





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>