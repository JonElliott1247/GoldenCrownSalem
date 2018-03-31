using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class SpicyOption
    {
        public SpicyOption()
        {
            CombinationPlateItem = new HashSet<CombinationPlateItem>();
            MenuItem = new HashSet<MenuItem>();
            MenuItemFamilyDinnerItem = new HashSet<MenuItemFamilyDinnerItem>();
        }

        public int SpicyOptionId { get; set; }
        public string Label { get; set; }

        public ICollection<CombinationPlateItem> CombinationPlateItem { get; set; }
        public ICollection<MenuItem> MenuItem { get; set; }
        public ICollection<MenuItemFamilyDinnerItem> MenuItemFamilyDinnerItem { get; set; }
    }
}
