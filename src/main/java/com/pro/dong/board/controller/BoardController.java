package com.pro.dong.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pro.dong.board.model.service.BoardService;
import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;

import oracle.net.aso.r;


@RequestMapping("/board")
@Controller
public class BoardController {
	
	static Logger log = LoggerFactory.getLogger(BoardController.class);
	static Gson gson = new Gson();
	@Autowired
	BoardService bs;
	// 민호 시작 ==========================
	@RequestMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav, HttpSession session) {
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		String dong = memberLoggedIn.getDong();
		
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		List<Board> boardList = bs.selectBoardList(dong);//인기글 조회
		
		mav.addObject("boardCategoryList",boardCategoryList);
		mav.addObject("boardList",boardList);
		mav.setViewName("/board/boardList");
		return mav;
		
	}
	
	@RequestMapping("/loadBoardList")
	@ResponseBody
	public Map<String, Object> loadBoardList(@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword, @RequestParam(value="boardCategory",defaultValue="") String boardCategory,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam("memberId") String memberId){
		log.debug("boardCategory={}",boardCategory);
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		// 주소 조회
		Member member = bs.getMemberByMemberId(memberId);
//		Address addr = bs.getAddrByMemberId(memberId);
		// 게시판 카테고리 조회
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		// 파라미터 생성
		Map<String, String> param = new HashMap<>();
		String sido = member.getSido();
		String sigungu = member.getSigungu();
		String dong = member.getDong();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		param.put("boardCategory", boardCategory);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		// 페이징바 작업
		int totalContents = bs.selectBoardTotalContents(param);
		// 공지글 조회
		List<Board> noticeList = bs.selectBoardNotice(param);
		// 게시글 조회
		List<Board> list = bs.loadBoardList(cPage, numPerPage, param);
		// 넘겨줄map에 담기
		result.put("sido", sido);
		result.put("sigungu", sigungu);
		result.put("dong", dong);
		result.put("list", list);
		result.put("boardCategoryList", boardCategoryList);
		result.put("noticeList", noticeList);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("pageBar", pageBar);
		return result;
	}
	//==========================민호 끝
		
	// 하진 시작 ==========================
		@RequestMapping(value="/loadBoardReportCategory", produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String loadBoardReportCategory() {
			List<Map<String, String>> list = null;
			list = bs.loadBoardReportCategory();
			Map<String, Object> result = new HashMap<>();
			result.put("list", list);
			return gson.toJson(result);
		}
	
		@RequestMapping("/insertBoardReport")
		@ResponseBody
		public String insertBoardReport(@RequestParam("reportComment") String reportComment,
													@RequestParam("categoryId") String categoryId,
													@RequestParam("memberId") String memberId,
													@RequestParam("boardNo") String boardNo){
			
			
			
			Map<String, String> param = new HashMap<>();
			param.put("reportComment",reportComment);
			param.put("categoryId",categoryId);
			param.put("memberId",memberId);
			param.put("boardNo",boardNo);
			
			int status = bs.insertBoardReport(param);
			
			
			
			return ""+status;
		}

	//========================== 하진 끝
		
	// 근호 시작 ==========================
	@RequestMapping("/writeBoard.do")
	public ModelAndView writeBoard(ModelAndView mav) {
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		mav.addObject("boardCategoryList",boardCategoryList);
		mav.setViewName("/board/writeBoard");
		return mav;
	}
	
	@RequestMapping("/writeBoardEnd.do")
	public ModelAndView writeBoardEnd(ModelAndView mav, Board board, @RequestParam(value="boardCategory") String boardCategory,
									  @RequestParam(value="upFile", required=false) MultipartFile[] upFile,
									  HttpServletRequest request) {
		
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
		List<Attachment> attachList = new ArrayList<>();
		
		log.debug("board={}", board);
		board.setCategoryId(boardCategory);
		//동적으로 directory 생성
		File dir = new File(saveDirectory);
		if(dir.exists() == false)
			dir.mkdir();
		
		//MultipartFile객체 파일업로드 처리
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				//파일명 재생성
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+ext;
				
				//서버컴퓨터에 파일저장
				try {
					f.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				Attachment attach = new Attachment();
				attach.setOriginalFileName(originalFileName);
				attach.setRenamedFileName(renamedFileName);
				attachList.add(attach);
				
			}
		}
		log.debug("attachList={}", attachList);
		//업로드 처리 끝
		
		board.setBoardTitle(board.getBoardTitle().replaceAll("<", "&lt").replaceAll(">", "&gt;"));
		board.setBoardContents(board.getBoardContents().replaceAll("<", "&lt").replaceAll(">", "&gt;"));
		
		//2.업무로직
		int result = bs.insertBoard(board, attachList);
		
		//3.view
		mav.addObject("msg", result>0?"등록성공!":"등록실패!");
		mav.addObject("loc", "/board/boardList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	/*public String writeBoardEnd(Model model, Board board) {
		
		int result = bs.insertBoard(board);
		log.debug("board={}", board);
		model.addAttribute("msg", result>0?"등록성공!":"등록실패!");
		model.addAttribute("loc", "/board/boardList.do");
		
		log.debug("result={}",result);
		
		return "common/msg";
	}*/
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	@RequestMapping("/boardView.do")
	public ModelAndView boardView(ModelAndView mav, @RequestParam("boardNo") int boardNo, HttpSession session) {
		String memberId = ((Member)(session.getAttribute("memberLoggedIn"))).getMemberId();
		//Map<String,Object> map = bs.selectOneBoard(boardNo);
		Board board = bs.selectOneBoard(boardNo);
		Attachment attachment = bs.selectAttachmentList(boardNo);
		//List<Attachment> attachmentList = bs.selectAttachmentList(boardNo);
		int readCount = bs.boardInCount(boardNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("boardNo", boardNo+"");
		param.put("memberId", memberId);
		mav.addObject("likeCntOne", bs.selectBoardLikeByMemberId(param));
		
		mav.addObject("board", board);
		mav.addObject("attachment", attachment);
		mav.addObject("memberId", board.getMemberId());
		
		
		return mav;
	}
	
/*	public Map<String,Object> boardView(@RequestParam("boardNo") int boardNo, HttpSession session){
		Board board = bs.selectOneBoard(boardNo);
		//List<Attachment> attachmentList = bs.selectAttachmentList(boardNo);
		int readCount = bs.boardInCount(boardNo);
		
		String memberId = ((Member)(session.getAttribute("memberLoggedIn"))).getMemberId();
		
		Map<String, String> param = new HashMap<>();
		param.put("boardNo", boardNo+"");
		param.put("memberId", memberId);
		mav.addObject("likeCntOne", bs.selectBoardLikeByMemberId(param));
		
		mav.addObject("board", board);
		//mav.addObject("attachmentList", attachmentList);
		mav.addObject("memberId", board.getMemberId());
		return ;
	}*/
	
	@RequestMapping("/boardUpdate.do")	
	@ResponseBody
	public ModelAndView boardUpdate( ModelAndView mav, int boardNo,HttpSession session) {
		Map<String, String> param = new HashMap<>();
		param.put("boardNo", boardNo+"");
		Board board = bs.selectOneBoard(boardNo);
		Attachment attachment = bs.selectAttachmentList(boardNo);
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		mav.addObject("boardCategoryList",boardCategoryList);
		mav.addObject("board", board);
		mav.addObject("memberId", board.getMemberId());
		mav.addObject("attachment", attachment);
		mav.addObject("loc", "/board/boardUpdate.do");
		return mav;
	}
	
	@RequestMapping("/deleteFile")
	@ResponseBody
	public String deleteFile(String fileName, HttpServletRequest request) {
		
		int result = bs.deleteAttachment(fileName);
		
//		파일제거
		if(result > 0) {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/product/");
			
			File file = new File(saveDirectory + fileName); 
			file.delete();
		}
		
		return String.valueOf(result);
	}
	
	@RequestMapping("/updateFile")
	@ResponseBody
	public String updateFile(Board board, Attachment a, MultipartFile files, String oldFileName, String boardNo,HttpServletRequest request,@RequestParam(value="upFile", required=false) MultipartFile[] upFile) {
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
		List<Attachment> attachList = new ArrayList<>();
		String renamedFileName = null;
		log.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@renamedFileName={}", renamedFileName);
		Map<String, String> param = new HashMap<>();
		param.put("photo", renamedFileName);
		param.put("boardNo", String.valueOf(boardNo));
		param.put("oldName", oldFileName);
		
		Map<String, String> map = new HashMap<>();
		//map.put("result", String.valueOf(result));
		map.put("newName", renamedFileName);
		
		//int result = bs.updateAttachment(attachment,attachList,oldFileName,boardNo);
		int result = bs.insertAttachment(a);
		//int result = bs.updateAttachment(attachment,boardNo);
		//동적으로 directory 생성
		File dir = new File(saveDirectory);
		if(dir.exists() == false)
		dir.mkdir();
				
				//MultipartFile객체 파일업로드 처리
				for(MultipartFile f : upFile) {
					if(!f.isEmpty()) {
						//파일명 재생성
						String originalFileName = f.getOriginalFilename();
						String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
						int rndNum = (int)(Math.random()*1000);
						renamedFileName = sdf.format(new Date())+"_"+rndNum+ext;
						
						//서버컴퓨터에 파일저장
						try {
							f.transferTo(new File(saveDirectory+"/"+renamedFileName));
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
						
						Attachment attach = new Attachment();
						attach.setOriginalFileName(originalFileName);
						attach.setRenamedFileName(renamedFileName);
						attachList.add(attach);
						
					}
				}
		
		return gson.toJson(result)+"";
	}
	
	@RequestMapping("/boardUpdateEnd")
	@ResponseBody
	public String boardUpdateEnd(Board board,HttpServletRequest request,@RequestParam(value="upFile", required=false) MultipartFile[] upFile) {
		log.info("board={}",board);
		int result = bs.boardUpdate(board);
		String msg = "";
		String loc = "/";
		log.info("result={}",result);
		
		if(result>0) {
			msg = "게시글 수정이 완료되었습니다.";
			loc = "/board/boardList.do";
		
		
		}else {
			msg = "게시글 수정에 실패하였습니다.";
		}
		
		return result+"";
	}
		
	@RequestMapping("/boardDelete")
	@ResponseBody
	public String boardDelete(@RequestParam("boardNo") int boardNo) {
		int result = bs.deleteBoard(boardNo);
		//log.debug("boardDelete@boardNo="+boardNo);
		
		String msg = "";
		String loc = "/";
		if(result>0) {
			//log.debug("board삭제 성공!!!!!");
			msg = "삭제성공!";
			loc = "/board/boardList.do";
		}else {
			//log.debug("board삭제 실패!!!");
			msg = "삭제실패!";
		}

		return result+"";
	}
	
	@RequestMapping("/boardLikeCount")
	@ResponseBody
	//전체 추천 조회수용 
	public String selectBoardLike(@RequestParam("boardNo") int boardNo) {
		Map<String,String> map = new HashMap<>();
		map.put("boardNo", boardNo+"");
		
		int likeCnt = bs.selectBoardLike(map);
		//log.debug("boardLikeCount@likeCnt={}", likeCnt);
		
		return likeCnt+"";
	}
	
	//개인 추천 조회수용 (여부 파악용)
	@RequestMapping("boardLikeCountByMemberId")
	@ResponseBody
	public String selectBoardLikeByMemberId(@RequestParam("boardNo") int boardNo, @RequestParam("memberId") String memberId) {
		Map<String,String> map = new HashMap<>();
		map.put("boardNo", boardNo+"");
		map.put("memberId", memberId);
		
		int likeCntOne = bs.selectBoardLikeByMemberId(map);
		
		return likeCntOne+"";
	}
	
	@RequestMapping(value="/boardLike", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String boardLike(@RequestParam("boardNo") int boardNo, @RequestParam("memberId") String memberId) {
		Map<String,String> map = new HashMap<>();
		map.put("boardNo", boardNo+"");
		map.put("memberId", memberId);
		//map.put("reputationNo", reputationNo+"");
		//log.debug("boardLike@memberId={}", memberId);
		int likeCnt = bs.selectBoardLikeByMemberId(map);
		
		int result;
		
		if(likeCnt == 0) {
			result = bs.insertBoardReputation(map);
			map.put("type", "I");
		}else {
			result = bs.deleteBoardReputation(map);
			map.put("type", "o");
		}
		
		map.put("result", result+"");
		
		return gson.toJson(map);
	}

	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
	@RequestMapping("/selectBoardReportList")
	@ResponseBody
	public Map<String, Object> selectBoardReportList(@RequestParam(value="boardNo", defaultValue="")int boardNo){
		
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, String>> list = bs.selectBoardReportList(boardNo);
		
		map.put("list", list);
		
		return map;
	}
	
	@RequestMapping("/updateReportStatus")
	@ResponseBody
	public String updateReportStatus(@RequestParam(value="reportNo", defaultValue="")int reportNo) {
		
		int result = bs.updateReportStatus(reportNo);
		
		return  result+"";
	}
	
	//========================== 주영 끝
		
	// 현규 시작 ==========================
	@RequestMapping("/boardComment.do")
	public void boardComment() {}
	
	
	//댓글 등록
	@RequestMapping(value="/insertComments", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insertComments(HttpSession session, BoardComment bc, @RequestParam("boardNo") int boardNo) {
		
		bc.setContents(bc.getContents().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>"));
		
		int result = bs.insertBoardComment(bc);
		
		
		
		return gson.toJson(result)+"";
	}
	
	
	//댓글 불러들이기
	@ResponseBody
	@RequestMapping(value="/selectBoardComment", produces="text/plain;charset=UTF-8")
	public String selectBoardCommentList(@RequestParam("boardNo") int boardNo, @RequestParam("cPage") int cPage) {
		int numPerPage=10;
		log.info("파라미터로받아온 boardNo{}",boardNo);
		List<Map<String,String>>list = null;
		
		list = bs.selectBoardCommentList(boardNo,cPage,numPerPage);
		log.debug("DB에서 가져온 리스트={}",list);
		
		
		
		int totalContents = bs.countComment(boardNo);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		
		Map<String,Object> result = new HashMap<>();
		result.put("list", list);
		result.put("pageBar", pageBar);
		
		
		
		return gson.toJson(result)+"";
	}
	
	
	
	
	//댓글 지우기
	@ResponseBody
	@RequestMapping("/deleteLevel1")
	public String deleteLevel1(@RequestParam("commentNo") int commentNo,@RequestParam("boardNo")int boardNo) {
		log.info("삭제할 코멘트넘버={}",commentNo);
		
		BoardComment bc = new BoardComment();
		bc.setCommentNo(commentNo);
		
		int result= bs.deleteLevel1(commentNo);
		
		
//		List<Map<String,String>>list = null;
//		if (result>0) {
//			list = bs.selectBoardCommentList(BoardNo);
//		}
		
		
		return gson.toJson(result)+"";
	}
	
	//대댓글 쓰기
	@ResponseBody
	@RequestMapping(value="/insertLevel2", produces="text/plain;charset=UTF-8")
	public String insertLevel2(BoardComment bc,@RequestParam("boardNo")int boardNo) {
		log.debug("dddddd={}",bc);
		bc.setContents(bc.getContents().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>"));
		int result = bs.insertBoardComment(bc);
		
		
		
		log.info("result={}",result);
		
		return gson.toJson(result)+"";
		

	}
	
	//대댓글 삭제
	@ResponseBody
	@RequestMapping(value="/deleteLevel2", produces="text/plain;charset=UTF-8")
	public String deleteLevel2(@RequestParam("commentNo") int commentNo) {
		log.debug("삭제할 대댓번호={}",commentNo);
		
		int result = bs.deleteLevel2(commentNo);
		
		return gson.toJson(result)+"";
	}
	
	
	
	
	
	//========================== 현규 끝


}
