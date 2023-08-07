package com.poseidon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller // 컨트롤러 지정
public class IndexController {

	//첫화면 로딩 : index.jsp호출
	@GetMapping(value = { "/", "/index"}) // 매핑작업
	public String index() {
		return "index"; //데이터 붙임 
		
	}
	
	//임시호출
	@GetMapping("/board2")
	public String menu() {
		return "board2";
	}
	//임시호출
	@GetMapping("/mooni")
	public String mooni() {
		return "mooni";
	}
	//임시호출
	@GetMapping("/notice")
	public String notice() {
		return "notice";
	}

}
