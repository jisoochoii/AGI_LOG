package com.agilog.services3;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.agilog.beans.AuthBean;
import com.agilog.beans.BoardBean;
import com.agilog.beans.PostBean;
import com.agilog.beans.PostCommentBean;
import com.agilog.interfaces.ServiceRule;
import com.agilog.utils.Encryption;
import com.agilog.utils.Paging;
import com.agilog.utils.ProjectUtils;

@Service
public class Board3 implements ServiceRule {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private Encryption enc;
	@Autowired
	private ProjectUtils pu;
	private Paging page;

	public Board3() {}

	public void backController(ModelAndView mav, int serviceCode) {
		try {
			if (this.pu.getAttribute("accessInfo") != null) {
				switch (serviceCode) {
				case 580 : this.showFreePostCtl(mav); break;
				}
			} else {
				mav.setViewName("login");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void backController(Model model, int serviceCode) {
		switch (serviceCode) {
		case 60 : this.insertPostCommentCtl(model); break;
		case 61 : this.updatePostCommentCtl(model); break;
		case 62 : this.deletePostCommentCtl(model); break;
		}
	}
	
	// 특정 게시글 댓글 내용 보기
	private void showFreePostCtl(ModelAndView mav) {
		PostCommentBean pcb = new PostCommentBean();
		StringBuffer sb = new StringBuffer();

		PostBean pb = (PostBean)mav.getModel().get("postBean");

		pcb.setFcFbCode(pb.getFbCode());
		pcb.setFcFbDate(pb.getFbDate());
		pcb.setFcFbSuCode(pb.getFbSuCode());
		
		List<PostCommentBean> pcList = this.session.selectList("getPostCommentList", pcb);

		if(pcList.size() != 0) {
			mav.addObject("fbComment", this.makeCommentHTML(pcList));
		}else {
			sb.append("<div>");
			sb.append("<input class=\"fbComment commentInput\" />");
			sb.append("<button class=\"submitBtn btn\" onClick=\"insertBoardComment("+ pcb.getFcFbCode() + "," + pcb.getFcFbSuCode() + "," + pcb.getFcFbDate() + ")\">확인</button>");
			sb.append("</div>");
			sb.append("<div id='commentList'></div>");
			mav.addObject("fbComment", sb.toString());
		}
	}
	
	// 댓글 내용 양식 만들기
	private String makeCommentHTML(List<PostCommentBean> pcList) {
		StringBuffer sb = new StringBuffer();
		int i = -1;

		sb.append("<div>");
		sb.append("<input class=\"fbComment commentInput\" />");
		sb.append("<button class=\"submitBtn btn\" onClick=\"insertBoardComment("+ pcList.get(0).getFcFbCode() + "," + pcList.get(0).getFcFbSuCode() + "," + pcList.get(0).getFcFbDate() + ")\">확인</button>");
		sb.append("</div>");
		sb.append("<div id='commentList'>");

		for(PostCommentBean pb : pcList) {
			i++;

			try {
				AuthBean ab = (AuthBean)this.pu.getAttribute("accessInfo");

				sb.append("<div class = 'comment " + i + "'>");
				// 기본 프로필 사진 or 내가 등록한 프로필 사진
				if(pcList.get(i).getSuPhoto() != null) {
					sb.append("<img class='profileImage' src=" + pcList.get(i).getSuPhoto() + ">");
				} else {
					sb.append("<img class='profileImage' src='/res/img/profile_default.png'>");
				}

				sb.append("<div class = 'suNickname'>" + pcList.get(i).getSuNickname() + "</div>");
				sb.append("<div class=\"fcContent " + pcList.get(i).getFcDate() + "\">" + pcList.get(i).getFcContent() + "</div>");

				// 댓글 수정, 삭제 버튼 :: 내가 쓴 댓글의 경우만 수정, 삭제 버튼 생성
				if(ab.getSuCode().equals(pcList.get(i).getFcSuCode())) {
					sb.append("<i class=\"fa-solid fa-pen updBtn editBtn\" onClick=\"updateInput(" + pcList.get(i).getFcFbCode() + "," + pcList.get(i).getFcFbSuCode() + "," + pcList.get(i).getFcCode() + "," + pcList.get(i).getFcDate() + "," + pcList.get(i).getFcFbDate() + ")\"></i>");
					sb.append("<i class=\"fa-solid fa-trash-can delBtn editBtn\" onClick=\"deleteBoardComment(" + pcList.get(i).getFcFbCode() + "," + pcList.get(i).getFcFbSuCode() + "," + pcList.get(i).getFcCode() + "," + pcList.get(i).getFcDate() + "," + pcList.get(i).getFcFbDate() + ")\"></i>");
				}
				sb.append("</div>");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		sb.append("</div>");

		return sb.toString();
	}

	// 특정 게시글에 댓글 등록
	@Transactional(rollbackFor = SQLException.class)
	private void insertPostCommentCtl(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		PostCommentBean pcb = (PostCommentBean)model.getAttribute("postCommentBean");
		System.out.println("날짜 확인 : " + pcb.getFcDate());
		System.out.println("날짜 확인 : " + pcb.getFcFbDate());
		
		try {
			AuthBean ab = (AuthBean)this.pu.getAttribute("accessInfo");
			
			pcb.setFcSuCode(ab.getSuCode());
			pcb.setFcCode((String)this.session.selectOne("getFcCode", pcb.getFcFbCode()));
			if(this.convertToBoolean(this.session.insert("insPostComment", pcb))) {
				System.out.println("자유게시판 댓글 등록 성공");
				
				map.put("suCode", ab.getSuCode());
				map.put("fbComment", this.session.selectList("getPostCommentList", pcb));
				model.addAttribute("insfbComment", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 특정 게시글에 댓글 수정
	@Transactional(rollbackFor = SQLException.class)
	private void updatePostCommentCtl(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		PostCommentBean pcb = (PostCommentBean)model.getAttribute("postCommentBean");

		try {
			AuthBean ab = (AuthBean)this.pu.getAttribute("accessInfo");
			
			pcb.setFcSuCode(ab.getSuCode());

			if(this.convertToBoolean(this.session.update("updPostComment", pcb))) {
				System.out.println("자유게시판 댓글 수정 성공");
				
				map.put("suCode", ab.getSuCode());
				map.put("fbComment", this.session.selectList("getPostCommentList", pcb));
				model.addAttribute("updfbComment", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 특정 게시글에 댓글 삭제
	@Transactional(rollbackFor = SQLException.class)
	private void deletePostCommentCtl(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		PostCommentBean pcb = (PostCommentBean)model.getAttribute("postCommentBean");

		try {
			AuthBean ab = (AuthBean)this.pu.getAttribute("accessInfo");
			
			pcb.setFcSuCode(ab.getSuCode());
			
			if(this.convertToBoolean(this.session.delete("delPostComment", pcb))) {
				System.out.println("자유게시판 댓글 삭제 성공");

				map.put("suCode", ab.getSuCode());
				map.put("fbComment", this.session.selectList("getPostCommentList", pcb));
				model.addAttribute("delfbComment", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void moveInfoBoardCtl(ModelAndView mav) {
	
	}
	
	private void moveWritePageCtl(ModelAndView mav) {

	}
	
	private void moveShowPostCtl(ModelAndView mav) {
		
	}
	
	/*private void insertPostCtl(ModelAndView mav) {
	System.out.println("인서트 진입 체크1");
	
	try {
		AuthBean ab = ((AuthBean) this.pu.getAttribute("accessInfo"));
		if(ab != null) {
			//포스트빈 세팅
			PostBean pb = (PostBean) mav.getModel().get("postBean");
			
			pb.setFbSuCode(ab.getSuCode());

			if (this.session.selectOne("getFbCode") == null) {
				pb.setFbCode("1");
			} else {
				pb.setFbCode(Integer.toString(Integer.parseInt(this.session.selectOne("getFbCode"))+1));
			}
			System.out.println("코드 체크2 : " + pb.getFbCode());
			System.out.println("유저 코드 체크 : " + pb.getFbSuCode());
			System.out.println("타이틀 체크 : " + pb.getFbTitle());
			System.out.println("컨텐츠 체크 : " + pb.getFbContent());
			
			if(this.convertToBoolean(this.session.insert("insFbPost", pb))) {
				mav.setViewName("freeBoard");
			}
		} else {
			mav.addObject("message", "세션이 만료되었습니다. 다시 로그인 해주세요");
			mav.setViewName("dashBoard");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	//포스트빈 세팅
	PostBean pb = (PostBean) mav.getModel().get("postBean");
	
	System.out.println("타이틀 체크 : " + pb.getFbTitle());
	System.out.println("컨텐츠 체크 : " + pb.getFbContent());

	mav.setViewName("freeBoard");
}*/


//정보게시판 목록 EL 작업
private String makeBoardList(List<BoardBean> BoardList) {
	StringBuffer sb = new StringBuffer();
	return sb.toString();
	
}

	private boolean convertToBoolean(int booleanCheck) {
		return booleanCheck == 0 ? false : true;
	}

}
