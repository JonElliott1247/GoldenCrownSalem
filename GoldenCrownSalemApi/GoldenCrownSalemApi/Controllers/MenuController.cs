using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/menu")]
    public class MenuController : Controller
    {
        private readonly IMapper _mapper;
        public MenuController(MapperConfiguration config)
        {
            _mapper = config.CreateMapper();
        }

        // GET api/menu
        [HttpGet]
        public List<CategoryViewModel> Get()
        {
            var list = new List<CategoryViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var categories = context.Category.ToList();
                foreach(var category in categories)
                {
                    var viewModel = _mapper.Map<CategoryViewModel>(category);
                    list.Add(viewModel);
                }
            }

            return list;
        }

        // GET api/menu/chow-mein
        [HttpGet("{path}")]
        public List<MenuItemViewModel> Get(string path)
        {
            var list = new List<MenuItemViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Include(item => item.DefaultSpicyOption).Include(item => item.Category)
                                                .Where(item => item.Category.Path.Trim() == path.Trim());
                foreach(var item in menuItems)
                {
                    var viewModel = _mapper.Map<MenuItemViewModel>(item);
                    list.Add(viewModel);
                }

            }
            return list;
        }

    }
}