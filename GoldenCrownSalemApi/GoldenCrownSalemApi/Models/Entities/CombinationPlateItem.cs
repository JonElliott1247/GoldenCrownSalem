using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class CombinationPlateItem
    {
        public CombinationPlateItem()
        {
            MenuItemCombinationPlateItems = new HashSet<MenuItemCombinationPlateItem>();
        }

        public int CombinationPlateItemId { get; set; }
        public string Label { get; set; }
        public int? DefaultSpicyOptionId { get; set; }

        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<MenuItemCombinationPlateItem> MenuItemCombinationPlateItems { get; set; }
    }
}
