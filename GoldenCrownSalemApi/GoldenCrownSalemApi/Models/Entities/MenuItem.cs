using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class MenuItem
    {
        public MenuItem()
        {
            MenuItemCombinationPlateItems = new HashSet<MenuItemCombinationPlateItem>();
            MenuItemFamilyDinnerItems = new HashSet<MenuItemFamilyDinnerItem>();
            OrderItems = new HashSet<OrderItem>();
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
        public ICollection<MenuItemCombinationPlateItem> MenuItemCombinationPlateItems { get; set; }
        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItems { get; set; }
        public ICollection<OrderItem> OrderItems { get; set; }
    }
}
