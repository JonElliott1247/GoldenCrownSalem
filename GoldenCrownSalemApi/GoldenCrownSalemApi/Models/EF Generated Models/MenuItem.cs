using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.EF_Generated_Models
{
    public partial class MenuItem
    {
        public MenuItem()
        {
            MenuItemCombinationPlateItem = new HashSet<MenuItemCombinationPlateItem>();
            MenuItemFamilyDinnerItem = new HashSet<MenuItemFamilyDinnerItem>();
            OrderItem = new HashSet<OrderItem>();
        }

        public int MenuItemId { get; set; }
        public string Label { get; set; }
        public string SubLabel { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public bool IsAvailable { get; set; }
        public int CategoryId { get; set; }
        public int? DefaultSpicyOptionId { get; set; }

        public Category Category { get; set; }
        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<MenuItemCombinationPlateItem> MenuItemCombinationPlateItem { get; set; }
        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
        public ICollection<OrderItem> OrderItem { get; set; }
    }
}
