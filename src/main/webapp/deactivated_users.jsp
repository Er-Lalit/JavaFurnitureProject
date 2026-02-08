<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="user-management">
    <h2>Deactivated Users</h2>
    <div class="user-table">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <!-- Dynamic data rows will be fetched here -->
                <tr>
                    <td><!-- User ID --></td>
                    <td><!-- Name --></td>
                    <td><!-- Email --></td>
                    <td><!-- Contact --></td>
                    <td>Deactivated</td>
                </tr>
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
</style>
