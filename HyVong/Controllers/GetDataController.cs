using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HyVong.Controllers
{
     class MyObj
     {
        public string MACP;

        public float GiaMua1;
        public int KLMua1;
        public float GiaMua2;
        public int KLMua2;
        public float GiaMua3;
        public int KLMua3;

        public float GiaKhopLenh;
        public int KLKhopLenh;


        public float GiaBan1;
        public int KLBan1;
        public float GiaBan2;
        public int KLBan2;
        public float GiaBan3;
        public int KLBan3;

        public int TongKL;
     }

        public class GetDataController : Controller
        {
            [Route("/datas")]
            public string Datas()
            {

            string _connectstring = MyBackgroundService.connetionString;
            SqlConnection conn = new SqlConnection(_connectstring);
            conn.Open();

            SqlCommand command = new SqlCommand("SELECT * FROM dbo.BANGTRUCTUYEN", conn);

            List<MyObj> myObjectList = new List<MyObj>();

            // int result = command.ExecuteNonQuery();
            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    MyObj myObject = new MyObj();
                    myObject.MACP = reader["MACP"].ToString();

                    myObject.GiaMua1 = float.Parse("0" + reader["GiaMua1"].ToString());
                    myObject.GiaMua2 = float.Parse("0" + reader["GiaMua2"].ToString());
                    myObject.GiaMua3 = float.Parse("0" + reader["GiaMua3"].ToString());

                    myObject.GiaBan1 = float.Parse("0" + reader["GiaBan1"].ToString());
                    myObject.GiaBan2 = float.Parse("0" + reader["GiaBan2"].ToString());
                    myObject.GiaBan3 = float.Parse("0" + reader["GiaBan3"].ToString());

                    myObject.KLMua1 = int.Parse("0" + reader["KLMua1"].ToString());
                    myObject.KLMua2 = int.Parse("0" + reader["KLMua2"].ToString());
                    myObject.KLMua3 = int.Parse("0" + reader["KLMua3"].ToString());

                    myObject.KLBan1 = int.Parse("0" + reader["KLBan1"].ToString());
                    myObject.KLBan2 = int.Parse("0" + reader["KLBan2"].ToString());
                    myObject.KLBan3 = int.Parse("0" + reader["KLBan3"].ToString());


                    myObject.TongKL = int.Parse("0" + reader["TongKL"].ToString());
                    myObject.GiaKhopLenh = float.Parse("0" + reader["GiaKhopLenh"].ToString());
                    myObject.KLKhopLenh = int.Parse("0" + reader["KLKhopLenh"].ToString());
                    myObjectList.Add(myObject);
                }
            }

            conn.Close();

            var JsonResult = JsonConvert.SerializeObject(myObjectList);
            return (JsonResult);
            }


        [HttpGet("datlenh")]
        public string DatLenh(bool loaigd, string macp, int soluong, float giadat)
        {
            Console.WriteLine(loaigd);
            Console.WriteLine(macp);
            Console.WriteLine(soluong);
            Console.WriteLine(giadat);


            char loaigd_ = 'M';
            if(loaigd == false) loaigd_ = 'B';

            string _connectstring = MyBackgroundService.connetionString;
            SqlConnection cnn = new SqlConnection(_connectstring);
            cnn.Open();

            string query = "PREC_LENHDAT_MACP";
            SqlCommand com = new SqlCommand(query, cnn);
            com.CommandType = CommandType.StoredProcedure;

            com.Parameters.AddWithValue("@macp", macp);
            com.Parameters.AddWithValue("@loaigd", loaigd_);
            com.Parameters.AddWithValue("@soluongx", soluong);
            com.Parameters.AddWithValue("@giadatx", giadat);
            int i = com.ExecuteNonQuery();
            if (i > 0)
            {
                return "Thanh cong";
                cnn.Close();
            }
            else
            {
                return "That bai";
                cnn.Close();
            }

           


        }

    }


}
