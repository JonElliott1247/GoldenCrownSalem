using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class Category
    {
        public Category()
        {
            MenuItems = new HashSet<MenuItem>();
        }

        public int CategoryId { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }

        public ICollection<MenuItem> MenuItems { get; set; }
    }
}
