using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class MenuItemFamilyDinnerItem
    {
        public int MenuItemFamilyDinnerItemId { get; set; }
        public int MenuItemId { get; set; }
        public int FamilyDinnerItemId { get; set; }
        public bool IsSpecial { get; set; }
        public bool IsAppetizer { get; set; }
        public bool IsEntree { get; set; }

        public FamilyDinnerItem FamilyDinnerItem { get; set; }
        public MenuItem MenuItem { get; set; }
    }
}
