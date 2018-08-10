using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models.EF_Generated_Models;
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
        public List<CategoryViewModel> Get()
        {
            var list = new List<CategoryViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var categories = context.Category;
                foreach (var category in categories)
                {
                    var viewModel = _mapper.Map<CategoryViewModel>(category);
                    list.Add(viewModel);
                }
            }

            return list;
        }

    }
}