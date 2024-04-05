<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.jsoup.*" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="data.movie.movieinfo.MovieDto" %>
<%@ page import="data.movie.movieinfo.MovieDao" %>


<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	request.setCharacterEncoding("utf-8");
	
	String rootUrl = "http://www.cgv.co.kr";
	String crawlingUrl = "http://www.cgv.co.kr/movies/";  // ũ�Ѹ��� CGV ������Ʈ�� URL => ���� ���۸� ���� üũ��
	
	Document doc = null;  // HTML ������ ������ ���� �ʱ�ȭ
	
	try {
	    doc = Jsoup.connect(crawlingUrl).get();  // Jsoup�� ����Ͽ� URL�� �����ϰ� HTML ������ ������
	} catch (Exception e) {
	    e.printStackTrace();  // ���� �� ���ܰ� �߻��� ��� ���� ������ ���
	}
	
	// HTML �������� "div.sect-movie-chart" Ŭ������ ���� ��ҵ��� �����Ͽ� Elements ��ü�� ����
	Elements elements = doc.select("div.sect-movie-chart");
	Iterator<Element> title = elements.select("strong.title").iterator(); // ��ȭ����
	Iterator<Element> movieDetailLink = elements.select("div.box-image > a").iterator(); // ��ȭ�� ��ũ
	
	// Iterator�� ����Ͽ� ������ ������ �ݺ������� ���
	while (title.hasNext()) {
	    Element titleElement = title.next();
	    Element movieDetailLinkElement = movieDetailLink.next();
	
	    String titleText = titleElement.text();
	    String detailLink = rootUrl + movieDetailLinkElement.attr("href");
	
	    System.out.println("��ȭ�̸�: " + titleText + "\n��ȭ�󼼸�ũ:" + detailLink);
	    System.out.println("------------------------------");
	
	    MovieDto movieInfo = new MovieDto();
	    movieInfo.setMovieTitle(titleText);
	    movieInfo.setMovieDetailLink(detailLink);
	    
	    MovieDao dao = new MovieDao();
	    dao.insertTitleAndLink(titleText, detailLink);
	    
	    
	}
	System.out.println("========================================================\n");
	
	
	response.sendRedirect("reservationForm.jsp");
	
%>
