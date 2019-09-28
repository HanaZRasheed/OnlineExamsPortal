package dbConnect;

public class Answers {
	private int answerId;
	private String answerText;
	private int isCorrect;
	private boolean checked;
	
public Answers(int answerId,String answerText, int isCorrect )
{
	this.answerId=answerId;
	this.answerText=answerText;
	this.isCorrect=isCorrect;
}

public Answers( )
{

}

public boolean getChecked()
{
return checked;
}

public void setChecked(boolean checked)
{
	this.checked = checked;
}

public int getAID()
{
return answerId;
}

public void setAID(int answerId)
{
	this.answerId=answerId;
}

public String getAnswerText()
{
return answerText;
}

public void setAnswerText(String answerText)
{
	this.answerText=answerText;
}

public int getIsCorrect()
{
return isCorrect;
}

public void setIsCorrect(int isCorrect)
{
	this.isCorrect=isCorrect;
}

public String toString()
{
	return  ("AnswerID:"+this.getAID()+
            " Answer Text: "+ this.getAnswerText() +
            " IsCorrect: "+ this.getIsCorrect()) ;
         
	
}

}
