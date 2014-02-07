package bean;

import java.io.*;
import java.util.ArrayList; 
import java.io.Serializable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import dmsmanager.DmsMng;

public class TaskObject implements Serializable {
	private int taskId;
	private String taskName;
	private ArrayList<ClockObject> clocks;
	
	public TaskObject()
	{
		this.taskId = 0;
		this.taskName = "";
		this.clocks = new ArrayList<ClockObject> ();
	}
	
	public TaskObject(int id, String name)
	{
		this.taskId = id;
		this.taskName = name;
		this.clocks = new ArrayList<ClockObject> ();
	}
	
	public String getHello()
	{
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		Connection dbconn = null;
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/dms_archive?zeroDateTimeBehavior=round", user_db, pwd_db);
			Statement statement = dbconn.createStatement();
			Statement statement1 = dbconn.createStatement();
			Statement statement2 = dbconn.createStatement();
			ResultSet rs2;
			this.setTaskId(32);
			this.setTaskName("Alfredo");
		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return "HELLO";
	};
	
	public void getDataFromDatabase(int taskid, String taskname)
	{
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		Connection dbconn = null;
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/dms_archive?zeroDateTimeBehavior=round", user_db, pwd_db);
			String q1 = "";
			String q2 = "";
			Statement statement1 = dbconn.createStatement();
			Statement statement2 = dbconn.createStatement();
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			
			// Set object TaskName and TaskID
			this.setTaskId(taskid);
			this.setTaskName(taskname);
			
			// Get all the clock for this task and fill 
			q1 = "Select distinct(Clock_Name), Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task="+taskid;
			rs1 = statement1.executeQuery(q1);

			// Get all the parameter for each clock and fill the Object
			int i = 0;
			while (rs1.next())
			{
				this.addClock(rs1.getString("Clock_Name"), 1, rs1.getInt("Is_Enabled"));
				
				q2 = "Select Parameter_Name, Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task='"+taskid+"' and Clock_Name='"+rs1.getString("Clock_Name")+"'";
				rs2 = statement2.executeQuery(q2);
				while(rs2.next())
				{
					this.getClock(i).addParameter(rs2.getString("Parameter_Name"), rs2.getInt("Is_Enabled"));
				}
				i++;
			}
			rs1.close();
			rs2.close();
			statement1.close();
			statement2.close();
			dbconn.close();
		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	public void setTaskId(int id)
	{
		this.taskId = id;
	};
	
	public int getTaskId()
	{
		return this.taskId;
	};
	
	public void setTaskName(String name)
	{
		this.taskName = name;
	};
	
	public String getTaskName()
	{
		return this.taskName;
	};
	
	public void addClock(String name, int cclass, int enabled)
	{
		ClockObject newClock = new ClockObject(name, cclass, enabled);
		this.clocks.add(newClock);
	};
	
	public ArrayList<ClockObject> getClocks()
	{
		return this.clocks;
	};
	
	public ClockObject getClock(int index)
	{
		return this.clocks.get(index);
	};
}