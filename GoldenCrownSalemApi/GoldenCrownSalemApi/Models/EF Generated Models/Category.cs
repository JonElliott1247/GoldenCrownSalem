using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class Category
    {
        public Category()
        {
            MenuItem = new HashSet<MenuItem>();
        }

        public int CategoryId { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }

        public ICollection<MenuItem> MenuItem { get; set; }
    }
}
