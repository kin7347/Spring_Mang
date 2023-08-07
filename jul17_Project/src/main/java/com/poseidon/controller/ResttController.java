package com.poseidon.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.poseidon.service.BoardService;
import com.poseidon.service.LoginService;
import com.poseidon.util.Util;

@RestController
public class ResttController {

	@Autowired
	private LoginService loginService;
	//Autowired 말고 Resource로 연결
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Autowired
	private Util util;
	
	//아이디 중복검사 
	@PostMapping("/checkID")
	public String checkID(@RequestParam("id") String id) {
		//System.out.println("id : " + id);
		int result = loginService.checkID(id);
		//System.out.println(result);
		//json
		JSONObject json = new JSONObject();
		json.put("result", result);
		System.out.println(json.toString());
		
		return json.toString();  //{result : 1 }
	}
	
	//자바스크립트로 만든 것.
	@PostMapping("/checkID2")
	public String checkID2(@RequestParam("id") String id) {
		int result = loginService.checkID(id);
		return result+"";
	}
	
	
	
	//boardList2
	@GetMapping(value = "/boardList2", produces ="application/json; charset=UTF-8")
	public String boardList2(@RequestParam("pageNo") int pageNo) {
		System.out.println("jq가 보내주는 : " + pageNo);
		
		List<Map<String, Object>> list = loginService.boardList2((pageNo - 1) * 10); //맵10개가 되어있는 리스트를 
		System.out.println(list);
		JSONObject json = new JSONObject();
		JSONArray arr = new JSONArray(list);   //제이슨의 배열 형태로 변경
		json.put("totalCount", loginService.totalCount());
		json.put("pageNo", pageNo);
		json.put("list", arr);
		//System.out.println(json.toString());
		
		return json.toString();
	}
	
	//객체 : {키 : 값, 이름 : 값, ...반복....}
	
	@PostMapping("/cdelR")
	public String cdelR(@RequestParam Map<String, Object>map, HttpSession session) {
		int result = 0;
		JSONObject json = new JSONObject();
		//로그인여부 검사
		if(session.getAttribute("mid") != null) {
		//값 들어왔는지 여부 검사
			if(map.containsKey("bno") && map.get("cno") != null &&
			 !(map.get("bno").equals(""))&& !(map.get("cno").equals(""))&&
			 util.isNum(map.get("bno"))&& util.isNum(map.get("cno"))) {

				//System.out.println(map);	
				map.put("mid", session.getAttribute("mid"));
				
				result = boardService.cdel(map);
				json.put("result", result);
				
				//System.out.println("삭제 결과 : " + result);
			}
		}
		return json.toString();
	}
	
	
	
	
}
