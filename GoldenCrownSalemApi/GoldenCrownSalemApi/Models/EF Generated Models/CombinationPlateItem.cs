using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class CombinationPlateItem
    {
        public CombinationPlateItem()
        {
            MenuItemCombinationPlateItem = new HashSet<MenuItemCombinationPlateItem>();
        }

        public int CombinationPlateItemId { get; set; }
        public string Label { get; set; }
        public int? DefaultSpicyOptionId { get; set; }

        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<MenuItemCombinationPlateItem> MenuItemCombinationPlateItem { get; set; }
    }
}
