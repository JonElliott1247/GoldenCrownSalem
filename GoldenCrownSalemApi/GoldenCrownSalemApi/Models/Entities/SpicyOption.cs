using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class SpicyOption
    {
        public SpicyOption()
        {
            CombinationPlateItems = new HashSet<CombinationPlateItem>();
            FamilyDinnerItems = new HashSet<FamilyDinnerItem>();
            MenuItems = new HashSet<MenuItem>();
        }

        public int SpicyOptionId { get; set; }
        public string Label { get; set; }

        public ICollection<CombinationPlateItem> CombinationPlateItems { get; set; }
        public ICollection<FamilyDinnerItem> FamilyDinnerItems { get; set; }
        public ICollection<MenuItem> MenuItems { get; set; }
    }
}
