using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Calicomp
{
    public class Database_Control
    {
        string constring = ConfigurationManager.ConnectionStrings["calicompConnection"].ConnectionString;

        public DataTable View()
        {
            var dataTable = new DataTable();


            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Select_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                   // calicompCMD.Parameters.Add(new SqlParameter("@Email", email));

                    SqlDataAdapter adapt = new SqlDataAdapter(calicompCMD);

                    adapt.Fill(dataTable);

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
            return dataTable;
        }

        public DataTable View_Shifts()
        {
            var dataTable = new DataTable();


            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Select_shifts", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                    // calicompCMD.Parameters.Add(new SqlParameter("@Email", email));

                    SqlDataAdapter adapt = new SqlDataAdapter(calicompCMD);

                    adapt.Fill(dataTable);

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
            return dataTable;
        }

        public Tuple<string, string, byte[]> getFile(int id)
        {
            byte[] bytes;
            string filename, filetype;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Select_File", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                    calicompCMD.Parameters.Add(new SqlParameter("@Leave_ID", id));
                    using (SqlDataReader sdr = calicompCMD.ExecuteReader())
                    {
                        sdr.Read();
                        bytes = (byte[])sdr["Evidence"];
                        filetype = sdr["File_Type"].ToString();
                        filename = sdr["File_Name"].ToString();
                    }
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
               return new Tuple<string, string, byte[]>(filename, filetype, bytes);
            }
            
        }

        public void approve_leave(int id)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("ApproveLeave", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                    calicompCMD.Parameters.Add(new SqlParameter("@Leave_ID", id));

                    calicompCMD.ExecuteNonQuery();

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

        public void reject_leave(int id)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("RejectLeave", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                    calicompCMD.Parameters.Add(new SqlParameter("@Leave_ID", id));

                    calicompCMD.ExecuteNonQuery();

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

        public int assign_shift(int id, int shiftid, DateTime dt)
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("ShiftDateValidation", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                    calicompCMD.Parameters.Add(new SqlParameter("@Staff_ID", id));
                    calicompCMD.Parameters.Add(new SqlParameter("@Shift_ID", shiftid));
                    calicompCMD.Parameters.Add(new SqlParameter("@Date_checker", dt));
                    calicompCMD.Parameters.Add(new SqlParameter("@Start_Date", SqlDbType.Date)).Value = DBNull.Value;
                    calicompCMD.Parameters.Add(new SqlParameter("@End_Date", SqlDbType.Date)).Value = DBNull.Value;
                    calicompCMD.Parameters.Add(new SqlParameter("@checker", SqlDbType.Int)).Value = 0;
 
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    //SqlParameter param = new SqlParameter("@checker", System.Data.SqlDbType.Int);
                    //param.Direction = System.Data.ParameterDirection.Output;

                    //int.TryParse(param.Value.ToString(), out checker);


                    checker = int.Parse(calicompCMD.Parameters["@checker"].Value.ToString());
                    calicompCMD.ExecuteNonQuery();

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    
                }
            }
            return checker;
        }

        public int submit_leave(int id, string type, string startdate, string enddate, byte[] evidence, string status, string remarks, 
            string filename, string filetype )
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Submit_Leave", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Staff_ID", id);
                    calicompCMD.Parameters.AddWithValue("@Leave_Type", type);
                    calicompCMD.Parameters.AddWithValue("@Start_Date", startdate);
                    calicompCMD.Parameters.AddWithValue("@End_Date", enddate);
                    calicompCMD.Parameters.AddWithValue("@Evidence", evidence);
                    calicompCMD.Parameters.AddWithValue("@Status", status);
                    calicompCMD.Parameters.AddWithValue("@Remarks", remarks);
                    calicompCMD.Parameters.AddWithValue("@File_Name", filename);
                    calicompCMD.Parameters.AddWithValue("@File_Type", filetype);
                    calicompCMD.Parameters.Add("@checker", SqlDbType.Int);
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    
                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    string parse = calicompCMD.Parameters["@checker"].Value.ToString();
                    checker = int.Parse(parse);
                }
            }
            return checker;
        }

        public int timeclock(int staffid, int shiftid, DateTime date)
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("clockinout_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Staff_ID", staffid);
                    calicompCMD.Parameters.AddWithValue("@Shift_ID", shiftid);
                    calicompCMD.Parameters.AddWithValue("@Today", date);
                    calicompCMD.Parameters.Add("@checker", SqlDbType.Int);
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    string parse = calicompCMD.Parameters["@checker"].Value.ToString();
                    checker = int.Parse(parse);
                }
            }
            return checker;
        }

        public int timeclockout(int staffid, int shiftid, DateTime date)
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("clockout_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Staff_ID", staffid);
                    calicompCMD.Parameters.AddWithValue("@Shift_ID", shiftid);
                    calicompCMD.Parameters.AddWithValue("@Today", date);
                    calicompCMD.Parameters.Add("@checker", SqlDbType.Int);
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    string parse = calicompCMD.Parameters["@checker"].Value.ToString();
                    checker = int.Parse(parse);
                }
            }
            return checker;
        }

        public void save_payroll(int id, DateTime dt, decimal amount)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Submit_Salary", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Staff_ID", id);
                    calicompCMD.Parameters.AddWithValue("@Date_checker", dt);
                    calicompCMD.Parameters.AddWithValue("@Total", amount);

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

        public void automate_shift(string dt, string enddate, int duration)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Automate_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Start_date", dt);
                    calicompCMD.Parameters.AddWithValue("@End_date", enddate);
                    calicompCMD.Parameters.AddWithValue("@Duration", duration);

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

        public DataTable viewProfile(int id)
        {
            var dataTable = new DataTable();


            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("SelectSpecificStaff", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;

                     calicompCMD.Parameters.Add(new SqlParameter("@id", id));

                    SqlDataAdapter adapt = new SqlDataAdapter(calicompCMD);

                    adapt.Fill(dataTable);

                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
            return dataTable;
        }

        public int submit_staff(string fname, string lname, string email, string phoneno, string address, string password, string type, decimal pay)
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Insert_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@First_Name", fname);
                    calicompCMD.Parameters.AddWithValue("@Last_Name", lname);
                    calicompCMD.Parameters.AddWithValue("@Email", email);
                    calicompCMD.Parameters.AddWithValue("@Phone_no", phoneno);
                    calicompCMD.Parameters.AddWithValue("@Address", address);
                    calicompCMD.Parameters.AddWithValue("@Password", password);
                    calicompCMD.Parameters.AddWithValue("@Type", type);
                    calicompCMD.Parameters.AddWithValue("@Pay_Rate", pay);
                    calicompCMD.Parameters.Add("@checker", SqlDbType.Int);
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    string parse = calicompCMD.Parameters["@checker"].Value.ToString();
                    checker = int.Parse(parse);
                }
            }
            return checker;
        }

        public void create_shift(string date, string shift, string start, string end, int duration)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Insert_Shift", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@Date", date);
                    calicompCMD.Parameters.AddWithValue("@shift", shift);
                    calicompCMD.Parameters.AddWithValue("@Start_time", start);
                    calicompCMD.Parameters.AddWithValue("@End_time", end);
                    calicompCMD.Parameters.AddWithValue("@Duration", duration);

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

        public string getemail(int id)
        {
            string parse;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("GetEmail", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@id", id);
                    calicompCMD.Parameters.Add("@email", SqlDbType.VarChar, 50);
                    calicompCMD.Parameters["@email"].Direction = ParameterDirection.Output;

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    parse = calicompCMD.Parameters["@email"].Value.ToString();
                }
            }
            return parse;
        }

        public int changepw(int id, string oldpw, string newpw)
        {
            int checker;
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("ChangePassword", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@ID", id);
                    calicompCMD.Parameters.AddWithValue("@oldpw", oldpw);
                    calicompCMD.Parameters.AddWithValue("@newpw", newpw);
                    calicompCMD.Parameters.Add("@checker", SqlDbType.Int);
                    calicompCMD.Parameters["@checker"].Direction = ParameterDirection.Output;

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                    string parse = calicompCMD.Parameters["@checker"].Value.ToString();
                    checker = int.Parse(parse);
                }
            }
            return checker;
        }

        public void submit_msg(int id, string name, string message)
        {
            using (SqlConnection calicompCon = new SqlConnection(constring))
            {
                using (SqlCommand calicompCMD = new SqlCommand("Insertmessage_proc", calicompCon))
                {
                    calicompCon.Open();
                    calicompCMD.CommandType = CommandType.StoredProcedure;
                    calicompCMD.Parameters.AddWithValue("@id", id);
                    calicompCMD.Parameters.AddWithValue("@name", name);
                    calicompCMD.Parameters.AddWithValue("@message", message);

                    calicompCMD.ExecuteNonQuery();
                    if (calicompCon.State == ConnectionState.Open)
                        calicompCon.Close();
                }
            }
        }

    }
}