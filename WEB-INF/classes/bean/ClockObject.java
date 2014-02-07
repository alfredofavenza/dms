package bean;

import java.io.*;
import java.util.ArrayList; 

public class ClockObject {
	private String clockName;
	private int clockClass;
	private int isEnabled;
	private ArrayList<ClockParameter> parameters;
	
	public ClockObject(String name, int cclass, int enabled)
	{
		this.clockName = name;
		this.clockClass = cclass;
		this.isEnabled = enabled;
		this.parameters = new ArrayList<ClockParameter> ();
	};
	
	public void setClockName(String name)
	{
		this.clockName = name;
	};
	
	public String getClockName()
	{
		return this.clockName;
	};
	
	public void setClockClass(int cclass)
	{
		this.clockClass = cclass;
	};
	
	public int getClockClass()
	{
		return this.clockClass;
	};
	
	public void setIsEnabled(int enabled)
	{
		this.isEnabled = enabled;
	};
	
	public int getIsEnabled()
	{
		return this.isEnabled;
	};
	
	public void addParameter(String name, int enabled)
	{
		ClockParameter newParam = new ClockParameter(name, enabled) ;
		parameters.add(newParam);
	};
	
	public ArrayList<ClockParameter> getParameters()
	{
		return this.parameters;
	};
	
	public ClockParameter getParameter(int index)
	{
		return this.parameters.get(index);
	};
}