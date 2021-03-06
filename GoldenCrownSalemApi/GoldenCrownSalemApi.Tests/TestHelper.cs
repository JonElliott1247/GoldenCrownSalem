﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using Newtonsoft.Json;
using GoldenCrownSalemApi.Models.EF_Generated_Models;
using GoldenCrownSalemApi.Models.ViewModels;


namespace Tests
{
    

    public interface ITestHelper
    {
        IList<MenuItemViewModel> GetMenuItemsFromApi(string requestUrl);
        IList<MenuItem> GetSubSetMenuItemsUsingContext();
        MenuItem GetRandomMenuItemFromContext();
        string GetValidSearchTerm();
    }

    public class TestHelper : ITestHelper
    {
        private readonly string _url = "http://localhost:51099";
        private readonly GoldenCrownSalemContext _context = new GoldenCrownSalemContext();
        private readonly HttpClient _client = new HttpClient();

        public IList<MenuItemViewModel> GetMenuItemsFromApi(string requestUrl)
        {
            string menuItemsJson = _client.GetStringAsync(requestUrl).Result;
            var menuItems = JsonConvert.DeserializeObject<IList<MenuItemViewModel>>(menuItemsJson);
            return menuItems;
        }

        public IList<MenuItem> GetSubSetMenuItemsUsingContext()
        {
            var list = _context.MenuItem.ToList().Shuffle(DateTime.Now.Millisecond);
            int oneFifth = list.Count() / 5;
            return list.Take(oneFifth).ToList();
        }

        public MenuItem GetRandomMenuItemFromContext()
        {
            var items = _context.MenuItem.ToList().Shuffle(DateTime.Now.Millisecond);
            return items.First();
        }

        public string GetValidSearchTerm()
        {
            IList<string> terms = GetRandomMenuItemFromContext().Label.Trim().Split(" ").Shuffle(DateTime.Now.Millisecond);
            return terms.First();
        }
    }


}
