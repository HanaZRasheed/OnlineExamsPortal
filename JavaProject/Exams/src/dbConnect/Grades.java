package dbConnect;

public class Grades {
	private int studentId;
	private String studentName;
	private double grade;
	
	public Grades() {
		this.studentId=0;
		this.studentName=null;
		this.grade=0;
	}
	
	public Grades(int studentId, String studentName, double grade) {
		this.studentId = studentId;
		this.studentName = studentName;
		this.grade = grade;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "Grades [getStudentId()=" + getStudentId() + ", getStudentName()=" + getStudentName() + ", getGrade()="
				+ getGrade() + "]";
	}

	
	

	

}
