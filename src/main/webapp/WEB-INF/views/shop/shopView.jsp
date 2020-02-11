<%@page import="com.pro.dong.shop.model.vo.Shop"%>
<%@page import="java.util.Date"%>
<%@page import="com.pro.dong.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%
	Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
%>

<div id="shopView"></div>
<input type="hidden" name="memberLoggedIn" value="<%= memberLoggedIn.getMemberId()%>"/>

 <div id="shopView" class="mx-center">
	<div id="shopDiv">
		<div id="shopImgDiv">
			<div id="follow"><img id ="followIcon" src="${pageContext.request.contextPath}/resources/images/dislike.png"/></div>
			<c:if test="${map.IMAGE == null}">
				<img id="shopImg1" class="img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/shopImage/shopping-store.png" alt="" />
			</c:if>
			<c:if test="${map.IMAGE != null}">
				<img id="shopImg1" class="img-thumbnail" src="${pageContext.request.contextPath}/resources/upload/shopImage/${map.IMAGE}" alt="" />
			</c:if>
		</div>
<c:if test="${memberLoggedIn.memberId eq map.MEMBER_ID }">
			<button id="imgUpBtn" type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#exampleModal">수정</button>
</c:if>
		<div id="shopDetailInfoDiv">
			<div id="shopNameSpanDiv">
				<img id="shopIcon" src="${pageContext.request.contextPath}/resources/images/shopIcon.png" />
				<span id="shopNameSpan">${map.SHOP_NAME}</span> &nbsp;&nbsp;&nbsp;
<c:if test="${memberLoggedIn.memberId eq map.MEMBER_ID }">
				<button id="shopNameBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
</c:if>
			</div>
			<div id="shopNameInputDiv">
				<input id="shopNameInput" type="text"  value="${map.SHOP_NAME}"/>
				<button id="shopNameUpdateBtn" type="button" class="btn btn-outline-success btn-sm">수정</button>
				<span id="shopNameCheck"></span>
			</div><hr />
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-open@2x.png" width="14" height="13">상점오픈일 ${map.SINCE} 일째
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-user@2x.png" width="14" height="13">상점방문수 10명
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-sell@2x.png" width="14" height="13">상품판매 0회
			&nbsp;&nbsp;&nbsp;
			<img src="https://assets.bunjang.co.kr/bunny_desktop/images/shop-dell@2x.png" width="14" height="13">택배발송 2회<hr />
			<div id="shopInfoSpanDiv">
				<img id="shopIcon" src="${pageContext.request.contextPath}/resources/images/shopInfoIcon.png" />
				<span id="shopInfoDetail">${map.SHOP_INFO}</span> &nbsp;&nbsp;&nbsp;
<c:if test="${memberLoggedIn.memberId eq map.MEMBER_ID }">
				<button id="hiddenBtn" type="button" class="btn btn-outline-success btn-sm">수정</button><br />
</c:if>
			</div>
			<div id="shopInfoTextDiv">
				<textarea  name="updateInfo" id="updateInfo" cols="30" rows="2">${map.SHOP_INFO }</textarea>
<c:if test="${memberLoggedIn.memberId eq map.MEMBER_ID }">
				<button type="button" class="btn btn-outline-success btn-sm" id="up_btn">수정</button>
</c:if>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">회원 이미지 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="ajaxFrom" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/shop/shopImageUpload.do" >
			<div class="modal-body">
				<!-- 파일 선택 div -->
				<div class="input-group mb-3" style="padding:0px;">
		  			<div class="input-group-prepend" style="padding:0px;">
		    			<!-- <span class="input-group-text">회원이미지</span> -->
		  			</div>
		  			<div class="custom-file">
		  				<input type="hidden" name="memberId" value="<%=memberLoggedIn.getMemberId() %>" />
		    			<input type="file" class="custom-file-input" name="upFile" id="upShopFile" >
		    			<label class="custom-file-label" for="upFile" id="fileName">파일을 선택하세요</label>
		  			</div>
				</div>
				<!-- 파일 선택 div -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button disabled id="shopImgUpdateBtn" type="submit" class="btn btn-primary">수정하기</button>
			</div>
			</form>
		</div>
	</div>
</div>
	
