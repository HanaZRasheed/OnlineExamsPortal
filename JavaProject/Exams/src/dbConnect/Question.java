package dbConnect;

import java.util.*;

public class Question {
	private int qid;
	private String qtext;
	private boolean Result;
	private List<Answers> answers = new ArrayList<Answers>();
	
	public Question() {}
	public Question(int qid,String qText,List<Answers> answers, boolean Result ) {
		this.qid=qid;
		this.qtext=qText;
		this.answers=answers;
		this.Result=Result;
		
			}

	public void SetAnswers(List<Answers> answers)
	{
		 this.answers=answers;
	}
	
	public   List<Answers> getAnswers()
	{
		return answers;
	}
	
	
	public void setID(int qid)
	{
		this.qid=qid;
	}
	
	public int getID( )
	{
		return qid;
	}
	
	public void setText(String text)
	{
		this.qtext=text;
	}
	public String getText()
	{
		return qtext;
	}

	
	public String toString()
	{
		return  ("QuestionID:"+this.getID()+
	            " Question Text: "+ this.getText() +
	            " AnswerList: "+ this.getAnswers())+"\n" ;
	         
		
	}
	public boolean isResult() {
		return Result;
	}
	public void setResult(boolean result) {
		Result = result;
	}

	
	
	
	
}
