<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Member</title>
</head>
<body>
<%@ include file="userHome.jsp" %>
	<%
	if ("POST".equalsIgnoreCase(request.getMethod()))
	{
		String uname=request.getParameter("username");
		String pwd=request.getParameter("password");
		String name=request.getParameter("uname");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		String mobileNo= request.getParameter("mob");
		char gender= request.getParameter("gender").charAt(0);
		java.util.Date  date= Date.valueOf(request.getParameter("dob"));
		
		java.sql.Date d1=new java.sql.Date(date.getTime());
				
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryManagement", "root", "root");
			
			PreparedStatement stmt=con.prepareStatement("select * from user where user_name=?");
			stmt.setString(1,uname);
			ResultSet rs=stmt.executeQuery();
			
			if(rs.next())
			{
				out.println("User name already exist, user can't create it");
			}
			else
			{
				PreparedStatement stmt1=con.prepareStatement("insert into user (user_name, password, user_type) values(?,?,0)");
				stmt1.setString(1,uname);
				stmt1.setString(2,pwd);
				stmt1.executeUpdate();
				
				rs=stmt.executeQuery();
				
				if(rs.next())
				{
					int uid=rs.getInt("user_id");
					PreparedStatement stmt2=con.prepareStatement("insert into userdetails values (?,?,?,?,?,?,?)");
					
					stmt2.setInt(1,uid);
					stmt2.setString(2,name);
					stmt2.setString(3,address);
					stmt2.setString(4,email);
					stmt2.setString(5,mobileNo);
					stmt2.setString(6,String.valueOf(gender));
					stmt2.setDate(7,d1);
					
					stmt2.executeUpdate();
					out.println("Member is added");
					
				}
							
			}

		}
		catch(Exception e)
		{
			out.println(e.toString());
		}
	}

	else
	{
		%>
		<!-- <form action="addmember.jsp" method="post" name="form2" >
		
		<label>User Name :</label>
		<input type="text" name="username" required/><br><br>
		
		<label>Password</label>
		<input type="password" name="password"required/><br><br>
		
		<label>Name :</label>
		<input type="text" name="uname"required/><br><br>
		
		<label>Address :</label>
		<textArea rows="5" cols="20" name="address"></textArea><br><br>
		
		<label>Email :</label>
		<input type="email" name="email"required/><br><br>
		
		<label>Mobile Number :</label>
		<input type="number" name="mob"required/><br><br>
		
		<label>Gender :</label>
		<input type="radio" name="gender" value="m"/>Male<br><br>
		<input type="radio" name="gender" value="f"/>Female<br><br>
		<input type="radio" name="gender" value="o"/>Others<br>
		<br><br>
		
		<label>DOB :</label>
		<input type="date" name="dob"/><br><br>
		
		<input type="submit" value="Submit"/>
		<input type="reset" value="Cancel"/>
		
		</form> -->
		
				<div class="container" style="width:600px;margin:auto; background: #fff; padding: 30px;">
			    <div class="text-center">
			    <img src="img/logo.png" style="width: 100px;" />
			    </div>
				<form name="form1" action="addmember.jsp" method="post" onSubmit="return validateForm()">
			  	 
			  	<div class="mb-3">
			    <label class="form-label">User Name</label>
			    <input type="text" class="form-control" name="username" required />
			 	</div>
			  	<div class="mb-3">
			    <label  class="form-label">Password</label>
			   	<input type="password" class="form-control" name="password" required />
			  	</div>
			  	<div class="mb-3">
			    <label  class="form-label">Name</label>
			   	<input type="text" class="form-control" name="uname" required />
			  	</div>  	
			  
				<div class="mb-3">
			    <label  class="form-label">Address</label>
			    <input type="text" class="form-control" name="address" required />
			 	</div>
			 	
			  	<div class="mb-3">
			    <label  class="form-label">Email</label>
			   	<input type="email" class="form-control" name="email" required />
			  	</div>
			  	
			  	<div class="mb-3">
			    <label  class="form-label">Mobile Number</label>
			   	<input type="number" class="form-control" name="mob" required />
			  	</div>  
			  	
			  	<div class="form-check">
  				<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
 				<label class="form-check-label" for="flexRadioDefault1">
  			  	Female
  				</label>
				</div>
				
				<div class="form-check">
  				<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
 				<label class="form-check-label" for="flexRadioDefault2">
   				Male
 				</label>
				</div>
				
				<div class="form-check">
  				<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
 				<label class="form-check-label" for="flexRadioDefault2">
   				Other
 				</label>
				</div>
				
				
				 	<div class="mb-3">
			    <label  class="form-label">DOB</label>
			   	<input type="date" class="form-control" name="dob" required />
			  	</div>
			  	
			  	
			  	
			  	<input type="submit" value="Submit" class="btn btn-primary" /> <input type="reset" class="btn btn-primary"	value="Cancel" />	
			  	</form>
				</div> 
		
		<%
	}
%>


</body>
</html>