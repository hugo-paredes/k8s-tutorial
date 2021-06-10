using System;

namespace k8s.api.Models
{
    public class Ping
    {
        public string Message { get { return "I'm alive";} }
        public string Now { get { return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff");} }
    }
}
