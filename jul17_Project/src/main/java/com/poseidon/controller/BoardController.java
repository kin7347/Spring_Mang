package com.poseidon.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.PageDTO;
import com.poseidon.service.BoardService;
import com.poseidon.util.Util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	//uesr - Controller - Service - DAO - mybatis - DB
	
	//Autowired 말고 Resource로 연결
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Autowired
	private Util util; //우리가 만든 숫자변환을 사용하기 위해서 객체연결

	//localhost/board?pageNo=10 이런식으로 불러와줄꺼 
	@GetMapping("/board")
	public String board(@RequestParam(value = "pageNo" , required = false, defaultValue = "1") int pageNo, Model model) {
		//서비스에서 값 가져오기
		//페이지네이션인포 -> 값 넣고 -> DB -> jsp
		//PaginationInfo에 필수 정보를 넣어 준다
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageNo); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한페이지에 게시되는 게시글수
		paginationInfo.setPageSize(10); //페이징 리스트의 사이즈
		//전체 글 수 가져오는 명령 문
		int totalCount = boardService.totalCount();
		paginationInfo.setTotalRecordCount(totalCount); 
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex(); //시작위치
		int recordCountPerPage = paginationInfo.getRecordCountPerPage(); //페이지당 글 몇개보여줄지
		
		//System.out.println(firstRecordIndex);
		//System.out.println(recordCountPerPage);
		//System.out.println(pageNo);
		//System.out.println(totalCount);
		
		PageDTO page = new PageDTO();
		page.setFirstRecordIndex(firstRecordIndex);
		page.setRecordCountPerPage(recordCountPerPage);
		
		//보드서비스 수정합니다
		List<BoardDTO> list = boardService.boardList(page);
		
		model.addAttribute("list" , list);
		//페이징 관련 정보가 있는 PaginationInfo 객체를 모델에 반드시 넣어준다.
		model.addAttribute("paginationInfo",paginationInfo);
		
		return "board";
	}
	
	//http://localhost:8080/pro1/detail?bno=121
	//파라미터로 들어오는 값 잡기
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, Model model) {
		//String bno = request.getParameter("bno");
		int bno = util.strToInt(request.getParameter("bno"));
		
		// bno에 요청하는 값이 있습니다. 이 값을 db까지 보내겠습니다.
		// System.out.println("bno : " + bno);
		
		//DTO로 변경합니다.
		BoardDTO dto = new BoardDTO();
		dto.setBno(bno);
		//dto.setM_id(null); 글 상세보기에서는 mid가 없어도 됩니다.
		
		BoardDTO result = boardService.detail(dto);
		//System.out.println(result.getCommentcount()); //한번찍어보기
		if(result.getCommentcount() > 0) {
			//데이터베이스에 물어봐서 jsp로 보냅니다
			//해당 글의(bno) 댓글이 몇개인지 확인 
			List<Map<String, Object>> commentsList = boardService.commentsList(bno);
		   
			model.addAttribute("commentsList", commentsList);
		}
		model.addAttribute("dto", result);

		return "detail";
	}
	
	
	@GetMapping("/write")
	public String write(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("mname") != null) {			
			return "write";
		} else {
			return "redirect:/login"; //슬러시 넣어주세요.
		}
	}

	@PostMapping("/write")
	public String write2(HttpServletRequest request) {

		HttpSession session = request.getSession();
		if(session.getAttribute("mid") != null) {
			//로그인 했습니다. = 아래 로직을 여기로 가져오세요.
			BoardDTO dto = new BoardDTO();
			dto.setBtitle(request.getParameter("title"));
			dto.setBcontent(request.getParameter("content"));
			//세션에서 불러오겠습니다.
			dto.setM_id((String) session.getAttribute("mid"));//세션에서 가져옴
			//dto.setM_name((String) session.getAttribute("mname"));//세션에서 가져옴
			dto.setUuid(UUID.randomUUID().toString());
			
			// Service -> DAO -> mybatis-> DB로 보내서 저장하기
			boardService.write(dto);

			return "redirect:board";// 다시 컨트롤러 지나가기 GET방식으로 갑니다
		} else {
			//로그인 안 했어요. = 로그인 하세요.
			return "redirect:/login";
		}
		
	}
	//삭제가 들어온다면 http://172.30.1.19/delete?bno=150
	@GetMapping("/delete")
	public String delete(@RequestParam(value = "bno", required = true, defaultValue = "0") int bno, HttpSession session) {
		//System.out.println("bno : " + bno);
		//dto
		BoardDTO dto = new BoardDTO();
		dto.setBno(bno);
		dto.setM_id((String) session.getAttribute("mid"));
		//dto.setBwrite(null) 사용자 정보
		//추후 로그인을 하면 사용자의 정보도 담아서 보냅니다.
		
		boardService.delete(dto);
		
		return "redirect:board";// 삭제를 완료한 후에 다시 보드로 갑니다.
	}
	
	//수정하기 
	@GetMapping("/edit")
	public ModelAndView edit(HttpServletRequest request) {
		//로그인 하지 않으면 로그인 화면으로 던져주세요
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView();//edit.jsp
		
     if(session.getAttribute("mid") != null) {
		//dto를 하나 만들어서 거기에 담겠습니다. = bno, mid
		BoardDTO dto = new BoardDTO();
		dto.setBno(util.strToInt(request.getParameter("bno")));
		//내글만 수정할 수 있도록 세션에 있는 mid도 보냅니다.
		dto.setM_id((String)session.getAttribute("mid"));
		
		//데이터베이스에 bno를 보내서 dto를 얻어옵니다.
		BoardDTO result = boardService.detail(dto);
		
		if(result != null) { //내 글을 수정했습니다.
		//mv에 실어보냅니다.
		mv.addObject("dto", result);
		mv.setViewName("edit"); //이동할 jsp명을 적어줍니다
		}else { //다른 사람 글이라면 null입니다. 경고창으로 이동합니다
			mv.setViewName("error600");
		}
	}else {
			//로그인 안 했다. = login컨트롤러 
			mv.setViewName("redrect:login");
		}
        return mv; 
	}
	
	@PostMapping("/edit")
	public String edit(BoardDTO dto) {  //int , bno
		//System.out.println("map" + map);
		//System.out.println(dto.getBtitle());
		//System.out.println(dto.getBcontent());
		//System.out.println(dto.getBno());
		
		boardService.edit(dto);
		
		//return "redirect:detail?bno"+dto.getBno(); //보드로 이동하게 해줘
		return "redirect:board"; //보드로 이동하게 해줘
	}
	
	//2023-08-07 프레임워크 프로그래밍
	//댓글삭제
	@GetMapping("/cdel") //bno , cno 
	public String cdel(@RequestParam Map<String, Object> map, HttpSession session) {
		//로그인여부 검사
		if(session.getAttribute("mid") != null) {
		//값 들어왔는지 여부 검사
			if(map.get("bno") != null && map.get("cno") != null &&
					!(map.get("bno").equals(""))&& !(map.get("cno").equals(""))&&
					util.isNum(map.get("bno"))&& util.isNum(map.get("cno"))) {
				
				//System.out.println("여기로 들어왔습니다.");
				map.put("mid", session.getAttribute("mid"));
				int result = boardService.cdel(map);
				System.out.println("삭제 결과 : " + result);
			}
		}
		return "redirect:/detail?bno="+map.get("bno");
	}

	

}
