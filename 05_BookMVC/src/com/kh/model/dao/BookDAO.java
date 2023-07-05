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
		
		ArrayList<Book> booklist = new ArrayList<>();

		Connection conn= getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		ResultSet rs = st.executeQuery();
		
		if(rs.next()){
			
			booklist.add(new Book(rs.getString("bkTitle"), rs.getString("bkAuthor")));
		
		}
		closeAll(rs, st, conn);
		return booklist;
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
		
		ResultSet rs = st.executeQuery();;
		
		Member m = null;
		if(rs.next()){
			
			m = new Member(rs.getString("imemberId"), rs.getString("memberPwd"), rs.getString("memberName"));
			
		}
		closeAll(rs, st, conn);
		return m;
	
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
		st.setInt(1, rent.getRentNo());
		
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
		// rest.setBook(new Book(rs.getString("bk_title"), rs.geString("bk.author")));
		return null;
	}
	
	

}
