using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models.EF_Generated_Models;
using GoldenCrownSalemApi.Models.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    public class MenuController : Controller
    {
        private readonly IMapper _mapper;
        public MenuController(MapperConfiguration mapperConfig)
        {
            _mapper = mapperConfig.CreateMapper();
        }

        // GET api/menu
        // Returns ALL menu items
        [HttpGet]
        public List<MenuItemViewModel> Get()
        {
            var list = new List<MenuItemViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Include(item => item.DefaultSpicyOption)
                                                .Include(item => item.Category).ToList();
                foreach(var menuItem in menuItems)
                {
                    var viewModel = _mapper.Map<MenuItemViewModel>(menuItem);
                    list.Add(viewModel);
                }
            }

            return list;
        }

        private List<string> Pluralize(string searchTerm)
        {
            var terms = new List<String>();
            terms.Add(searchTerm.ToLower());
            if (searchTerm[searchTerm.Length - 1] == 's')
            {
                terms.Add(searchTerm.ToLower().Substring(0, searchTerm.Length - 2));
            }
            else
            {
                terms.Add(searchTerm.ToLower() + 's');
            }

            return terms;
        }

        private bool StringContainsOneOrMore(string text, IList<string> list)
        {
            bool containsOneOrMore = false;
            foreach(var item in list)
            {
                if(text.Contains(item.Trim()))
                {
                    containsOneOrMore = true;
                }
            }
            return containsOneOrMore;
        }

        // api/menu/search=noodles
        [HttpGet("search={searchTerm}")]
        public List<MenuItemViewModel> GetSearch(string searchTerm)
        {

            var list = new List<MenuItemViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {

                var menuItems = context.MenuItem.Include(item => item.DefaultSpicyOption).Include(item => item.Category)
                                                .Where(item => StringContainsOneOrMore(item.Label.ToLower(), Pluralize(searchTerm)))
                                                .ToList();

                foreach (var item in menuItems)
                {
                    var viewModel = _mapper.Map<MenuItemViewModel>(item);
                    list.Add(viewModel);
                }

                return list;
            }
        }

        // GET api/menu/chow-mein
        [HttpGet("{path}")]
        public List<MenuItemViewModel> Get(string path)
        {
            var list = new List<MenuItemViewModel>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Include(item => item.DefaultSpicyOption).Include(item => item.Category)
                                                .Where(item => item.Category.Label.Path() == path.Trim());
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