<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

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

<script>
		function wpcheck(){
			var f = document.WpJoinForm;
			if(!f.wpname.value){
				alert("상호명을 입력하세요.");
				return;
			}
			if(!f.wpnum1.value || !f.wpnum2.value || !f.wpnum2.value){
				alert("사업자번호를 입력하세요.");
				return;
			}
			if(!f.wpimg.value){
				alert("이미지를 등록해주세요.");
				return;
			}
			f.submit();
		}
</script>

</head>
<body>
<nav class="navbar navbar-inverse bg-ombra" id="navbar-custom">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#" style="color: #ffffff; font-size: 3rem">PTS</a>
    </div>
  </div>
</nav>
<%
String step = request.getParameter("step");
String ulevel = request.getParameter("level");
%>
<div class="container-fluid text-center">    
<div class="row content">
	<div class="col-sm-2 sidenav bg-snow" style="height: 100%; min-height: 100rem;">
	<!-- left side bar -->
	</div>
	<div class="col-sm-10 text-left" style="height: 100%; min-height: 100rem;">
	<!-- right contents -->
	<h1>회원가입</h1>
	<hr>
	
	<%
	if(step == null || step.equals("") || step.equals("1"))
	{
		//가입 유형 선택
		%>
		<p> 환영합니다! <br>
		가입 유형을 선택해주세요.</p>
		<button type="button" class="btn btn-default" onclick="location.href('join.jsp?level=1&step=2');">관리자</button>
		<button type="button" class="btn btn-default" onclick="location.href('join.jsp?level=2&step=2');">일반직원</button>
		<%
	}
	else if(step.equals("2") && ulevel.equals("1"))
	{
		//근무지 정보 입력
		%>
		<p>근무지 정보를 입력해주세요. </p>
		<form name="WpJoinForm" action="/controller.jsp" method="post" enctype="multipart/form-data>
			<div class="form-group">
				<label for="wpname">상호명</label>
				<input name="wpname" id="wpname" type="text" class="form-control">
			</div>
			<div class="form-group">
				<label for="wpnum1">사업자번호</label>
				<input name="wpnum1" id="wpnum1" type="number" maxlength="3" class="form-control">-
				<input name="wpnum2" id="wpnum2" type="number" maxlength="2" class="form-control">-
				<input name="wpnum3" id="wpnum3" type="number" maxlength="5" class="form-control">
			</div>
			<div class="form-group">
				<label for="wpimg">메인 이미지</label>
				<input name="wpimg" id="wpimg" type="file" class="form-control">
			</div>
			<input type="hidden" name="action" value="wpjoin"/>
			<button type="button" class="btn btn-default" onclick="wpcheck();">확인</button>
		</form>
		<%
	}
	else if(step.equals("2"))
	{
		if(ulevel.equals("1"))
			ulevel = "관리자";
		else
			ulevel = "직원";
		//유저 정보 입력
		%>
		<form name="UserJoinForm" action="/controller.jsp" method="post">
			<div class="form-group">
				<label for="ulevel">가입 유형</label>
				<input name="ulevel" id="ulevel" type="text" class="form-control" value="<%=ulevel%>" disabled>
			</div>
			<div class="form-group">
				<label for="uid">아이디</label>
				<input name="uid" id="uid" type="text" class="form-control">
			</div>
			<div class="form-group">
				<label for="upw">비밀번호</label>
				<input name="upw" id="upw" type="password" class="form-control">
			</div>
			<div class="form-group">
				<label for="ubirth">생년월일</label>
				<input name="ubirth" id="ubirth" type="date" class="form-control">
			</div>
			<div class="form-group">
				<label for="uphone">전화번호</label>
				<input name="uphone" id="uphone" type="text" class="form-control">
			</div>
			<div class="form-group">
				<label for="uaddr">주소</label>
				<input name="uaddr" id="uaddr" type="text" class="form-control">
			</div>
			<div class="form-group">
				<label for="wpid">근무지 id</label>
				<input name="wpid" id="wpid" type="number" class="form-control">
			</div>
			<input type="hidden" name="action" value="userjoin"/>
			<button type="submit" class="btn btn-default">Submit</button>
		</form>
		<%
	}
	%>
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