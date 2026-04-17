using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection();


        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SaveCandidate();
        }

        public void SaveCandidate()
        {
            string Qualification = DropDownList1.SelectedValue;
            string Experience = DropDownList2.SelectedValue;
            string name = TextBox1.Text;
            string Contact = TextBox2.Text;
            string email = TextBox3.Text;
            decimal ctc = decimal.Parse(TextBox4.Text);
            decimal ectc = decimal.Parse(TextBox5.Text);
            string notice = DropDownList3.SelectedValue;


            FileUpload1.SaveAs(Server.MapPath("Resume/") + Path.GetFileName(FileUpload1.FileName));
            string attachment = "Resume/" + Path.GetFileName(FileUpload1.FileName);

            string checkQuery = $"EXEC CheckCandidate '{Contact}', '{email}'";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            int count = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (count >= 1)
            {
                Response.Write("<script>alert('Candidate already exists')</script>");
                return;
            }

            string query = $"exec ICandidate '{Qualification}','{Experience}','{name}','{Contact}','{email}','{ctc}','{ectc}','{notice}','{attachment}'";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Application Submitted Successfully')</script>");


            SendMail();
            if (DropDownList2.SelectedValue == "Fresher")
            {

                Session["Em"] = email;
                Session["name"] = name;
                Session["Contact"] = Contact;
                Response.Redirect("Schedule.aspx");
            }
        }

        public void SendMail()
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("Fusebizz@gmail.com");
            mail.To.Add(TextBox3.Text);
            mail.Subject = "Candidate Application";
            mail.Body = $"Hi {TextBox1.Text} and Contact no: {TextBox2.Text} your application has been successfully submitted. We will get back to you if your profile matches our requirements.";


            MailMessage hrmail = new MailMessage();
            hrmail.From = new MailAddress("Fusebizz@gmail.com");
            hrmail.To.Add("Fusebizz@gmail.com");
            hrmail.Subject = "New Application";
            hrmail.Body = $"Candidate Application Details\n\n" +
              $"Name: {TextBox1.Text}\n" +
              $"Contact No: {TextBox2.Text}\n" +
              $"Email: {TextBox3.Text}\n" +
              $"CTC: {TextBox4.Text}\n" +
              $"ECTC: {TextBox5.Text}\n" +
              $"Qualification: {DropDownList1.SelectedValue}\n" +
              $"Experience: {DropDownList2.SelectedValue}\n" +
              $"Notice Period: {DropDownList3.SelectedValue}\n" +
              $"Attachment: {FileUpload1.FileName}";


            string attachment = "Resume/" + Path.GetFileName(FileUpload1.FileName);

            hrmail.Attachments.Add(new Attachment(Server.MapPath(attachment)));


            SmtpClient smtp = new SmtpClient("smtp.gmail.com");
            smtp.Credentials = new NetworkCredential("Fusebizz@gmail.com", "ktoydskfjwvokgyx");
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.Send(mail);
            smtp.Send(hrmail);
            Response.Write("<script>alert('Mail sent successfully')</script>");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Other")
            {
                Button1.Enabled = false;
                Label1.Text = "You are not eligible for this role.";

            }
            else
            {
                Button1.Enabled = true;
                Label1.Text = "";
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList2.SelectedValue == "Fresher")
            {
                TextBox4.Enabled = false;
                TextBox5.Enabled = false;
                TextBox4.Text = "0";
                TextBox5.Text = "0";
            }
            else
            {
                TextBox4.Enabled = true;
                TextBox5.Enabled = true;
                TextBox4.Text = "";
                TextBox5.Text = "";
            }
        }
    }
}