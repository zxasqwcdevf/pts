<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="scheduler.*" %>

<jsp:useBean id="SchedulerDAO" class="scheduler.SchedulerDAO"/>
<%@ page import="users.*" %>
<jsp:useBean id="UsersDAO" class="users.UsersDAO"/>
<%@ page import="image.*" %>
<jsp:useBean id="ImageDAO" class="image.ImageDAO"/>
<%@ page import="notice.*" %>
<jsp:useBean id="NoticeDAO" class="notice.NoticeDAO"/>
<%
request.setCharacterEncoding("UTF-8");
%>   

<%
String uid = (String)session.getAttribute("uid");
String wpname = (String)session.getAttribute("wpname");
String wpid = (String)session.getAttribute("wpid");
if(uid == null || uid.equals("") || wpname == null || wpname.equals("")) response.sendRedirect("./login.jsp");
%>

<%	
	int total = NoticeDAO.count();
	ArrayList<NoticeDTO> noticeList = NoticeDAO.getNoticeMemberList();
	int size = noticeList.size();
	int size2 = size;
	
	final int ROWSIZE = 10;
	final int BLOCK = 5;
	int indent = 0;
	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;
	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	
	if(endPage > allPage) {
		endPage = allPage;
	}
	
	size2 -= end;
	if(size2 < 0) {
		end = size;
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap core CSS -->
<link href="./css/bootstrap.min.css" rel="stylesheet">
    
<!-- Custom CSS -->
<link href="./css/pts.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<title>PTS - Part time Scheduler</title>
</head>
<body>
<nav class="navbar navbar-inverse bg-ombra" id="navbar-custom">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.jsp" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<p class="navbar-text" style="color: #ffffff;"><%=uid %>님</p>
      	<li><a href="./controller.jsp?action=userinfo" style="color: #ffffff;"><span class="glyphicon glyphicon-user"></span> 내정보</a></li>
        <li><a href="./controller.jsp?action=logout" style="color: #ffffff;"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
		<div class="col-sm-2 sidenav bg-snow" style="height: 100%; min-height: 100rem;">
			<%
			String fileName = ImageDAO.GetFileName("wpid", wpid);
			String filePath = "./img/"+"\\"+fileName;
			%>
			<span>
				<img class="img-circle" src="<%=filePath %>" style="width:70%;">
			</span>
			<h3><%=wpname %></h3><br>
			<p>근무지 코드 : <%=wpid %></p>
			<hr style="border: 1px solid rgb(232, 213, 41)"><br>
			<p><a class="nav-item " href="./timetable.jsp">근무 시간표</a></p>
			<p><a class="nav-item " href="./notice.jsp">공지사항</a></p>
			<p><a class="nav-item " href="./apply.jsp">근무 신청</a></p>
			<p><a class="nav-item " href="./pay.jsp">급여 관리</a></p>
		</div>
		<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
	    <!-- 컨텐츠 -->
		<h1>공지사항</h1>
		<hr>
		<br>
		<div class="panel panel-default" style="padding: 3rem 2rem;">
		<table id="tbNotice" class="table table-striped text-center">
			<tr>
				<th style="width: 10%">번호</th>
				<th style="width: 45%">제목</th>
				<th style="width: 20%">작성자</th>
				<th style="width: 15%">작성일</th>
				<th style="width: 15%">조회</th>
			</tr> 
			<%
			if(total==0) {
				%>
				<tr>
				<td colspan="5" style="padding: 30px 0;">등록된 글이 없습니다.</td>
				</tr>
				<%
			} else {
				for(int i=ROWSIZE*(pg-1); i<end; i++){
					NoticeDTO dto = noticeList.get(i);
					int idx = dto.getNid();
			%>
					<tr class="blist" >
						<td><%=idx%></td>
						<td style="text-align: left;">
							&nbsp;&nbsp;&nbsp;&nbsp;<a href="notice_view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=dto.getNtitle()%></a>
						</td>
						<td><%=dto.getUid()%></td>
						<td><%=dto.getNdate()%></td>
						<td><%=dto.getNhit()%></td>
					</tr><%
				}
			} 
			%>
		</table>
		</div>
		<div class="panel panel-default text-center">
			<div class="panel-heading">
					<%
						if(pg>BLOCK) {
					%>
						[<a href="notice.jsp?pg=1">◀◀</a>]
						[<a href="notice.jsp?pg=<%=startPage-1%>">◀</a>]
					<%
						}
					%>
					
					<%
						for(int i=startPage; i<= endPage; i++){
							if(i==pg){
					%>
								<u><b>[<%=i %>]</b></u>
					<%
							}else{
					%>
								[<a href="notice.jsp?pg=<%=i %>"><%=i %></a>]
					<%
							}
						}
					%>
					
					<%
						if(endPage<allPage){
					%>
						[<a href="notice.jsp?pg=<%=endPage+1%>">▶</a>]
						[<a href="notice.jsp?pg=<%=allPage%>">▶▶</a>]
					<%}
					%>
			</div>
			<div class="panel-body">
				<button type="button" class="btn btn-info bg-ombra" onclick="window.location='notice_write.jsp'" style="border: 0;">
					글쓰기
				</button>
			</div>
		</div>
		
	</div>
</div>
</div>

<footer class="container-fluid text-center bg-slagheap">
  <p>경기도 용인시 처인구 용인대학로 134 우.17092 TEL: 031-332-6471~6 FAX: 031-337-6749<br>
	Copyrightⓒ Department of Management Information Systems, YongInUniversity All Rights Reserved.</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./js/bootstrap.min.js"></script>

</body>
</html>