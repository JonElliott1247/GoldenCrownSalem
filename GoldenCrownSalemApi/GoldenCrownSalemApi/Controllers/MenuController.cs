using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GoldenCrownSalemApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/menu")]
    public class MenuController : Controller
    {
        // GET api/menu/chow-mein
        [HttpGet("{path}")]
        public List<string[]> Get(string path)
        {
            var list = new List<string[]>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Where(item => item.Category.Path.Trim() == path.Trim());
                foreach(var item in menuItems)
                {
                    list.Add(new string[] {item.Label, item.SubLabel });
                }

            }
            return list;
        }

    }
}