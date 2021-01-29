<%@page import="com.ncs.utils.DataUtility"%>
<%@page import="com.ncs.Model.RoleModel"%>
<%@page import="com.ncs.utils.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ncs.controller.UserListCtl"%>
<%@page import="com.ncs.utils.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>UserList</title>
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>
</head>
<body>
	<jsp:useBean id="bean" class="com.ncs.beans.UserBean" scope="request"></jsp:useBean>

	<center>
		<form action="<%=ORSView.USER_LIST_CTL%>" method="post">
			<%@include file="Header.jsp"%>
			<center>

				<div align="center">
					<h1>User List</h1>
					<h3>
						<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
						<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
					</h3>

				</div>

				<%
					List rlist = (List) request.getAttribute("RoleList");

					List ulist = (List) request.getAttribute("LoginId");

					int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
				%>


				<%
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;

					List list = ServletUtility.getList(request);
					Iterator<UserBean> it = list.iterator();

					if (list.size() != 0) {
				%>
				<table width="80%" align="center">
					<tr>
						<th></th>
						<td align="center"><label>FirstName:</label> <input
							type="text" name="firstName" placeholder="Enter First Name"
							value="<%=ServletUtility.getParameter("firstName", request)%>">

							<label> Role:</label> <%=HTMLUtility.getList("roleid", String.valueOf(bean.getRoleId()), rlist)%>

							<label>LoginId:</label> <%=HTMLUtility.getList("loginid", String.valueOf(bean.getLogin()), ulist)%>

							&nbsp; <input type="submit" name="operation"
							value="<%=UserListCtl.OP_SEARCH%>"> &nbsp; <input
							type="submit" name="operation" value="<%=UserListCtl.OP_RESET%>">

						</td>
					</tr>
				</table>
				<br>

				<table border="1" width="100%" align="center" cellpadding=4px
					cellspacing=".2">
					<tr style="background: skyblue">
						<th><input type="checkbox" id="select_all" name="select">Select
							All</th>

						<th>S.No.</th>
						<th>FirstName</th>
						<th>LastName</th>
						<th>Role</th>
						<th>LoginId</th>
						<th>Gender</th>
						<th>Date Of Birth</th>
						<th>Mobile No</th>
						<th>Edit</th>
					</tr>

					<%
						while (it.hasNext()) {
								bean = it.next();

							RoleModel model = new RoleModel();
								RoleBean rolebean = new RoleBean();

								rolebean = model.findByPK(bean.getRoleId());
					%>


					<tr align="center">
						<td><input type="checkbox" class="checkbox" name="ids"
							value="<%=bean.getId()%>"
							<%if (bean.getRoleId() == RoleBean.ADMIN) {%> <%="disabled"%>
							<%}%>></td>

						<td><%=index++%></td>
						<td><%=bean.getFirstName()%></td>
						<td><%=bean.getLastName()%></td>
						<td><%=rolebean.getName()%></td>
						<td><%=bean.getLogin()%></td>
						<td><%=bean.getGender()%></td>
						<td><%=bean.getDob()%></td>
						<td><%=bean.getMobileNo()%></td>
						<td><a href="UserCtl?id=<%=bean.getId()%>"
							<%if (userBean.getId() == bean.getId() || bean.getRoleId() == RoleBean.ADMIN) {%>
							onclick="return false;" <%}%>>Edit</a></td>
					</tr>
					<%
						}
					%>
				</table>

				<table width="100%">
					<tr>
						<th></th>
						<%
							if (pageNo == 1) {
						%>
						<td><input type="submit" name="operation" disabled="disabled"
							value="<%=UserListCtl.OP_PREVIOUS%>"></td>
						<%
							} else {
						%>
						<td><input type="submit" name="operation"
							value="<%=UserListCtl.OP_PREVIOUS%>"></td>
						<%
							}
						%>

						<td><input type="submit" name="operation"
							value="<%=UserListCtl.OP_DELETE%>"></td>
						<td><input type="submit" name="operation"
							value="<%=UserListCtl.OP_NEW%>"></td>


						<td align="right"><input type="submit" name="operation"
							value="<%=UserListCtl.OP_NEXT%>"
							<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>



					</tr>
				</table>
				<%
					}
					if (list.size() == 0) {
				%>
				<td align="center"><input type="submit" name="operation"
					value="<%=UserListCtl.OP_BACK%>"></td>
				<%
					}
				%>

				<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
					type="hidden" name="pageSize" value="<%=pageSize%>">
		</form>
		<%@include file="Footer.jsp"%>
	</center>

</body>

</html>