<script>
/* 첨부파일 관련 */
//파일선택 | 취소시에 파일명 노출하기
	
	</script>
	<hr class="my-hr3"/><br />
	
	<!-- 넘어오면 다 내꺼 -->
	
	<div id="shopView-nav">
		<div style="height: 20px;">
			<ul>
				<li><div class="shop-nav-selected shop-nav">내 상품</div></li>
				<li><div id="shopInquiryDiv" class="shop-nav-disabled shop-nav">상점문의</div></li>
				<li><div class="shop-nav-disabled shop-nav">찜 목록</div></li>
				<li><div class="shop-nav-disabled shop-nav">상점후기</div></li>
				<li><div class="shop-nav-disabled shop-nav">팔로우</div></li>
				<li><div class="shop-nav-disabled shop-nav">팔로워</div></li>
			</ul>
		</div>
	
		<div id="shop-contents">
			<div id="nav-product">
				<h1>내 상품</h1>
				<div class="myProductList" id="myProductList">
      				<div class="myProduct" id="myProduct">
      				
      				</div>
      				
    			</div>
    			 <div id="pageBar"></div>
			</div>
			<div id="nav-inquiry">
				<h3>상점 문의&nbsp;<span id="totalInquiry" style="color:green;"></span></h3>
				<div id="shopInquiryTextDiv">
					<textarea name="shopInquiryText" id="shopInquiryText"  maxlength="100" cols="100" rows="3" placeholder="문의내용을 입력하세요."></textarea>
				</div>
				<div id="shopInquiryBtnDiv">
					<span id="inquiryContentCheck">0/100</span>
					<button id="shopInquiryBtn" disabled="disabled"><img src="https://assets.bunjang.co.kr/bunny_desktop/images/register@2x.png" width="15" height="16" >등록</button>
				</div>
				<div id="shopInquiryList">
				<!-- select해온 문의사항 리스트 -->
				</div></div>
			<div id="nav-wishlist">
				<h1>찜</h1>
				
			</div>
			<div id="nav-review">
				<h1>상점 후기</h1>
			</div>
			<div id="nav-follow">
				<h1>팔로우</h1>
			</div>
			<div id="nav-follower">
				<h1>팔로워</h1>
			</div>
		</div>
	</div>

 </div>

