package org.kosta.pamuk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.pamuk.model.vo.MemberVO;
import org.kosta.pamuk.service.MemberService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin")
public class AdminController {
	@Resource
	private MemberService memberService;
	
	@Secured("ROLE_ADMIN")
	@RequestMapping("main")
	public String adminMain() {
		return "admin/main.tiles";
	}
	
	// 스타쉐프 권한 박탈
		@Secured("ROLE_ADMIN")
		@RequestMapping("starChefList")
		public String starChefListView(Model model) {
			List<MemberVO> mvo = memberService.starChefList();
			model.addAttribute("list", mvo);
			List<MemberVO> mlist = memberService.findMemberAllForAdmin();
			model.addAttribute("mlist", mlist);
			return "admin/starChefListView.tiles";
		}
		@Secured("ROLE_ADMIN")
		@RequestMapping(value = "/disaccreditStarChef", method = RequestMethod.POST)
		public String disaccreditStarChef(String memberId) {
			memberService.disaccreditStarChef(memberId);
			return "redirect:starChefList";
		}
		
		// 스타쉐프 권한 부여
		/*
		@Secured("ROLE_ADMIN")
		@RequestMapping("findMemberAllForAdmin")
		public String findMemberFormForStarChef(Model model) {
			
			return "admin/findMemberFormForAdmin.tiles";
		}
		*/
		@Secured("ROLE_ADMIN")
		@RequestMapping(value = "/authorizeStarChef", method = RequestMethod.POST)
		public String authorizeStarChef(String memberId) {
			memberService.authorizeStarChef(memberId);
			return "redirect:starChefList";
		}
}
