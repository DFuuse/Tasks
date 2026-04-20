using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task_3
{
    public partial class Holiday : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                LoadEventDropdown();
                LoadHolidayGrid();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showAdd",
        "var m = new bootstrap.Modal(document.getElementById('addHolidayModal')); m.show();",
        true);
        }

        private void LoadEventDropdown()
        {
            
            string q = "SELECT mID, EventName FROM MasterEvent";
            SqlCommand cmd = new SqlCommand(q, conn);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            System.Data.DataTable dt = new System.Data.DataTable();
            da.Fill(dt);

        
            ddlEventAdd.DataSource = dt;
            ddlEventAdd.DataTextField = "EventName";
            ddlEventAdd.DataValueField = "mID";
            ddlEventAdd.DataBind();

      
            ddlEventEdit.DataSource = dt;
            ddlEventEdit.DataTextField = "EventName";
            ddlEventEdit.DataValueField = "mID";
            ddlEventEdit.DataBind();
        }
        private void LoadHolidayGrid()
        {
            
            string q = "EXEC CRUDHoliday 'SELECT'";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            GridView1.DataSource = dr;
            GridView1.DataBind();

            dr.Close();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            
            if (e.CommandName == "DeleteHoliday")
            {
                string q = $"EXEC CRUDHoliday 'DELETE', {id}";

                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();

                LoadHolidayGrid();
            }

            
            else if (e.CommandName == "EditHoliday")
            {
                hfHolidayID.Value = id.ToString();

                string q = $"EXEC CRUDHoliday 'SELECTBYID', {id}";

                SqlCommand cmd = new SqlCommand(q, conn);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    ddlEventEdit.SelectedValue = dr["mID"].ToString();
                    txtHolidayTitleEdit.Text = dr["HolidayTitle"].ToString();
                    txtDateEdit.Text = Convert.ToDateTime(dr["Date"]).ToString("yyyy-MM-dd");
                    ddlStatusEditHoliday.SelectedValue = dr["Status"].ToString();
                }

                dr.Close();

                ScriptManager.RegisterStartupScript(this, GetType(), "show",
                    "var m = new bootstrap.Modal(document.getElementById('editHolidayModal')); m.show();",
                    true);
            }
        }

        protected void btnAddHoliday_Click(object sender, EventArgs e)
        {


            string q = $"EXEC CRUDHoliday 'INSERT', NULL, {ddlEventAdd.SelectedValue}, " +
           $"'{txtHolidayTitleAdd.Text}', '{txtDateAdd.Text}', '{ddlStatusAddHoliday.SelectedValue}'";


            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, GetType(), "close",
                "bootstrap.Modal.getInstance(document.getElementById('addHolidayModal')).hide();",
                true);

            LoadHolidayGrid();
        }

        protected void btnUpdateHoliday_Click(object sender, EventArgs e)
        {
            

            int id = Convert.ToInt32(hfHolidayID.Value);

            string q = $"EXEC CRUDHoliday 'UPDATE', {id}, {ddlEventEdit.SelectedValue}, " +
           $"'{txtHolidayTitleEdit.Text}', '{txtDateEdit.Text}', '{ddlStatusEditHoliday.SelectedValue}'";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, GetType(), "close",
                "bootstrap.Modal.getInstance(document.getElementById('editHolidayModal')).hide();",
                true);

            LoadHolidayGrid();
        }

       
    }
}