<script>
$(()=>{
	var loginId = '${memberLoggedIn.memberId}';
	var shopId = "${map.MEMBER_ID}";
	var $shopNav = $("#shopView-nav .shop-nav");
	
	$("#shopInquiryTotalDiv").hide();
	$("#shopView-nav #shop-contents").children().hide();
	$("#shopView-nav #nav-product").show();
	$("#shopView-nav .shop-nav").click((e)=>{
		
		try {
			$shopNav.removeClass("shop-nav-selected");
			$shopNav.addClass("shop-nav-disabled");
			$(e.target).removeClass("shop-nav-disabled");
			$(e.target).addClass("shop-nav-selected");
		} catch (error) {}
		
		$(e.target).html()
		
		$("#shopView-nav #shop-contents").children().hide();
		
		console.log($(e.target).attr("id"));
		
		switch ($(e.target).text()) {
			case "내 상품": $("#shopView-nav #nav-product").show();break;
			case "상점문의": $("#shopView-nav #nav-inquiry").show(); $("#shopInquiryTotalDiv").show();break;
			case "찜 목록": $("#shopView-nav #nav-wishlist").show();break;
			case "상점후기": $("#shopView-nav #nav-review").show();break;
			case "팔로우": $("#shopView-nav #nav-follow").show();break;
			case "팔로워": $("#shopView-nav #nav-follower").show();break;
		}
	})
	/* 주영 시작 */

	$("#shopInquiryText").keyup(function() {
		var content = $(this).val();
		console.log("content.length="+content.length);
		
		if(content.length > 0){
			$("#shopInquiryBtn").prop("disabled", false);
		}
		
		if(content.length == 0){
			$("#shopInquiryBtn").prop("disabled", true);
		}
		
		var inquiryContentCheck = $("#inquiryContentCheck");
		inquiryContentCheck.html(content.length + '/100');
		
	});
	
	$("#shopView #shopInquiryDiv").click(selectInquiry);
	function selectInquiry() {
		var shopNo = ${map.SHOP_NO};
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/selectShopInquriy",
			method: "POST",
			data: { shopNo: shopNo },
			success: data => {
				console.log(data);
				let $totalInquiry = $("#totalInquiry");
				$totalInquiry.html(data.totalInquiry);
				var memberId = $("[name=memberLoggedIn]").val();

				let $listDiv = $("#shopInquiryList");
				let html = "";
				for (var i = 0; i < data.list.length; i++) {
					/* 댓글이라면 */
					if (data.list[i].INQUIRY_LEVEL == 1) {
						html += "<hr width='745px'  align='left'/>";
						if (data.list[i].IMAGE == null) {
							html += "<img id='inquiryImgTag' src='${pageContext.request.contextPath}/resources/images/shopping-store.png'/>";
						}
						if (data.list[i].IMAGE != null) {
							html += "<img id='inquiryImgTag' src='${pageContext.request.contextPath}/resources/upload/shopImage/" + data.list[i].IMAGE + "'/>";
						}
						html += "<div id='inquiryDetail'>";
						html += "<span id='inquiryWriterTag'>" + data.list[i].MEMBER_ID + "</span>";
						html += "&nbsp;&nbsp;";
						html += "<span>" + data.list[i].WRITE_DAY + "</span>";
						html += "<p>" + data.list[i].INQUIRY_CONTENT + "</p>";
						html += "</div>";
						//로그인한 아이디 = 문의사항을 작성한 아이디가 같다면 
						if (("${map.MEMBER_ID}" == memberId) || (memberId == data.list[i].MEMBER_ID)) {
							html += "<button value=" + data.list[i].INQUIRY_NO + " id='insertInquiryCommentBtn' class='commentBtn' >"
							html += "<img  src='https://assets.bunjang.co.kr/bunny_desktop/images/reply@2x.png' width='17' height='17'>";
							html += "댓글";
							html += "</button>";
							html += "<button id='deleteCommentBtn' value=" + data.list[i].INQUIRY_NO + " class='commentDelBtn'>";
							html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='17'>";
							html += "삭제";
							html += "</button>";
						}
							html += "<div class='inquiryCommentDiv' id='inquiryCommentDiv'></div>";
					}
					/* 대댓글이라면 */
					else {
						html += "<div class='recommentDiv'>";
						html += "<img class='replyIcon' src='${pageContext.request.contextPath}/resources/images/reply.PNG'/>";
						html += "<img id='inquiryImgTag' src='${pageContext.request.contextPath}/resources/upload/shopImage/" + data.list[i].IMAGE + "'/>";
						html += "<div id='inquiryRecommentDetail'>";
						html += "<span id='inquiryWriterTag'>" + data.list[i].MEMBER_ID + "</span>";
						html += "&nbsp;&nbsp;";
						html += "<span>" + data.list[i].WRITE_DAY + "</span>";
						html += "<p>" + data.list[i].INQUIRY_CONTENT + "</p>";
						html += "</div>";
						html += "</div>";
					}
				}
				$listDiv.html(html);

			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	}
	
$("#shopView #shopInquiryBtn").click(insertInquiry);
	function insertInquiry() {
		$("#inquiryContentCheck").html("0/100");
		var memberId = $("[name=memberLoggedIn]").val();
		var inquiryContent = $("#shopInquiryText").val();
		var shopNo = ${ map.SHOP_NO };
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/insertShopInquriy",
			method: "POST",
			data: {
				inquiryContent: inquiryContent,
				memberId: memberId,
				shopNo: shopNo
			},
			success: data => {
				console.log("insertdata=" + data);
				$("#shopInquiryText").val('');
				/* 이중 에이작스  */
				selectInquiry();
				/* 이중 에이작스  */
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});

	}
//////////////////////////////
$(document).on("click", "#shopView #deleteCommentBtn", function(e){
	var deleteCommentBtnTarget = $(e.target);
	console.log("addgfgdgfdgdfg");
	console.log(deleteCommentBtnTarget);
	var deleteCommentBtn = deleteCommentBtnTarget.val();
	console.log("asdasd");
	console.log(deleteCommentBtn);

	$.ajax({
		url: "${pageContext.request.contextPath}/shop/deleteShopInquriy",
		method: "POST",
		data: { deleteCommentBtn: deleteCommentBtn },
		success: data => {
			console.log(data);
			selectInquiry();
		},
		error: (x, s, e) => {
			console.log("ajax 요청 실패!");
		}
	});
});

$(document).on("click", "#shopView #insertInquiryCommentBtn", function(e){
		$(e).attr("disabled", true);
		var btnTarget = $(e.target);
		var inquiryRefNo = btnTarget.val();
		let html = "";
		html += "<br/>";
		html += "<textarea id='shopInquiryCommentText' cols='80' rows='1' placeholder='댓글내용을 입력하세요.'></textarea>&nbsp;&nbsp;";
		html += "<button value='" + inquiryRefNo + "' id='shopInquiryCommentEndBtn'>";
		html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/register@2x.png' width='15' height='14' >";
		html += "등록";
		html += "</button>";
		html += "<button id='cancelRecommentBtn' class='commentDelBtn'>";
		html += "<img src='https://assets.bunjang.co.kr/bunny_desktop/images/trash-sm@2x.png' width='15' height='14'>";
		html += "취소";
		html += "</button>";
		html += "</div>";
		
		btnTarget.next().next().html(html);
	});
	
$(document).on("click", "#shopView #cancelRecommentBtn", function(e){
		console.log("취소버튼함수에들어왔다");
		var cancelRecommentBtn = $(e.target);
		cancelRecommentBtn.parent().prev().prev().attr("disabled", false);
		cancelRecommentBtn.prev().prev().parent().empty();
		$("#deleteCommentBtn").css('margin-left', '5px');
});


$(document).on("click", "#shopView #shopInquiryCommentEndBtn", function(){
		var inquiryRefNo = $("#shopInquiryCommentEndBtn").val();
		console.log(inquiryRefNo);
		var shopInquiryCommentText = $("#shopInquiryCommentText").val();
		var shopInquiryCommentWriter = $("[name=memberLoggedIn]").val();
		var shopInquiryCommentShopNo = ${ map.SHOP_NO }

		$.ajax({
			url: "${pageContext.request.contextPath}/shop/insertInquiryComment",
			method: "POST",
			data: {
				inquiryRefNo: inquiryRefNo,
				shopInquiryCommentText: shopInquiryCommentText,
				shopInquiryCommentWriter: shopInquiryCommentWriter,
				shopInquiryCommentShopNo: shopInquiryCommentShopNo
			},
			success: data => {
				console.log(data);
				selectInquiry();
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	});
	var memberId = $("[name=memberLoggedIn]").val();

	loadMyProduct(1);

	function loadMyProduct(cPage) {
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/loadMyProduct",
			contentType: "application/json; charset=utf-8",
			data: {
				memberId: memberId,
				cPage: cPage
			},
			dataType: "json",
			success: data => {
				console.log("성");
				let html = "";
				var $myProduct = $("myProduct");
				data.product.forEach(product => {

					let preTitle = product.TITLE;

					if (preTitle.length > 12)
						preTitle = preTitle.substring(0, 12) + "..."

					html += "<div class='card' style='width: 232px; height: 300px;'>";
					html += "<img src='${pageContext.request.contextPath}/resources/upload/product/" + product.PHOTO + "' class='card-img-top'>";
					html += '<div class="card-body">';
					html += '<p class="card-title">' + preTitle + '</p>';
					html += '<p class="card-text"><span>' + numberComma(product.PRICE) + '<small>원</small></span></p>';
					html += '</div></div>'
				});
				$("#myProduct").html(html);
				$("#pageBar").html(data.pageBar);
			},
			error: (x, s, e) => {
				console.log("실패", x, s, e);
			},
			complete: () => {
				$("#pageBar a").click((e) => {
					loadMyProduct($(e.target).siblings("input").val());
				});
			}

		});

	}
	$("[name=upFile]").on("change", function () {
		//파일 입력 취소
		if ($(this).prop("files")[0] === undefined) {
			$(this).next(".custom-file-label").html("파일을 선택하세요.");
			$("#shopImgUpdateBtn").attr("disabled", true);
			return;
		}
		var fileName = $(this).prop('files')[0].name;
		$(this).next(".custom-file-label").html(fileName);
		$("#shopImgUpdateBtn").attr("disabled", false);
	});

	/* 상점수정 관련 */
	$("#shopNameInput").keyup(function () {
		var shopName = $("#shopNameInput").val();
		var memberId = $("[name=memberLoggedIn]").val();
		var currentShopName = $("#shopNameSpan").text();
		$.ajax({
			url: "${pageContext.request.contextPath}/shop/shopNameCheck",
			method: "POST",
			data: {
				memberId: memberId,
				shopName: shopName
			},
			success: data => {
				if (currentShopName == shopName) {
					$("#shopNameUpdateBtn").attr("disabled", false);
				}
				else if (shopName.length == 0) {
					$("#shopNameCheck").html("상점명을 입력하세요.");
					$("#shopNameCheck").css("color", "red");
					$("#shopNameUpdateBtn").attr("disabled", true);
				}
				else if (data.checkResult == "9") {
					$("#shopNameCheck").html("이미 사용중인 상점명입니다.");
					$("#shopNameCheck").css("color", "red");
					$("#shopNameUpdateBtn").attr("disabled", true);
				}
				else if (data.checkResult == "1") {
					$("#shopNameSpan").html(data.SHOP_NAME);
					$("#shopNameCheck").html("사용가능한 상점명입니다.");
					$("#shopNameCheck").css("color", "blue");
					$("#shopNameUpdateBtn").attr("disabled", false);
				}
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	})

$("#shopView #shopNameUpdateBtn").click(shopNameUpdateEnd);
	function shopNameUpdateEnd() {
		var shopName = $("#shopNameInput").val();
		var memberId = $("[name=memberLoggedIn]").val();
		console.log("memberId=" + memberId);
		console.log("shopName=" + shopName);

		$.ajax({
			url: "${pageContext.request.contextPath}/shop/updateShopName",
			method: "POST",
			data: {
				memberId: memberId,
				shopName: shopName
			},
			success: data => {
				console.log(data);
				console.log(data.SHOP_NAME);

				$("#shopNameCheck").html("");
				$("#shopNameSpan").html(data.SHOP_NAME);

				var $shopNameSpanDiv = $("#shopNameSpanDiv");
				var $shopNameInputDiv = $("#shopNameInputDiv");

				$shopNameSpanDiv.show();
				$shopNameInputDiv.hide();
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	}

$("#shopView #shopNameBtn").click(shopNameUp);
	function shopNameUp() {
		var $shopNameInputDiv = $("#shopNameInputDiv");
		var $shopNameSpanDiv = $("#shopNameSpanDiv");

		$shopNameInputDiv.show();
		$shopNameSpanDiv.hide();
	}

	$(function () {
		var $shopInfoTextDiv = $("#shopInfoTextDiv");
		var $shopNameInputDiv = $("#shopNameInputDiv");

		$shopNameInputDiv.hide();
		$shopInfoTextDiv.hide();

	});

$("#shopView #hiddenBtn").click(showUpdate);
	function showUpdate() {

		var $shopInfoTextDiv = $("#shopInfoTextDiv");
		$shopInfoTextDiv.show();

		var $shopInfoSpanDiv = $("#shopInfoSpanDiv");
		$shopInfoSpanDiv.hide();
	};

$("#shopView #up_btn").click(shopUpdateEnd);
	function shopUpdateEnd() {
		var memberId = $("[name=memberLoggedIn]").val();
		var updateInfo = $("#updateInfo").val();

		console.log("memberId=" + memberId);
		console.log("updateInfo=" + updateInfo);

		$.ajax({
			url: "${pageContext.request.contextPath}/shop/updateShopInfo",
			method: "POST",
			data: {
				memberId: memberId,
				updateInfo: updateInfo
			},
			success: data => {
				console.log(data);
				var $shopInfoTextDiv = $("#shopInfoTextDiv");
				$shopInfoTextDiv.hide();

				$('#shopInfoDetail').html(data.SHOP_INFO);

				var $shopInfoSpanDiv = $("#shopInfoSpanDiv");
				$shopInfoSpanDiv.show();
			},
			error: (x, s, e) => {
				console.log("ajax 요청 실패!");
			}
		});
	};
	
	$("#follow").on('click', function(){
		var img = $("#followIcon");
		img.attr("src", function(index, attr){
			if(attr.match('${pageContext.request.contextPath}/resources/images/like.png')){
				return attr.replace("${pageContext.request.contextPath}/resources/images/like.png", "${pageContext.request.contextPath}/resources/images/dislike.png");
			} else {
				return attr.replace("${pageContext.request.contextPath}/resources/images/dislike.png","${pageContext.request.contextPath}/resources/images/like.png");
			}
		}) 
	});
});


/* 주영 끝 */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>