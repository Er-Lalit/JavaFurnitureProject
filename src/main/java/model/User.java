package model;

public class User {
private String name;
private String email;
private String contact;
private String password;
private String cPassword;
private int id;
private boolean status;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public boolean isStatus() {
	return status;
}
public void setStatus(boolean status) {
	this.status = status;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getContact() {
	return contact;
}
public void setContact(String contact) {
	this.contact = contact;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getCpassword() {
	return cPassword;
}
public void setCpassword(String cpassword) {
	this.cPassword = cpassword;
}
}
