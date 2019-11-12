<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
com.nibss.asvportal.UtilityClass util = new com.nibss.asvportal.UtilityClass();

String action = request.getParameter("action");
if(action==null) action="";

String ipAddress = request.getRemoteAddr();

String sql="", sql2="";
ArrayList resultConStmt = new ArrayList();
Connection con=null;
Statement stmt=null;
PreparedStatement ps = null;
ResultSet rs = null;



if(action.equals("0")){ //user login
	String EMAIL = request.getParameter("EMAIL");if(EMAIL == null) EMAIL = "";
	String PASSWORD = request.getParameter("PASSWORD");if(PASSWORD == null) PASSWORD = "";
	String USER_ID="", ROLE="";
	int pass_change=0;
			
	try{
		resultConStmt =  util.userProfileExist(EMAIL,PASSWORD,ipAddress);
		con= (Connection)resultConStmt.get(1);
		ps= (PreparedStatement)resultConStmt.get(2);
		rs= (ResultSet)resultConStmt.get(0);
		if(rs.next()){
			USER_ID = rs.getString("USER_ID");
			ROLE = rs.getString("ROLE");
			pass_change = rs.getInt("CHANGE_PASSWORD");
			session.setAttribute("USER_ID",USER_ID);
			session.setAttribute("EMAIL",EMAIL);
			session.setAttribute("ROLE",ROLE);
			System.out.println("USER LOGGING IN:::"+EMAIL);
			System.out.println("ROLE:::"+ROLE);
			
			if(pass_change == 0)
				out.print("3");
			else 
				out.print("0");
			util.logAuditTrail("5", "ASV_USER_PROFILE", USER_ID, USER_ID, ipAddress);
		}else{
			out.print("1");
			System.out.print("1----User does not exist:::"+USER_ID);
		}
	}catch(Exception e){
		out.print("2");
		System.out.print("2----Error occurred in processRequest:::"+e.toString());
	}finally{
		try{
			if (rs != null) rs.close();
			if (ps != null)ps.close();
			if (con != null) con.close();
		}catch(Exception e){}
	}

}
else if (action.equals("1")){ //PASSWORD CHANGE	
	String OLD_PASSWORD = request.getParameter("OLD_PASSWORD");if(OLD_PASSWORD==null)OLD_PASSWORD="";
	String NEW_PASSWORD = request.getParameter("NEW_PASSWORD");if(NEW_PASSWORD==null)NEW_PASSWORD="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	
	try{
		String passComplexity = util.passwordComplexity(NEW_PASSWORD);
		if(passComplexity.equals("3")){
			resultConStmt =  util.userProfileExist(USER_ID,OLD_PASSWORD);
			con= (Connection)resultConStmt.get(1);
			ps= (PreparedStatement)resultConStmt.get(2);
			rs= (ResultSet)resultConStmt.get(0);
			if(rs.next()){
				int pass_change = util.changeUserPassword(USER_ID,NEW_PASSWORD,ipAddress);
				if (pass_change > 0){
					out.print("0");
					System.out.print("Password Change Successful:::"+USER_ID);
				}else{
					out.print("1");
					System.out.print("Password Change Not Successful:::"+USER_ID);
				}
			}else{
				out.print("2");
				System.out.print("2----Old Password does not exist:::"+USER_ID);
			}
		
		}else if(passComplexity.equals("4")){
			out.print("4"); //"Password Complexity Not Okay!!!"
		}else if(passComplexity.equals("5")){
			out.print("5"); //The password is lesser than required
		}
	}catch(Exception e){
		out.print("1");
		System.out.print("1----Error occurred in processRequest:::"+e.toString());
	}finally{
		try{
			if (rs != null) rs.close();
			if (ps != null)ps.close();
			if (con != null) con.close();
		}catch(Exception e){}
	}
}
else if(action.equals("2")){ //Create User Type

	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	
	System.out.println("USER_TYPE_NAME::"+USER_TYPE_NAME);
	System.out.println("USER_ID::"+USER_ID);
	
	
	String strResponse="";
	try{
		strResponse = util.insertUserType(USER_TYPE_NAME,USER_ID, ipAddress);
		if (strResponse.equals("0")){
			out.print("0");		
		}else if (strResponse.equals("1")){
			out.print("1");
		}else if (strResponse.equals("2")){
			out.print("2");
		}
	}catch(Exception e){
		System.out.print("Error occurred when processing user type");	
		e.printStackTrace();
	}

}else if (action.equals("3")){ //CREATE USER
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	String FIRST_NAME = request.getParameter("FIRST_NAME"); if(FIRST_NAME == null)FIRST_NAME="";
	String LAST_NAME = request.getParameter("LAST_NAME"); if(LAST_NAME == null)LAST_NAME="";
	String EMAIL = request.getParameter("EMAIL"); if(EMAIL == null)EMAIL="";
	//String PASSWORD = request.getParameter("PASSWORD"); if(PASSWORD == null)PASSWORD="";
	String GENDER = request.getParameter("GENDER"); if(GENDER == null)GENDER="";
	String COMPANY_NAME = request.getParameter("COMPANY_NAME"); if(COMPANY_NAME == null)COMPANY_NAME="";
	String COMPANY_ADDRESS = request.getParameter("COMPANY_ADDRESS"); if(COMPANY_ADDRESS == null)COMPANY_ADDRESS="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String PHONE_NUM = request.getParameter("PHONE_NUM"); if(PHONE_NUM==null)PHONE_NUM="";
	/*
	String passComplexity = util.passwordComplexity(PASSWORD);
	
	if(passComplexity.equals("3")){
		String result =  util.insertUserProfile(USER_ID, FIRST_NAME, LAST_NAME, EMAIL,PASSWORD,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
		
		if(result.equals("0")){
			out.print("0");
			System.out.print("0----User successfully created");
		}else if(result.equals("1")){
			out.print("1");
			System.out.print("0----User already exist");
		}else if(result.equals("2")){
			out.print("2");
			System.out.print("2----Error occurred while creating user");
		}
	}else if(passComplexity.equals("4")){
		out.print("4"); //"Password Complexity Not Okay!!!"
	}else if(passComplexity.equals("5")){
		out.print("5"); //The password is lesser than required
	}*/
	
	String result =  util.insertUserProfile(USER_ID, FIRST_NAME, LAST_NAME, EMAIL,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
	
	if(result.equals("0")){
		out.print("0");
		System.out.print("0----User successfully created");
	}else if(result.equals("1")){
		out.print("1");
		System.out.print("0----User already exist");
	}else if(result.equals("2")){
		out.print("2");
		System.out.print("2----Error occurred while creating user");
	}
	
}

else if (action.equals("3a")){ //NIBSS CREATE USER
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	String FIRST_NAME = request.getParameter("FIRST_NAME"); if(FIRST_NAME == null)FIRST_NAME="";
	String LAST_NAME = request.getParameter("LAST_NAME"); if(LAST_NAME == null)LAST_NAME="";
	String EMAIL = request.getParameter("EMAIL"); if(EMAIL == null)EMAIL="";
	//String PASSWORD = request.getParameter("PASSWORD"); if(PASSWORD == null)PASSWORD="";
	String GENDER = request.getParameter("GENDER"); if(GENDER == null)GENDER="";
	String COMPANY_NAME = request.getParameter("COMPANY_NAME"); if(COMPANY_NAME == null)COMPANY_NAME="";
	String COMPANY_ADDRESS = request.getParameter("COMPANY_ADDRESS"); if(COMPANY_ADDRESS == null)COMPANY_ADDRESS="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String PHONE_NUM = request.getParameter("PHONE_NUM"); if(PHONE_NUM==null)PHONE_NUM="";
	
	
	String result =  util.insertUserProfileNIBSS(USER_ID, FIRST_NAME, LAST_NAME, EMAIL,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
	
	if(result.equals("0")){
		out.print("0");
		System.out.print("0----User successfully created");
	}else if(result.equals("1")){
		out.print("1");
		System.out.print("0----User already exist");
	}else if(result.equals("2")){
		out.print("2");
		System.out.print("2----Error occurred while creating user");
	}
	
}

else if (action.equals("3b")){ //NIBSS EDIT USER
	String ITEM_ID = request.getParameter("ITEM_ID"); if(ITEM_ID == null)ITEM_ID="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	String FIRST_NAME = request.getParameter("FIRST_NAME"); if(FIRST_NAME == null)FIRST_NAME="";
	String LAST_NAME = request.getParameter("LAST_NAME"); if(LAST_NAME == null)LAST_NAME="";
	String EMAIL = request.getParameter("EMAIL"); if(EMAIL == null)EMAIL="";
	//String PASSWORD = request.getParameter("PASSWORD"); if(PASSWORD == null)PASSWORD="";
	String GENDER = request.getParameter("GENDER"); if(GENDER == null)GENDER="";
	String COMPANY_NAME = request.getParameter("COMPANY_NAME"); if(COMPANY_NAME == null)COMPANY_NAME="";
	String COMPANY_ADDRESS = request.getParameter("COMPANY_ADDRESS"); if(COMPANY_ADDRESS == null)COMPANY_ADDRESS="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String PHONE_NUM = request.getParameter("PHONE_NUM"); if(PHONE_NUM==null)PHONE_NUM="";
	
	
	String result =  util.editUserProfileNIBSS(ITEM_ID,USER_ID, FIRST_NAME, LAST_NAME, EMAIL,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
	
	if(result.equals("0")){
		out.print("0");
		System.out.print("0----User successfully created");
	}else if(result.equals("1")){
		out.print("1");
		System.out.print("0----User already exist");
	}else if(result.equals("2")){
		out.print("2");
		System.out.print("2----Error occurred while creating user");
	}
	
}
else if (action.equals("3c")){ //EDIT USER
	String ITEM_ID = request.getParameter("ITEM_ID"); if(ITEM_ID == null)ITEM_ID="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	String FIRST_NAME = request.getParameter("FIRST_NAME"); if(FIRST_NAME == null)FIRST_NAME="";
	String LAST_NAME = request.getParameter("LAST_NAME"); if(LAST_NAME == null)LAST_NAME="";
	String EMAIL = request.getParameter("EMAIL"); if(EMAIL == null)EMAIL="";
	//String PASSWORD = request.getParameter("PASSWORD"); if(PASSWORD == null)PASSWORD="";
	String GENDER = request.getParameter("GENDER"); if(GENDER == null)GENDER="";
	String COMPANY_NAME = request.getParameter("COMPANY_NAME"); if(COMPANY_NAME == null)COMPANY_NAME="";
	String COMPANY_ADDRESS = request.getParameter("COMPANY_ADDRESS"); if(COMPANY_ADDRESS == null)COMPANY_ADDRESS="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String PHONE_NUM = request.getParameter("PHONE_NUM"); if(PHONE_NUM==null)PHONE_NUM="";
	/*
	String passComplexity = util.passwordComplexity(PASSWORD);
	
	if(passComplexity.equals("3")){
		String result =  util.insertUserProfile(USER_ID, FIRST_NAME, LAST_NAME, EMAIL,PASSWORD,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
		
		if(result.equals("0")){
			out.print("0");
			System.out.print("0----User successfully created");
		}else if(result.equals("1")){
			out.print("1");
			System.out.print("0----User already exist");
		}else if(result.equals("2")){
			out.print("2");
			System.out.print("2----Error occurred while creating user");
		}
	}else if(passComplexity.equals("4")){
		out.print("4"); //"Password Complexity Not Okay!!!"
	}else if(passComplexity.equals("5")){
		out.print("5"); //The password is lesser than required
	}*/
	
	String result =  util.editUserProfile(ITEM_ID,USER_ID, FIRST_NAME, LAST_NAME, EMAIL,GENDER,COMPANY_NAME, COMPANY_ADDRESS, USER_TYPE_NAME,PHONE_NUM,ipAddress);
	
	if(result.equals("0")){
		out.print("0");
		System.out.print("0----User successfully created");
	}else if(result.equals("1")){
		out.print("1");
		System.out.print("0----User already exist");
	}else if(result.equals("2")){
		out.print("2");
		System.out.print("2----Error occurred while creating user");
	}
	
}

else if(action.equals("4")){ 

	String MAIN_MENU_NAME = request.getParameter("MAIN_MENU_NAME"); if(MAIN_MENU_NAME==null)MAIN_MENU_NAME="";
	String MAIN_MENU_URL = request.getParameter("MAIN_MENU_URL"); if(MAIN_MENU_URL == null)MAIN_MENU_URL="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	
	System.out.println("USER_TYPE_NAME::"+USER_TYPE_NAME);
	System.out.println("USER_ID::"+USER_ID);
		
	String strResponse="";
	try{
		strResponse = util.insertMainMenu(MAIN_MENU_NAME,MAIN_MENU_URL,USER_TYPE_NAME,USER_ID,ipAddress);
		if (strResponse.equals("0")){
			out.print("0");		
		}else if (strResponse.equals("1")){
			out.print("1");
		}else if (strResponse.equals("2")){
			out.print("2");
		}
	}catch(Exception e){
		System.out.print("Error occurred when processing user Bio Data");	
		e.printStackTrace();
	}

}
else if(action.equals("5")){ 
	String MAIN_MENU_NAME = request.getParameter("MAIN_MENU_NAME"); if(MAIN_MENU_NAME==null)MAIN_MENU_NAME="";
	String SUB_MENU_NAME = request.getParameter("SUB_MENU_NAME"); if(SUB_MENU_NAME == null)SUB_MENU_NAME="";
	String SUB_MENU_URL = request.getParameter("SUB_MENU_URL"); if(SUB_MENU_URL == null)SUB_MENU_URL="";
	String USER_TYPE_NAME = request.getParameter("USER_TYPE_NAME"); if(USER_TYPE_NAME==null)USER_TYPE_NAME="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	
	System.out.println("MAIN_MENU_NAME::"+MAIN_MENU_NAME);
	System.out.println("SUB_MENU_NAME::"+SUB_MENU_NAME);
	System.out.println("SUB_MENU_URL::"+SUB_MENU_URL);
	System.out.println("USER_TYPE_NAME::"+USER_TYPE_NAME);
	System.out.println("USER_ID::"+USER_ID);
	
	String strResponse="";
	try{
		strResponse = util.insertSubMenu(MAIN_MENU_NAME,SUB_MENU_NAME,SUB_MENU_URL,USER_TYPE_NAME,USER_ID,ipAddress);
		if (strResponse.equals("0")){
			out.print("0");		
		}else if (strResponse.equals("1")){
			out.print("1");
		}else if (strResponse.equals("2")){
			out.print("2");
		}
	}catch(Exception e){
		System.out.print("Error occurred when processing user Bio Data");	
		e.printStackTrace();
	}
}else if (action.equals("6")){ //SEND EMAIL
	System.out.println("Inside Process Requests for Message");
	System.out.println("************Message Params**********************");
	
	String SUBJECT = request.getParameter("SUBJECT");if(SUBJECT==null)SUBJECT="";
	String MESSAGE = request.getParameter("MESSAGE");if(MESSAGE==null)MESSAGE="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";

	System.out.println("SUBJECT:::"+SUBJECT);
	System.out.println("MESSAGE:::"+MESSAGE);
	System.out.println("USER_ID:::"+USER_ID);

	boolean result =  util.sendNIBSSEmail(SUBJECT,MESSAGE,USER_ID, request);
	
	if(result){
		out.print("0");
		System.out.print("0----Email sent successfully");
	}else{
		out.print("1");
		System.out.print("1----Email was not sent successfully");
	}
}else if (action.equals("7")){ //Manage Signatory
	System.out.println("Inside Process Requests for Message");
	System.out.println("************Message Params for Manage Signatory**********************");
	
	String ACTION = request.getParameter("ACTION");if(ACTION==null)ACTION="";
	String REASON = request.getParameter("REASON");if(REASON==null)REASON="";
	String USER_ID = request.getParameter("USER_ID"); if(USER_ID == null)USER_ID="";
	String SIGNATURE_ID = request.getParameter("SIGNATURE_ID"); if(SIGNATURE_ID == null)SIGNATURE_ID="";

	System.out.println("ACTION:::"+ACTION);
	System.out.println("REASON:::"+REASON);
	System.out.println("USER_ID:::"+USER_ID);
	System.out.println("SIGNATURE_ID:::"+SIGNATURE_ID);
	
	String strResponse="";
	try{
		strResponse =  util.insertManageSignatory(SIGNATURE_ID,ACTION,REASON,USER_ID, request);
		
		if (strResponse.equals("0")){
			out.print("0");		
		}else if (strResponse.equals("1")){
			out.print("1");
		}else if (strResponse.equals("2")){
			out.print("2");
		}else if (strResponse.equals("3")){
			out.print("3");
		}
	}catch(Exception e){
		System.out.print("Error occurred when inserting manage Signatory");	
		e.printStackTrace();
	}
}
%>