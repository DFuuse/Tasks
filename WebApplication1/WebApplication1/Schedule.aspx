<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="WebApplication1.Schedule" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please book your preferred slot for the Interview<br />
            <br />
            Day:<asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Monday</asp:ListItem>
                <asp:ListItem>Tuesday</asp:ListItem>
                <asp:ListItem>Wednesday</asp:ListItem>
                <asp:ListItem>Thursday</asp:ListItem>
                <asp:ListItem>Friday</asp:ListItem>
                <asp:ListItem>Saturday</asp:ListItem>
            </asp:DropDownList>
            <br />
            Time Slots:
            <asp:DropDownList ID="DropDownList2" runat="server">
                <asp:ListItem>9-10</asp:ListItem>
                <asp:ListItem>10-11</asp:ListItem>
                <asp:ListItem>11-12</asp:ListItem>
                <asp:ListItem>1-2</asp:ListItem>
                <asp:ListItem>2-3</asp:ListItem>
                <asp:ListItem>3-4</asp:ListItem>
                <asp:ListItem>4-5</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Book" />
        </div>
    </form>
</body>
</html>
