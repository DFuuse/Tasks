<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Masterevent.aspx.cs" Inherits="Task_3.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Event Name">
        <ItemTemplate>
            <%# Eval("EventName") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Color">
        <ItemTemplate>
            <%# Eval("Color") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Status">
        <ItemTemplate>
            <%# Eval("Status") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Action">
    <ItemTemplate>
        <asp:Button runat="server" Text="Edit" CssClass="btn btn-sm btn-primary"
            CommandName="EditRow" CommandArgument='<%# Eval("mID") %>' />
        <asp:Button runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
            CommandName="DeleteRow" CommandArgument='<%# Eval("mID") %>'
            OnClientClick="return confirm('Are you sure?');" />
    </ItemTemplate>
</asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Event</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <asp:HiddenField ID="hfEditID" runat="server" />

                <div class="mb-3">
                    <label class="form-label">Event Name</label>
                    <div class="mb-3">
                        <label class="form-label">Event Name</label>
                        <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Color</label>
                    <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                    CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>
</div>




    <div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Add Event</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-3">
                    <label class="form-label">Event Name</label>
                    <div class="mb-3">
                    <label class="form-label">Event Name</label>
                    <asp:TextBox ID="txtEventNameAdd" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Color</label>
                    <asp:TextBox ID="txtColorAdd" runat="server" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatusAdd" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

                <asp:Button ID="btnAddSave" runat="server" Text="Add"
                    CssClass="btn btn-success" OnClick="btnAddSave_Click" />
            </div>

        </div>
    </div>
</div>
</asp:Content>
