using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Diagnostics;
using System.Threading.Tasks;

namespace db_a27401_asp
{
    public class MyHub1 : Hub
    {
        private readonly static ConnectionMapping<string> _connections =
            new ConnectionMapping<string>();
        public void BroadcastStatus(String UserName, String StatusStirng)
        {
            Clients.All.UpdateStatusToAll(UserName,StatusStirng);
        }
        public void broadcastMessage(string userFrom,string userTo, string MessageStirng)
        {
            /*List<String> ConnectionIDs = new List<string>();
            ConnectionIDs.Add(UserNameTo);
            ConnectionIDs.Add(userNameFrom);*/
            //string name = Context.User.Identity.Name;
            //string conid = Context.ConnectionId.ToString();
            Debug.WriteLine(userTo);
            //Debug.WriteLine(conid);

            //Clients.All.updateMessage(userTo, MessageStirng);
            foreach (var connectionId in _connections.GetConnections(userTo))
            {
                Debug.WriteLine(connectionId);
                Clients.Client(connectionId).updateMessage(userFrom, MessageStirng);
            }
        }

        public override Task OnConnected()
        {
            string userClient = Context.QueryString["userName"];
            Debug.WriteLine("username OnConnected: "+userClient);
            Debug.WriteLine(Context.ConnectionId.ToString());
            
            _connections.Add(userClient, Context.ConnectionId);
            return base.OnConnected();
        }

        public override Task OnDisconnected()
        {
            string userClient = Context.QueryString["userName"];
            Debug.WriteLine("username OnDisconnected: " + userClient);
            Debug.WriteLine(Context.ConnectionId.ToString());
            _connections.Remove(userClient, Context.ConnectionId);            
            return base.OnDisconnected();
        }

        public override Task OnReconnected()
        {
            string userClient = Context.QueryString["userName"];
            Debug.WriteLine("username OnReconnected: " + userClient);
            Debug.WriteLine(Context.ConnectionId.ToString());

            if (!_connections.GetConnections(userClient).Contains(Context.ConnectionId))
            {
                _connections.Add(userClient, Context.ConnectionId);
            }

            return base.OnReconnected();
        }
    }
}