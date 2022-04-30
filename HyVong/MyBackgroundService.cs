using System;

using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

using SignalRChat.Hubs;

namespace HyVong
{

    public class MyBackgroundService : IHostedService, IDisposable
    {
        public static IHubContext<ChatHub> _hub;
        private readonly ILogger<MyBackgroundService> logger;

        public static string connetionString = @"Data Source='127.0.0.1, 1433';Initial Catalog=CHUNGKHOAN;User ID=sa;Password=reallyStrongPwd123";
        private string querydep = @"SELECT MACP, GiaMua1, KLMua1, GiaMua2, KLMua2, GiaMua3, KLMua3, GiaKhopLenh, KLKhopLenh, GiaBan1, KLBan1, GiaBan2, KLBan2, GiaBan3, KLBan3, TongKL FROM dbo.BANGTRUCTUYEN";
        SqlConnection connection;

        public MyBackgroundService(ILogger<MyBackgroundService> logger, IHubContext<ChatHub> hub)
        {
            _hub = hub;
            this.logger = logger;
            connection = new SqlConnection(connetionString);
            try
            {
                SqlDependency.Start(connetionString);
            }
            catch (InvalidOperationException ex)
            {
               Console.WriteLine("Bạn chưa cho phép dịch vụ Broker trên database này!");
            }
            connection.Open();
        }

        void DEpe()
        {
            // Create a new SqlCommand object.
            using (SqlCommand command = new SqlCommand(
                querydep,
                connection))
            {
                // Create a dependency and associate it with the SqlCommand.
                SqlDependency dependency = new SqlDependency(command);

                // Subscribe to the SqlDependency event.
                dependency.OnChange += new
                   OnChangeEventHandler(OnDependencyChange);

                // Subcriber.
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    // Process the DataReader.
                }
            }
        }

        // Handler method
        void OnDependencyChange(object sender,
           SqlNotificationEventArgs e)
        {
            //Remove depe
            SqlDependency dependency = sender as SqlDependency;
            dependency.OnChange -= OnDependencyChange;
            // Handle the event (for example, invalidate this cache entry).
            Console.WriteLine("THAY DOI");
            _hub.Clients.All.SendAsync("ReceiveMessage", "change");
            DEpe();
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            DEpe();
            return Task.CompletedTask;
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

    }
}