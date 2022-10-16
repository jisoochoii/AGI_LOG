package com.agilog.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.agilog.beans.AuthBean;
import com.agilog.beans.BebeCalendarBean;
import com.agilog.beans.BoardBean;
import com.agilog.beans.DailyDiaryBean;
import com.agilog.beans.MyPageBean;
import com.agilog.beans.PostBean;
import com.agilog.beans.ReservationBean;
import com.agilog.services.Authentication;
import com.agilog.services.BebeCalendar;
import com.agilog.services.BebeMap;
import com.agilog.services.Board;
import com.agilog.services.Company;
import com.agilog.services.DailyDiary;
import com.agilog.services.DashBoard;
import com.agilog.services.MyPage;
import com.agilog.services2.Board2;
import com.agilog.services2.Company2;
import com.agilog.services2.DailyDiary2;

@Controller
public class ThHomeController {
	@Autowired
	Authentication auth;
	@Autowired
	DashBoard dashBoard;
	@Autowired
	Company2 company;
	@Autowired
	DailyDiary2 dailyDiary;
	@Autowired
	BebeMap bebeMap;
	@Autowired
	BebeCalendar bebeCalendar;
	@Autowired
	Board2 board;
	@Autowired
	MyPage myPage;

	@RequestMapping(value = "/MoveWritePage", method = RequestMethod.POST)
	public ModelAndView moveWritePage(ModelAndView mav) {
		this.board.backController(mav, 57);
		return mav;
	}
	
	@RequestMapping(value = "/InsertPost", method = RequestMethod.POST)
	public ModelAndView insertPost(HttpServletRequest req, ModelAndView mav, @RequestParam() MultipartFile[] files, @ModelAttribute PostBean pb) {
		mav.addObject("req",req);
		mav.addObject("files", files);
		mav.addObject(pb);
		this.board.backController(mav, 65);
		return mav;
	}
	
	@RequestMapping(value = "/UpdatePost", method = RequestMethod.POST)
	public ModelAndView updatePost(ModelAndView mav, @ModelAttribute PostBean pb) {
		mav.addObject(pb);
		this.board.backController(mav, 102);
		return mav;
	}
	
	@RequestMapping(value = "/MoveBoardPage", method = RequestMethod.GET)
	
	public ModelAndView moveBoardPage(ModelAndView mav, @ModelAttribute PostBean pb) {
		mav.addObject(pb);
		this.board.backController(mav, 8);

		return mav;
	}
	
	//게시판 글 내용 보기
	@RequestMapping(value = "/MoveShowFbPost", method = RequestMethod.POST)
	public ModelAndView moveShowFbPostCtl(ModelAndView mav, @ModelAttribute PostBean pb) {
		mav.addObject(pb);
		this.board.backController(mav, 581);
		return mav;
	}

	//게시글 삭제
	@RequestMapping(value = "/MoveUpdateFBPost", method = RequestMethod.POST)
	public ModelAndView moveUpdateFBPost(ModelAndView mav, @ModelAttribute PostBean pb) {
		mav.addObject(pb);
		this.board.backController(mav, 101);
		return mav;
	}

	//게시글 삭제
	@RequestMapping(value = "/DeleteFBPost", method = RequestMethod.POST)
	public ModelAndView deleteFBPost(HttpServletRequest req, ModelAndView mav, @ModelAttribute PostBean pb) {
		mav.addObject("req",req);
		mav.addObject(pb);
		this.board.backController(mav, 96);
		return mav;
	}

	//감성일기 등록
	@RequestMapping(value = "/InsertDailyDiary", method = RequestMethod.POST)
	public ModelAndView insertDailyDiary(HttpServletRequest req,ModelAndView mav, @RequestParam() MultipartFile files, @ModelAttribute DailyDiaryBean db) {
		mav.addObject("req",req);
		mav.addObject("files", files);
		mav.addObject(db);
		this.dailyDiary.backController(mav, 35);
		return mav;
	}

	//감성일기 등록
	@RequestMapping(value = "/DeleteDailyDiaryFeed", method = RequestMethod.POST)
	public ModelAndView deleteDailyDiaryFeed(HttpServletRequest req, ModelAndView mav, @ModelAttribute DailyDiaryBean db) {
		mav.addObject("req",req);
		mav.addObject(db);
		this.dailyDiary.backController(mav, 87);
		return mav;
	}
}