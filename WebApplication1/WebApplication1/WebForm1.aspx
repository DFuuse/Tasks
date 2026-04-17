<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Qualification:<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem>BSc CS</asp:ListItem>
                <asp:ListItem>BSc IT</asp:ListItem>
                <asp:ListItem>Btech</asp:ListItem>
                <asp:ListItem>BCA</asp:ListItem>
                <asp:ListItem>MCA</asp:ListItem>
                <asp:ListItem>BE IT/CS</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server"></asp:Label>
            <br />
            Experience:<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                <asp:ListItem>Fresher</asp:ListItem>
                <asp:ListItem>Experienced</asp:ListItem>
            </asp:DropDownList>
            <br />
            Name:<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            Contact no:<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" ErrorMessage="Invalid Number" ForeColor="Red" ValidationExpression="^[6-9]\d{9}$"></asp:RegularExpressionValidator>
            <br />
            Email:<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox3" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <br />
            CTC:<asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <br />
            ECTC:<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
            <br />
            Notice period:<asp:DropDownList ID="DropDownList3" runat="server">
                <asp:ListItem>15 Days or Less</asp:ListItem>
                <asp:ListItem>30 Days</asp:ListItem>
                <asp:ListItem>60 Days</asp:ListItem>
                <asp:ListItem>90 Days</asp:ListItem>
            </asp:DropDownList>
            <br />
            Attachment:<asp:FileUpload ID="FileUpload1" runat="server" />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </div>
    </form>
</body>
</html>
