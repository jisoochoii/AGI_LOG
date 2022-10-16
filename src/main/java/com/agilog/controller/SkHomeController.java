package com.agilog.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.agilog.beans.AuthBean;
import com.agilog.beans.BebeCalendarBean;
import com.agilog.beans.BoardBean;
import com.agilog.beans.CompanyBean;
import com.agilog.beans.DailyDiaryBean;
import com.agilog.beans.HealthDiaryBean;
import com.agilog.beans.MyPageBean;
import com.agilog.services.Authentication;
import com.agilog.services.BebeCalendar;
import com.agilog.services.BebeMap;
import com.agilog.services.Board;
import com.agilog.services.Company;
import com.agilog.services.DailyDiary;
import com.agilog.services.DashBoard;
import com.agilog.services.HealthDiary;
import com.agilog.services.MyPage;
import com.agilog.services3.BebeCalendar3;

@Controller
public class SkHomeController {
	@Autowired
	Authentication auth;
	@Autowired
	DashBoard dashBoard;
	@Autowired
	Company company;
	@Autowired
	DailyDiary dailyDiary;
	@Autowired
	HealthDiary healthDiary;
	@Autowired
	BebeMap bebeMap;
	@Autowired
	BebeCalendar3 bebeCalendar3;
	@Autowired
	Board board;
	@Autowired
	MyPage myPage;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mav) {

		this.dashBoard.backController(mav, 4);
		return mav;
	}

	@RequestMapping(value = "/MoveLoginPage", method = RequestMethod.GET)
	public ModelAndView moveLoginPage(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 1);

		return mav;
	}

	@RequestMapping(value = "/MoveJoinPage", method = RequestMethod.GET)
	public ModelAndView moveJoinPage(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 2);

		return mav;
	}

	@RequestMapping(value = "/MoveCompanyLoginPage", method = RequestMethod.GET)
	public ModelAndView moveCompanyLoginPage(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 3);

		return mav;
	}

	@RequestMapping(value = "/MoveMainPage", method = RequestMethod.GET)
	public ModelAndView moveMainPage(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.dashBoard.backController(mav, 4);

		return mav;
	}

	@RequestMapping(value = "/MoveDailyDiaryPage", method = RequestMethod.GET)
	public ModelAndView moveDailyDiaryPage(ModelAndView mav, @ModelAttribute DailyDiaryBean ddb) {
		mav.addObject(ddb);
		this.dailyDiary.backController(mav, 5);

		return mav;
	}

	@RequestMapping(value = "/MoveCalendarPage", method = RequestMethod.GET)
	public ModelAndView moveCalendarPage(ModelAndView mav, @ModelAttribute BebeCalendarBean bcb) {
		mav.addObject(bcb);
		this.bebeCalendar3.backController(mav, 7);

		return mav;
	}

	@RequestMapping(value = "/MoveMyPage", method = RequestMethod.GET)
	public ModelAndView moveMyPage(ModelAndView mav, @ModelAttribute MyPageBean mb) {
		mav.addObject(mb);
		this.myPage.backController(mav, 9);

		return mav;
	}
	
	@RequestMapping(value = "/MoveNaverLogin", method = RequestMethod.GET)
	public ModelAndView moveNaverLogin(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.setViewName("callBack");
		
		return mav;
	}
	
	@RequestMapping(value = "/NaverLogin", method = RequestMethod.POST)
	public ModelAndView naverLogin(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 14);

		return mav;
	}
	
	@RequestMapping(value = "/KakaoLogin", method = RequestMethod.POST)
	public ModelAndView kakaoLogin(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 15);

		return mav;
	}
	
	@RequestMapping(value = "/Logout", method = RequestMethod.POST)
	public ModelAndView logout(ModelAndView mav, @ModelAttribute AuthBean auth) {
		mav.addObject(auth);
		this.auth.backController(mav, 93);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveCheckManager", method = RequestMethod.GET)
	public ModelAndView moveCheckManager(ModelAndView mav, HttpServletRequest req) {
		mav.addObject("pageCode", req.getParameter("pageCode"));
		this.company.backController(mav, 70);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveCheckDoctor", method = RequestMethod.GET)
	public ModelAndView moveCheckDoctor(ModelAndView mav, @ModelAttribute CompanyBean cb) {
		this.company.backController(mav, 81);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveJoinFormPage", method = RequestMethod.POST)
	public ModelAndView moveJoinFormPage(ModelAndView mav, @ModelAttribute AuthBean ab) {
		mav.addObject(ab);
		this.auth.backController(mav, 10);
		
		return mav;
	}	
	
	@RequestMapping(value = "/SocialJoin", method = RequestMethod.POST)
	public ModelAndView socialJoin(ModelAndView mav, @ModelAttribute AuthBean ab,HttpServletRequest req) {
		mav.addObject("req",req);
		mav.addObject(ab);
		this.auth.backController(mav, 20);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveHealthDiaryPage", method = RequestMethod.GET)
	public ModelAndView moveHealthDiaryPage(ModelAndView mav, @ModelAttribute HealthDiaryBean hb) {
		mav.addObject(hb);
		this.healthDiary.backController(mav, 33);
		
		return mav;
	}
	
	@RequestMapping(value = "/InsertHealthDiary", method = RequestMethod.POST)
	public ModelAndView insertHealthDiary(ModelAndView mav, @ModelAttribute HealthDiaryBean hb) {
		mav.addObject(hb);
		this.healthDiary.backController(mav, 37);
		if (mav.getModel().get("returnAction2") != null || mav.getModel().get("returnAction2")=="") {
			BebeCalendarBean bcb = new BebeCalendarBean();
			mav.addObject(bcb);
			this.bebeCalendar3.backController(mav, 7);
		}
		return mav;
	}
	
	@RequestMapping(value = "/DeleteHealthDiary", method = RequestMethod.POST)
	public ModelAndView deleteHealthDiary(ModelAndView mav, @ModelAttribute HealthDiaryBean hb) {
		mav.addObject(hb);
		this.healthDiary.backController(mav, 30);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveDoctorComment", method = RequestMethod.GET)
	public ModelAndView moveDoctorComment(ModelAndView mav, @ModelAttribute AuthBean ab) {
		mav.addObject(ab);
		this.healthDiary.backController(mav, 76);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveDailyDiaryPage", method = RequestMethod.POST)
	public ModelAndView moveWriteDailyDiary(ModelAndView mav, @ModelAttribute DailyDiaryBean hb) {
		mav.addObject(hb);
		this.dailyDiary.backController(mav, 5);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveMyDailyDiaryPage", method = RequestMethod.POST)
	public ModelAndView moveMyDailyDiary(ModelAndView mav, @ModelAttribute DailyDiaryBean hb) {
		mav.addObject(hb);
		this.dailyDiary.backController(mav, 32);
		
		return mav;
	}
	
	@RequestMapping(value = "/MoveHealthDiaryPage", method = RequestMethod.POST)
	public ModelAndView moveMyHealthDiary(ModelAndView mav, @ModelAttribute HealthDiaryBean hb) {
		mav.addObject(hb);
		this.healthDiary.backController(mav, 33);
		
		return mav;
	}
}
