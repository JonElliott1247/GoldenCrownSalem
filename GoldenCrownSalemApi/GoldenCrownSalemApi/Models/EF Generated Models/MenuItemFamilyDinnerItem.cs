using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class MenuItemFamilyDinnerItem
    {
        public int MenuItemFamilyDinnerItemId { get; set; }
        public int MenuItemId { get; set; }
        public int FamilyDinnerItemId { get; set; }
        public int DefaultSpicyOptionId { get; set; }
        public bool IsSpecial { get; set; }

        public SpicyOption DefaultSpicyOption { get; set; }
        public FamilyDinnerItem FamilyDinnerItem { get; set; }
        public MenuItem MenuItem { get; set; }
    }
}
