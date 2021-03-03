<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	var loca_cd = `${info[0].loca_cd }`;
	var loca_nm = `${info[0].loca_nm }`;
	var loca_sort = `${info[0].loca_sort }`;
	var use_yn = `${info[0].use_yn }`;
	
</script>
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="<%=request.getContextPath()%>/update_ok_loca.do">
	
		<table class="table table-striped">
	       <tbody>
	       		<tr>
					<th align="right"> 위치 코드 :&emsp;</th>
					<td><input type="text" name="loca_cd" width="500px" value="${info[0].loca_cd }" readonly/> </td>
				</tr>
				<tr>
					<th align="right"> 위치명 :&emsp;</th>
					<td><input type="text" name="loca_nm" width="500px" value="${info[0].loca_nm }"/> </td>
				</tr>
				<tr>
					<th align="right"> 정렬 순서 :&emsp;</th>
					<td><input type="text" name="loca_sort" width="500px" value="${info[0].loca_sort }"/> </td>
				</tr>
				<tr>
					<th align="right"> 사용여부 :&emsp;</th>
					<td><input type="text" name="use_yn" width="500px" value="${info[0].use_yn }"/> </td>
				</tr>
			
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정하기" /> &nbsp;&nbsp;
						<input type="reset" value="다시작성" /> &nbsp;&nbsp;
					</td>
				</tr>
	
			</tbody>
		</table>
	</form>
</body>
</html>