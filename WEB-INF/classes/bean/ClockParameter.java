package bean;

import java.io.*;
import java.util.ArrayList; 

public class ClockParameter {
	private String parameterName;
	private int isEnabled;
	
	public ClockParameter(String name, int enabled)
	{
		this.parameterName = name;
		this.isEnabled = enabled;
	};
	
	public void setParameterName(String name)
	{
		this.parameterName = name;
	};
	
	public String getParameterName()
	{
		return this.parameterName;
	};
	
	public void setIsEnabled(int enabled)
	{
		this.isEnabled = enabled;
	};
	
	public int getIsEnabled()
	{
		return this.isEnabled;
	};
	
}