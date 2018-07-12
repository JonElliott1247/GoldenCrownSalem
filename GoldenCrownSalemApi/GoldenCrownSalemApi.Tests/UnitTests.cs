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
        IList<MenuItemViewModel> GetMenuItemsFromApi(string requestUrl);
        IList<MenuItem> GetSubSetMenuItemsUsingContext();
        MenuItem GetRandomMenuItemFromContext();
        string GetValidSearchTerm();
    }

    public static class ExtensionMethods
    {
        public static IList<T> Shuffle<T>(this IList<T> list)
        {
            int n = list.Count;
            Random rnd = new Random();
            while (n > 1)
            {
                int k = (rnd.Next(0, n) % n);
                n--;
                T value = list[k];
                list[k] = list[n];
                list[n] = value;
            }

            return list;
    }
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
            var list = _context.MenuItem.ToList().Shuffle();
            int oneFith = list.Count() / 5;
            return list.Take(oneFith).ToList();
        }

        public MenuItem GetRandomMenuItemFromContext()
        {
            var list = _context.MenuItem.ToList();
            int randomNumber = new Random().Next(0, list.Count());
            return list[randomNumber];
        }

        public string GetValidSearchTerm()
        {
            string[] terms = GetRandomMenuItemFromContext().Label.Trim().Split(" ");
            int randomNumber = new Random().Next(0, terms.Length);
            return terms[randomNumber];
        }
    }


    

    [TestFixture]
    public class ApiShould
    {
        private static readonly string _url = "http://localhost:51099";
        private static readonly string _menuUrl = _url + "/api/menu";
        private static readonly string _searchMenuUrl = _menuUrl + "/search=";

        private readonly TestHelper _helper1 = new TestHelper();
        ITestHelper Helper => _helper1;

        [Test]
        public void PopulateMenuItems()
        {
            var menuItems = Helper.GetMenuItemsFromApi(_menuUrl);
            Assert.That(menuItems.Count > 0);
        }

        [Test]
        public void ContainValidMenuCategories()
        {
            var menuItems = Helper.GetMenuItemsFromApi(_menuUrl).Select(item => item.Label);
            var subset = Helper.GetSubSetMenuItemsUsingContext().Select(item => item.Label);
            Assert.That(subset.Where(item => menuItems.Contains(item)).Count() == subset.Count());
        }

        [Test]
        public void PopulateMenuItemSearch()
        {
            string searchTerm = Helper.GetValidSearchTerm();
            //TestContext.Out.WriteLine("searchTerm : " + searchTerm);
            var menuItems = Helper.GetMenuItemsFromApi(_searchMenuUrl + searchTerm);
            Assert.That(menuItems.Count() > 0);
        }

        [Test]
        public void CompletelyPopulateMenuItemSearch()
        {
            string searchTerm = "chicken";
            var menuItems = Helper.GetMenuItemsFromApi(_searchMenuUrl + searchTerm).Select(item => item.Label);
            var subset = Helper.GetMenuItemsFromApi(_menuUrl).Where(item => item.Label.Contains(searchTerm)).Select(item => item.Label);
            
            foreach(var item in subset)
            {
                System.Diagnostics.Debug.WriteLine(item);
                Assert.That(menuItems.Contains(item));
            }
        }


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