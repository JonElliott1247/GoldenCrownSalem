using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.EF_Generated_Models
{
    public partial class OrderItem
    {
        public int OrderItemId { get; set; }
        public int MenuItemId { get; set; }
        public int OrderId { get; set; }
        public int Quantity { get; set; }
        public decimal? SubTotal { get; set; }

        public MenuItem MenuItem { get; set; }
        public Order Order { get; set; }
    }
}
