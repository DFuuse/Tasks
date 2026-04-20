<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Holiday.aspx.cs" Inherits="Task_3.Holiday" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Button1_Click"/>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">
    <Columns>
        <asp:TemplateField HeaderText="Event Type">
        <ItemTemplate>
            <%# Eval("EventType") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Holiday Title">
        <ItemTemplate>
            <%# Eval("HolidayTitle") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Date">
        <ItemTemplate>
            <%# Eval("Date", "{0:yyyy-MM-dd}") %>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Status">
        <ItemTemplate>
            <%# Eval("Status") %>
        </ItemTemplate>
    </asp:TemplateField>
        <asp:TemplateField HeaderText="Action">
        <ItemTemplate>
            <asp:Button runat="server" Text="Edit"
                CssClass="btn btn-sm btn-primary me-2"
                CommandName="EditHoliday"
                CommandArgument='<%# Eval("hID") %>' />

            <asp:Button runat="server" Text="Delete"
                CssClass="btn btn-sm btn-danger"
                CommandName="DeleteHoliday"
                CommandArgument='<%# Eval("hID") %>'
                OnClientClick="return confirm('Are you sure you want to delete this record?');" />
        </ItemTemplate>
    </asp:TemplateField>
    </Columns>
</asp:GridView>

   <div class="modal fade" id="editHolidayModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Edit Holiday</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <asp:HiddenField ID="hfHolidayID" runat="server" />

                <div class="mb-3">
                    <label class="form-label">Event</label>
                    <asp:DropDownList ID="ddlEventEdit" runat="server" CssClass="form-select" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Holiday Title</label>
                    <asp:TextBox ID="txtHolidayTitleEdit" runat="server" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Date</label>
                    <asp:TextBox ID="txtDateEdit" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatusEditHoliday" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

            </div>

            <div class="modal-footer">
                <asp:Button ID="btnUpdateHoliday" runat="server" Text="Update"
                    CssClass="btn btn-primary" OnClick="btnUpdateHoliday_Click" />
            </div>

        </div>
    </div>
</div>




    <div class="modal fade" id="addHolidayModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Add Holiday</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-3">
                    <label class="form-label">Event</label>
                    <asp:DropDownList ID="ddlEventAdd" runat="server" CssClass="form-select" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Holiday Title</label>
                    <asp:TextBox ID="txtHolidayTitleAdd" runat="server" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Date</label>
                    <asp:TextBox ID="txtDateAdd" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatusAddHoliday" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

            </div>

            <div class="modal-footer">
                <asp:Button ID="btnAddHoliday" runat="server" Text="Add"
                    CssClass="btn btn-success" OnClick="btnAddHoliday_Click" />
            </div>

        </div>
    </div>
</div>
</asp:Content>
