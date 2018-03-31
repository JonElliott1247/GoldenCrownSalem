using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models
{
    public partial class MenuItemCombinationPlateItem
    {
        public int MenuItemFamilyDinnerItem { get; set; }
        public int? MenuItemId { get; set; }
        public int? CombinationPlateId { get; set; }

        public CombinationPlateItem CombinationPlate { get; set; }
        public MenuItem MenuItem { get; set; }
    }
}
