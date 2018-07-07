using NUnit.Framework;
using System.Net.Http;
using GoldenCrownSalemApi;
using Newtonsoft.Json;
using GoldenCrownSalemApi.Models.ViewModels;
using System.Collections.Generic;
using System;
using System.Linq;
using GoldenCrownSalemApi.Models.EF_Generated_Models;
using Microsoft.EntityFrameworkCore;

namespace Tests
{
    public interface ITestHelper
    {
        IList<MenuItemViewModel> GetMenuItemsFromApi();
        IList<MenuItem> GetSubSetMenuItemsUsingContext();
    }



    public class TestHelper : ITestHelper
    {
        private readonly string _url = "http://localhost:51099";
        private readonly GoldenCrownSalemContext _context = new GoldenCrownSalemContext();
        private readonly HttpClient _client = new HttpClient();

        public IList<MenuItemViewModel> GetMenuItemsFromApi()
        {
            string requestUrl = _url+"/api/menu";
            string menuItems = _client.GetStringAsync(requestUrl).Result;
            return JsonConvert.DeserializeObject<List<MenuItemViewModel>>(menuItems);
        }

        public IList<MenuItem> GetSubSetMenuItemsUsingContext()
        {
            int oneFifthCount = _context.MenuItem.Count() / 5;
            int randomNumber = new Random().Next(0, oneFifthCount);
            return _context.MenuItem.Where(item => item.MenuItemId % oneFifthCount == randomNumber).ToList();
        }

    }


    

    [TestFixture]
    public class ApiShould
    {
        private readonly TestHelper _helper1 = new TestHelper();
        ITestHelper Helper => _helper1;

        [Test]
        public void PopulateMenuItems()
        {
            var menuItems = Helper.GetMenuItemsFromApi();
            Assert.That(menuItems.Count > 1);
        }

        [Test]
        public void ContainValidMenuCategories()
        {
            var menuItems = Helper.GetMenuItemsFromApi().Select(item => item.Label);
            var subset = Helper.GetSubSetMenuItemsUsingContext().Select(item => item.Label);
            Assert.That(subset.Where(item => menuItems.Contains(item)).Count() == subset.Count());
        }

        /*

        [Test]
        public void PopulateMenuSearch()
        {
            var menuItems = Helper.GetMenuItemsFromApi().
        }
        */


        /*
        [Test]
        public void ContainValidMenuItems()
        {
            var MenuItems = GetSubSetCategoriesWithMenuItems();
            var 

        }
        */

        
    }
}