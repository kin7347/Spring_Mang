package com.poseidon.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poseidon.dao.BoardDAO;
import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.PageDTO;
import com.poseidon.util.Util;

@Service("boardService")
public class BoardService {

	@Inject // 주입
	@Named("boardDAO")
	private BoardDAO boardDAO;

	@Autowired
	private Util util;

	// 보드 리스트 불러오는 메소드
	public List<BoardDTO> boardList(PageDTO page) {
		
		return boardDAO.boardList(page);
	}

	public BoardDTO detail(BoardDTO dto2) {
		boardDAO.likeUp(dto2);
		
		BoardDTO dto = boardDAO.detail(dto2);
		
		//if( dto != null) {
		//검사 : .이 없거나, null이면 실행하지 않게 해주세요.
		if(dto.getBip() != null && dto.getBip().indexOf(".") != -1) {
			//여기서 ip뽑아올 수 있죠?
			String ip = dto.getBip();
			//ip 중간에 하트 넣어주실 수 있죠? 172.30.1.19 ---> 172.♡.1.19
			String[] ipArr = ip.split("[.]"); // ("\\.")
			ipArr[1] = "♡";
			//그거 다시 ip에 저장하실 수 있죠?
			dto.setBip(String.join(".", ipArr));
			//끝.
		}
	  //}
		return dto;
	}

	// 글쓰기 입니다.
	public void write(BoardDTO dto) {

		// btitle 값을 꺼내줍니다
		String btitle = dto.getBtitle();

		// 값을 변경하겠습니다. replase() < -> &lt; > -> &gt;
		//btitle = btitle.replace("<", "&lt");
		//btitle = btitle.replace(">", "&gt");

		//btitle = util.exchange(btitle);
		dto.setBtitle(util.exchange(btitle));

		//dto.setBtitle(btitle);

		// dto.setBtitle(null);

		dto.setBip(util.getIp()); // 얻어온 ip도 저장해서 데이터베이스로 보내겠습니다

		boardDAO.write(dto); // 실행만 시키고 결과를 받지 않습니다.
		// select를 제외한 나머지는 영향받은 행의 수 (int)를 받아오기도 합니다.
	}

	public void delete(BoardDTO dto) {
		boardDAO.delete(dto);
	}

	public void edit(BoardDTO dto) {
		dto.setBip(util.getIp());
		boardDAO.edit(dto);
	}

	public int totalCount() {
		return boardDAO.totalCount();
	}

	public List<Map<String, Object>> commentsList(int bno) {
		return boardDAO.commentsList(bno);
	}

	public int cdel(Map<String, Object> map) {
	    return boardDAO.cdel(map);
	}






}
