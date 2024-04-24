package data.theater.info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.mysql.DbConnect;

public class TheaterDao {
	DbConnect db = new DbConnect();

	// 모든 지역의 극장 리스트
	public List<TheaterDto> regionList() {
		List<TheaterDto> list = new ArrayList<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = db.getConnection();
			String sql = "SELECT * FROM THEATER_INFO";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				TheaterDto dto = new TheaterDto();
				dto.setAddress(rs.getString("address"));
				dto.setBranch(rs.getString("branch"));
				dto.setIs_4d(rs.getInt("is_4d"));
				dto.setIs_imax(rs.getInt("is_imax"));
				dto.setNumber_of_screens(rs.getInt("number_of_screens"));
				dto.setRegion(rs.getString("region"));
				dto.setTheater_id(rs.getString("theater_id"));
				//dto.setTheater_img(rs.getString("theater_img"));
				dto.setTheater_phone_number(rs.getString("theater_phone_number"));
				dto.setTotal_theater_seats(rs.getInt("total_theater_seats"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return list;
	}
	
	// 지역 출력
	public List<TheaterDto> getRegionList() {
		List<TheaterDto> list = new ArrayList<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = db.getConnection();
			String sql = "SELECT region, MAX(theater_id) AS theater_id FROM THEATER_INFO GROUP BY region;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TheaterDto dto = new TheaterDto();
				dto.setRegion(rs.getString("region"));
				dto.setTheater_id(rs.getString("theater_id"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 지점 출력
	public List<TheaterDto> getBranchList() {
		List<TheaterDto> list = new ArrayList<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = db.getConnection();
			String sql = "SELECT DISTINCT branch, theater_id FROM THEATER_INFO where region='서울'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TheaterDto dto = new TheaterDto();
				dto.setTheater_id(rs.getString("theater_id"));
				dto.setBranch(rs.getString("branch"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 영화 지점에 대한 지역 출력
	public List<TheaterDto> getBranchListByRegion(String movieId) {
		List<TheaterDto> list = new ArrayList<>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = db.getConnection();
			String sql = "SELECT branch, theater_id FROM THEATER_INFO\r\n"
					+ "where theater_id = (select S.theater_id from screening_info S, (select * from movie_info where movie_id=?) M\r\n"
					+ "									where S.movie_id=M.movie_id);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieId);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				TheaterDto dto = new TheaterDto();
				dto.setTheater_id(rs.getString("theater_id"));
				dto.setBranch(rs.getString("branch"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}

	// 해당 지역의 모든 지점명을 가져오는 메서드
	public List<String> addressList(String region) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<String> theaterNames = new ArrayList<>();

		try {
			conn = db.getConnection();
			String sql = "SELECT branch FROM THEATER_INFO WHERE region = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, region);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String theaterName = rs.getString("branch");
				theaterNames.add(theaterName);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return theaterNames;
	}

	// 특정 지점의 상영 정보를 가져오는 매서드
	public TheaterDto theaterList(String branch) {
		TheaterDto dto = new TheaterDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM THEATER_INFO WHERE branch = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, branch);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto.setAddress(rs.getString("address"));
				dto.setBranch(rs.getString("branch"));
				dto.setIs_4d(rs.getInt("is_4d"));
				dto.setIs_imax(rs.getInt("is_imax"));
				dto.setNumber_of_screens(rs.getInt("number_of_screens"));
				dto.setRegion(rs.getString("region"));
				dto.setTheater_id(rs.getString("theater_id"));
				//dto.setTheater_img(rs.getString("theater_img"));
				dto.setTheater_phone_number(rs.getString("theater_phone_number"));
				dto.setTotal_theater_seats(rs.getInt("total_theater_seats"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;

	}
}