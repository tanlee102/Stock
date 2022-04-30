using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using HyVong.Models;
using System.Data.SqlClient;
using Microsoft.AspNetCore.SignalR;
using SignalRChat.Hubs;



namespace HyVong.Controllers
{
    public class HomeController : Controller
    {

        public IActionResult Index()
        {
            return View("../Home/Home");
        }

        [Route("/nhapcophieu")]
        public IActionResult NhapCoPhieu()
        {
            return View("../Home/CoPhieu");
        }


        //public  string Welcome(string name, int numTimes = 1)
        //{
        //    return System.Text.Encodings.Web.HtmlEncoder.Default.Encode($"Hello {name}, NumTimes is: {numTimes}");
        //}
    }
}
