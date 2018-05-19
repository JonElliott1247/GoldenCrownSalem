using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.EF_Generated_Models
{
    public partial class MenuItemCombinationPlateItem
    {
        public int MenuItemFamilyDinnerItemId { get; set; }
        public int? MenuItemId { get; set; }
        public int? CombinationPlateItemId { get; set; }

        public CombinationPlateItem CombinationPlateItem { get; set; }
        public MenuItem MenuItem { get; set; }
    }
}
