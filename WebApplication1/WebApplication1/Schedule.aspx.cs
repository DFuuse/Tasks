using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class Schedule : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string email = Session["Em"].ToString();
            string day = DropDownList1.SelectedValue;
            string slot = DropDownList2.SelectedValue;



            string DuplicateQuery = $"EXEC CSchedule '{email}'";
            SqlCommand duplicateCmd = new SqlCommand(DuplicateQuery, conn);
            int dCount = Convert.ToInt32(duplicateCmd.ExecuteScalar());
            if (dCount >= 1)
            {
                Response.Write("<script>alert('You have already booked a slot')</script>");
                return;
            }




            string checkQuery = $"EXEC GetScheduleCount '{day}', '{slot}'";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            int count = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (count >= 2)
            {
                Response.Write("<script>alert('Slot is Full Please try other slots')</script>");
                return;
            }


            else
            {
                string query = $"EXEC ISchedule '{day}', '{slot}', '{email}'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Slot booked successfully')</script>");
                newemail();
            }
        }

        public void newemail()
        {
            string email = Session["Em"].ToString();
            string name =  Session["name"].ToString(); 
            string Contact = Session["Contact"].ToString();
            string day = DropDownList1.SelectedValue;
            string slot = DropDownList2.SelectedValue;


            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("Fusebizz@gmail.com");
            mail.To.Add(email);
            mail.Subject = "Candidate Slot";
            mail.Body = $"Dear Candidate your Slot has been successfully confirmed at '{day}' and '{slot}'.Please be on Time";


            MailMessage hrmail = new MailMessage();
            hrmail.From = new MailAddress("Fusebizz@gmail.com");
            hrmail.To.Add("Fusebizz@gmail.com");
            hrmail.Subject = "Candidate Slot";
            hrmail.Body = $"Candidate {name}, contact no: {Contact}, has successfully booked the interview slot on {day} at {slot}.";

            SmtpClient smtp = new SmtpClient("smtp.gmail.com");
            smtp.Credentials = new NetworkCredential("Fusebizz@gmail.com", "ktoydskfjwvokgyx");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(mail);
            smtp.Send(hrmail);
            Response.Write("<script>alert('Mail sent successfully')</script>");
        }
    }
}