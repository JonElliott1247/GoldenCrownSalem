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
        [HttpGet("{label}")]
        public List<string[]> Get(string label)
        {
            var list = new List<string[]>();
            using (var context = new GoldenCrownSalemContext())
            {
                var menuItems = context.MenuItem.Where(item => item.Category.Label.Trim() == LabelDeserializer(label));
                foreach(var item in menuItems)
                {
                    list.Add(new string[] { item.Label, item.SubLabel });
                }

            }
            return list;
        }

        private string LabelDeserializer(string label)
        {
            var labelParts = label.Split('-');
            var key = new StringBuilder();
        
            foreach(var part in labelParts)
            {
                key.Append(part.Substring(0, 1).ToUpper());
                key.Append($"{part.Substring(1, part.Length - 1)} ");
            }
            return key.ToString().Trim();
        }


    }
}