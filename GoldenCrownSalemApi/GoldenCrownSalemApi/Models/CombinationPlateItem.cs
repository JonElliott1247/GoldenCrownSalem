using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class CombinationPlateItem
    {
        public CombinationPlateItem()
        {
            InverseAlternate = new HashSet<CombinationPlateItem>();
            MenuItemCombinationPlateItem = new HashSet<MenuItemCombinationPlateItem>();
        }

        public int CombinationPlateItemId { get; set; }
        public string Label { get; set; }
        public string SubLabel { get; set; }
        public int? AlternateId { get; set; }
        public int? DefaultSpicyOptionId { get; set; }
        public bool IsSide { get; set; }

        public CombinationPlateItem Alternate { get; set; }
        public SpicyOption DefaultSpicyOption { get; set; }
        public ICollection<CombinationPlateItem> InverseAlternate { get; set; }
        public ICollection<MenuItemCombinationPlateItem> MenuItemCombinationPlateItem { get; set; }
    }
}
