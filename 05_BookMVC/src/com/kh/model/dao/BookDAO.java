package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate{


    private Properties p = new Properties();
	
	public BookDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st, conn);
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		// SQL문 : SELECT 테이블 : TB_BOOK
		// ArrayList에 추가할 때 add 메서드!
		// rs.getString("bk_title"); //bkTitle 아님!
		
		Connection conn= getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		ResultSet rs = st.executeQuery();
		
		ArrayList<Book> bookList = new ArrayList<>();
		
		if(rs.next()){
			
			bookList.add(new Book(rs.getInt("bk_no"), rs.getString("bkTitle"), rs.getString("bkAuthor")));
		
		}
		closeAll(rs, st, conn);
		return bookList;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		// 반환값 타입이 int인 경우 다 st.exesuteUpdate()!
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		// 책 삭제! DELETE문!
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		st.setInt(1, no);
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		// id, password, name
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		//char rs.getString("status").charAt(0)
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		st.setString(1, id);
		st.setString(2, password);
		
		ResultSet rs = st.executeQuery();
		
		Member member = null;
		if(rs.next()){
			
			member = new Member();
			member.setMemberNo(rs.getInt("member_no"));
			member.setMemberId(rs.getString("member_id"));
			member.setMemberPwd(rs.getString("member_pwd"));
			member.setMemberName(rs.getString("member_name"));
			member.setStatus(rs.getString("status").charAt(0));
			member.setEnrollDate(rs.getDate("enfoll_Date"));
			
		}
		closeAll(rs, st, conn);
		return member;
	
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		// UPDATE - STATUS를 Y로!
		// status가 n이면 회원 유지, y면 회원 탈퇴
		// n이 기본값! <--- 회원유지!
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteMember"));
		st.setString(1, id);
		st.setString(2, password);
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		// 책 대여 기능! INSERT ~~ TB_RENT
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("rentBook"));
		st.setInt(1, rent.getMember().getMemberNo());
		st.setInt(2, rent.getBook().getBkNo());

		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}


	@Override
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		st.setInt(1, no);
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		return result;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		// SQL문 - JOIN 필요! 테이블 다 엮어야 됨!
		// 이유 --> RENT_NO, RENT_DATE, BK_TITLE, BK_AUTHOR
		// 조건은 MEMBER_ID 가지고 가져오니까!
		// WHILE문 안에서! Rent rent = new Rent();
		// setter 사용!!
		// rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk.author")));
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		st.setString(1, id);
		
		ArrayList<Rent> rentlist = new ArrayList<>();
		Book book = new Book();
		Member member = new Member();
		
		ResultSet rs = st.executeQuery();
		
		while(rs.next()) {
			Rent rent = new Rent();
			rent.setRentNo(rs.getInt("rent_no"));
			rent.setRentDate(rs.getDate("rent_date"));
			rent.setBook(new Book(rs.getString("bk_title"), rs.getString("bk.author")));
			
			rentlist.add(rent);
		}
		closeAll(rs, st, conn);
		return rentlist;
	}
	
	

}
