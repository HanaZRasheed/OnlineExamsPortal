package dbConnect;

public class User {
private  String userId;
private  String roleId;
private String userName;
private String examId;
private String examName;

public User() {
	this.userId="";
	this.roleId="";
	this.userName="";
	this.examId="";
	this.examName="";
}


public void setUserID(String userId)
{
	this.userId=userId;
}

public void setExamID(String examId)
{
	this.examId=examId;
}

public String getExamID()
{
	return examId;
}


public void setRoleID(String roleId)
{
	this.roleId= roleId;
}

public void setUserName(String userName)
{
	this.userName=userName;
}

public void setExamName(String examName)
{
	this.examName=examName;
}

public String getUserID()
{
	return userId;
}

public String getRoleID()
{
	return roleId;
}

public String getUserName()
{
	return userName;
}

public String getExamName()
{
	return examName;
}
}
