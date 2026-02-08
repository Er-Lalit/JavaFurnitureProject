package repository;

import java.util.List;

import model.User;

public interface UserRepository {
	public void SaveUser(User u)throws Exception;
	public boolean CheckEmail(User u) throws Exception;
	public boolean checkMoblie(User u)throws Exception ;
	public boolean CheckUsername(User u)throws Exception;
	public boolean CheckLoginUser(User u)throws Exception;
	public User ProfileDetail(User u) throws Exception;
	public String GenerateOtp(User u)throws Exception;
	public boolean isvalidePassword(User u) throws Exception;
	public boolean isvalideMail(User u) throws Exception;
	public boolean isvalideNumber(User u) throws Exception;
	public List<User> getActiveUser()throws Exception;
	public void blockUser(User u)throws Exception;
	public List<User> getBlockedUser()throws Exception;
	public void unblockUser(User u)throws Exception;
	
}