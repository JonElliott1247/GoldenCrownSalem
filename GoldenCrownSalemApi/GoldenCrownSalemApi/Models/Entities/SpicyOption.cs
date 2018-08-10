using System;
using System.Collections.Generic;

namespace GoldenCrownSalemApi.Models.Entities
{
    public partial class SpicyOption
    {
        public SpicyOption()
        {
            CombinationPlateItem = new HashSet<CombinationPlateItem>();
            FamilyDinnerItem = new HashSet<FamilyDinnerItem>();
            MenuItem = new HashSet<MenuItem>();
        }

        public int SpicyOptionId { get; set; }
        public string Label { get; set; }

        public ICollection<CombinationPlateItem> CombinationPlateItem { get; set; }
        public ICollection<FamilyDinnerItem> FamilyDinnerItem { get; set; }
        public ICollection<MenuItem> MenuItem { get; set; }
    }
}
