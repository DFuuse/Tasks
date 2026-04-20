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
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                LoadGrid();
            }
         }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showAdd",
        "var m = new bootstrap.Modal(document.getElementById('addModal')); m.show();",
        true);
        }


        private void LoadGrid()
        {
            string query = "EXEC CRUDMasterEvent 'SELECT', NULL, NULL, NULL, NULL";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            GridView1.DataSource = dr;
            GridView1.DataBind();

            dr.Close();
        }

        protected void btnAddSave_Click(object sender, EventArgs e)
        {
            string query = $"EXEC CRUDMasterEvent 'INSERT', NULL, " +
               $"'{txtEventNameAdd.Text}', '{txtColorAdd.Text}', '{ddlStatusAdd.SelectedValue}'";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, GetType(), "closeAdd",
                "bootstrap.Modal.getInstance(document.getElementById('addModal')).hide();",
                true);

            LoadGrid();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            
            if (e.CommandName == "DeleteRow")
            {
                string query = $"EXEC CRUDMasterEvent 'DELETE', {id}, NULL, NULL, NULL";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.ExecuteNonQuery();

                LoadGrid();
            }

           
            else if (e.CommandName == "EditRow")
            {
                hfEditID.Value = id.ToString();

                string query = $"EXEC CRUDMasterEvent 'SELECTBYID', {id}, NULL, NULL, NULL";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtEventName.Text = dr["EventName"].ToString();
                    txtColor.Text = dr["Color"].ToString();
                    ddlStatus.SelectedValue = dr["Status"].ToString();
                }

                dr.Close();

                ScriptManager.RegisterStartupScript(this, GetType(), "show",
                    "var m = new bootstrap.Modal(document.getElementById('editModal')); m.show();",
                    true);
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(hfEditID.Value);

            string query = $"EXEC CRUDMasterEvent 'UPDATE', {id}, " +
                $"'{txtEventName.Text}', '{txtColor.Text}', '{ddlStatus.SelectedValue}'";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, GetType(), "close",
                "bootstrap.Modal.getInstance(document.getElementById('editModal')).hide();",
                true);

            LoadGrid();
        }
    }
}