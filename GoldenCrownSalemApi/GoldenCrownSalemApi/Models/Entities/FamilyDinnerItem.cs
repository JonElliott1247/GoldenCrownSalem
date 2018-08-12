using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class FamilyDinnerItem
    {
        public FamilyDinnerItem()
        {
            MenuItemFamilyDinnerItems = new HashSet<MenuItemFamilyDinnerItem>();
        }

        public int FamilyDinnerItemId { get; set; }
        public string Label { get; set; }
        public int DefaultSpicyOptionId { get; set; }

        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItems { get; set; }
    }
}
