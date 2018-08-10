using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class Account
    {
        public Account()
        {
            Order = new HashSet<Order>();
        }

        public int AccountId { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public byte[] Salt { get; set; }
        public byte[] Hash { get; set; }

        public ICollection<Order> Order { get; set; }
    }
}
