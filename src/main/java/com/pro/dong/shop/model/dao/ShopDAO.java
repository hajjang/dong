package com.pro.dong.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

public interface ShopDAO {

	// 민호 시작 ==========================
	int shopFollow(Map<String, String> param);
	int isFollowing(Map<String, String> param);
	int shopUnfollow(Map<String, String> param);
	int selectFollowListCount(String follow);
	List<Map<String, String>> selectFollowList(String follow, int cPage, int numPerPage);
	int selectFollowerListCount(String follower);
	List<Map<String, String>> selectFollowerList(String follower, int cPage, int numPerPage);
	List<Map<String, String>> loadReviewGrade();
	Shop selectOneShopByShopName(String shopName);
	int insertReview(Map<String, String> param);
	List<Map<String, String>> loadShopReview(Map<String, String> param, int cPage, int numPerPage);
	int selectShopReviewListCount(Map<String, String> param);
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	List<Map<String, String>> loadMyProductList(String memberId, int cPage, int numPerPage);
	int totalCountMyProduct(String memberId);
	int productUpdate(String productNo);
	int productDelete(String productNo);
	int saleStatus(Map<String, String> param);
	int totalProductContents(Map<String, String> param);
	List<Map<String, String>> loadMyProductManage(int cPage, int numPerPage, Map<String, String> param);
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	int selectOpenDate(String memberId);
	
	int shopInCount(int shopNo);
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	List<Shop> searchShop(Map<String,String> param);
	Shop selectOneShopByShopNo(int shopNo);
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	Map<String, String> selectOneShop(String memberId);

	int updateShopInfo(Map<String, String> param);

	int selectShopNameCheck(Map<String, String> param);

	int updateShopName(Map<String, String> param);

	int updateShopImg(Shop s);

	List<ShopInquriy> selectShopInquiry(int shopNo);

	int insertShopInquriy(Map<String, String> param);

	int deleteShopInquriy(int deleteCommentBtn);

	int selectTotalInpuiry(int shopNo);
	
	int insertInquiryComment(Map<String, String> param);
	
	Map<String, String> selectShopByShopNo(int shopNo);
	
	List<Map<String, Object>> selectMyWishList(String memberId, int cPage, int numPerPage);
	
	int selectMyWishListTotalContents(String memberId);
	
	int deleteWishProduct(Map<String, String> param);
	
	int deleteShopInquriyComment(int deleteCommentBtn);
	
	
	
	
	
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
}
