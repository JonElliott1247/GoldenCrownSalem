using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.EF_Generated_Models
{
    public partial class Order
    {
        public Order()
        {
            OrderItem = new HashSet<OrderItem>();
        }

        public int OrderId { get; set; }
        public int AccountId { get; set; }
        public decimal? SubTotal { get; set; }
        public decimal Tip { get; set; }

        public Account Account { get; set; }
        public ICollection<OrderItem> OrderItem { get; set; }
    }
}
