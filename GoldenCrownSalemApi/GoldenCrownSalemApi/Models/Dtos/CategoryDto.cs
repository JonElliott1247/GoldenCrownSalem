using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi.Models.Dtos
{
    public class CategoryDto
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string Path { get; set; }
    }
}
