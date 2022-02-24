<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Disable Member</title>
</head>
<body>
<%@ include file="userHome.jsp" %>
	
	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryManagement", "root", "root");

			PreparedStatement stmt = con.prepareStatement("update user set status = ? where user_name=?");
			
			String uname= request.getParameter("uname");
			String option = request.getParameter("s1");
			
			if(option.equals("d")){
				stmt.setInt(1, 0);
			}
			else{
				stmt.setInt(1, 1);
			}
			stmt.setString(2, uname);
			stmt.executeUpdate();
			out.println("User Status Changed..");
			
		}
		catch(Exception e)
		{
			out.println(e.toString());
		}
		
	}
	else{
		%>
		<!-- <form action="dismember.jsp" method="post">
		
		<label>User Name: </label><input type="text" name="uname"/><br><br>
		<label>Option : </label>
			<select name="s1">
				<option value="d">Disable</option>
			
				<option value="a">Enable</option>	
			</select><br><br>
			
			<input type="submit" value="SUBMIT"/><br><br>
			<input type="reset" value="Cancel"/>
		
		</form> -->
		
		<div class="container" style="width:600px;margin:auto; background: #fff; padding: 30px;">
			    <div class="text-center">
			    <img src="img/logo.png" style="width: 100px;" />
			    </div>
				<form name="form1" action="dismember.jsp" method="post" onSubmit="return validateForm()">
			  	 
			  	<div class="mb-3">
			    <label class="form-label">User Name</label>
			    <input type="text" class="form-control" name="uname" required />
			 	</div>
			  	
			  	<div class="mb-3">
			    <label class="form-label">Select</label>
			  	<select class="form-select" aria-label="Default select example">
				<option selected>Select</option>
				<option value="1">Disable</option>
				<option value="2">Enable</option>
				</select>
				</div>
			  	
			  	
			  	<input type="submit" value="Submit" class="btn btn-primary" /> <input type="reset" class="btn btn-primary"	value="Cancel" />	
			  	</form>
				</div> 
		
		
		<%
	}
%>

</body>
</html>