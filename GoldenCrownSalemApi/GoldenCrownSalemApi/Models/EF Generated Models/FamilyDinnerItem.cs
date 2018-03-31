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

        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
    }
}
