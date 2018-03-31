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
        public string SubLabel { get; set; }
        public string Path { get; set; }

        public ICollection<MenuItem> MenuItem { get; set; }
    }
}
