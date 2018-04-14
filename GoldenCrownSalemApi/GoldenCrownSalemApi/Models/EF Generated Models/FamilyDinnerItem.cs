using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class FamilyDinnerItem
    {
        public FamilyDinnerItem()
        {
            MenuItemFamilyDinnerItem = new HashSet<MenuItemFamilyDinnerItem>();
        }

        public int FamilyDinnerItemId { get; set; }
        public string Label { get; set; }
        public int DefaultSpicyOptionId { get; set; }

        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
    }
}
