﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi.Models.ViewModels
{
    public class CategoryViewModel
    {
        public int Id { get; set; }
        public string Label { get; set; }
        public string Description { get; set; }
        public string Path { get; set; }
    }
}
