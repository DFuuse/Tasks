using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task_3
{
    public partial class Calender : System.Web.UI.Page
    {
        SqlConnection conn;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            

            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            conn = new SqlConnection(cs);

            if (!IsPostBack)
            {
                LoadCalendarData();
            }
        }
        private void LoadCalendarData()
        {

            string q = @"
        SELECT 
            h.Date,
            h.HolidayTitle,
            m.Color
        FROM Holiday h
        INNER JOIN MasterEvent m ON h.mID = m.mID";

            SqlDataAdapter da = new SqlDataAdapter(q, conn);
            dt = new DataTable();
            da.Fill(dt);

            ViewState["CalendarData"] = dt;
        }
        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["CalendarData"];
            if (dt == null) return;

            foreach (DataRow row in dt.Rows)
            {
                DateTime dbDate = Convert.ToDateTime(row["Date"]);

                if (e.Day.Date == dbDate)
                {
                    Label lbl = new Label();
                    lbl.Text = "• " + row["HolidayTitle"].ToString();


                    string color = row["Color"].ToString();
                    lbl.ForeColor = Color.FromName(color);

                    e.Cell.Controls.Add(new LiteralControl("<br/>"));
                    e.Cell.Controls.Add(lbl);
                }
            }
        }
    }
}