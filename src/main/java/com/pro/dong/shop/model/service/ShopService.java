package com.pro.dong.shop.model.service;

import java.util.Map;

import com.pro.dong.shop.model.vo.Shop;

public interface ShopService {

	// 민호 시작 ==========================
	
	
	
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	
	
	
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	
	
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	Map<String, String> selectOneShop(String memberId);

	int updateShopInfo(Map<String, String> param);

	int selectShopNameCheck(Map<String, String> param);

	int updateShopName(Map<String, String> param);

	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
