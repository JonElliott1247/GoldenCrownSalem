﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/menu")]
    public class MenuController : Controller
    {
        private readonly IMapper _mapper;
        public MenuController(IMapper mapper)
        {
            _mapper = mapper;
        }
        // GET api/menu/chow-mein
        [HttpGet("{path}")]
        public List<MenuItemViewModel> Get(string path)
        {
            var list = new List<MenuItemViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Where(item => item.Category.Path.Trim() == path.Trim());
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