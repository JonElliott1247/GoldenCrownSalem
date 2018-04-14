using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi.Models
{
    public class MenuItemViewModel
    {
        public int Id { get; set; }
        public string Label { get; set; }
        public string SubLabel { get; set; }
        public decimal Price { get; set; }
        public bool IsAvailable { get; set; }
        public string Category { get; set; }
        public string DefaultSpicyOption { get; set; }
        public string Path { get; set; }
    }
}
