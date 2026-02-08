<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.User" %>

<% List<User> user=(List<User>)request.getAttribute("user");
%>
<div class="user-management">
    <h2>Active Users</h2>
    <div class="user-table">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <!-- Dynamic data rows will be fetched here -->
                <% if(user!=null && !user.isEmpty()){
                	for(User u:user){
                	%>
                <tr>
                    <td><%=u.getId()%></td>
                    <td><%=u.getName()%></td>
                    <td><%=u.getEmail()%></td>
                    <td><%=u.getContact()%></td>
                    <td>Active</td>
                    <td>
                        <form action="BlockUserController" method="post">
                            <input type="hidden" name="userId" value="<%=u.getId()%>" />
                            <button type="submit" class="block-btn">
                                <i class="fas fa-user-lock"></i> Block
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                	}
                }
                else{
                %>
               <tr>
                  <td colspan="6">No active users found</td>
               </tr>
              <% }%>
                
            </tbody>
        </table>
    </div>
</div>

<style>
    .user-management {
        padding: 30px;
        text-align: center;
    }
    .user-table table {
        width: 100%;
        border-collapse: collapse;
    }
    .user-table th, .user-table td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    .user-table th {
        background-color: #f2f2f2;
    }
    .block-btn {
        background-color: #ff4d4d;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 5px;
        cursor: pointer;
    }
    .block-btn:hover {
        background-color: #e60000;
    }
</style>
