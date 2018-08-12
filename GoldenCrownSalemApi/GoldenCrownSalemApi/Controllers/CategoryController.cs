using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models.Entities;
using GoldenCrownSalemApi.Models.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/categories")]
    public class CategoryController : Controller
    {
        private readonly IMapper _mapper;
        public CategoryController(MapperConfiguration mapperConfig)
        {
            _mapper = mapperConfig.CreateMapper();
        }

        // GET api/menu
        // Returns ALL menu items
        [HttpGet]
        public List<CategoryDto> Get()
        {
            var list = new List<CategoryDto>();
            using (var context = new GoldenCrownSalemContext())
            {
                var categories = context.Categories;
                foreach (var category in categories)
                {
                    var viewModel = _mapper.Map<CategoryDto>(category);
                    list.Add(viewModel);
                }
            }

            return list;
        }

    }
}