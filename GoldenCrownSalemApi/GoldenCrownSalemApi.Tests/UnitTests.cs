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
    [TestFixture]
    public class ApiShould
    {
        //Run GoldenCrownSalemApi project first and change this out with the port number ISS Express choses.
        private static readonly int _portNumber = 51074;
        private static readonly GoldenCrownSalemContext _context = new GoldenCrownSalemContext();
        private static readonly HttpClient _client = new HttpClient();

        private List<CategoryViewModel> GetCategoryViewModels()
        {
            string requestUrl = $"http://localhost:{_portNumber}/api/menu";
            string menuCategoriesResponse = _client.GetStringAsync(requestUrl).Result;
            return JsonConvert.DeserializeObject<List<CategoryViewModel>>(menuCategoriesResponse);
        }

        private List<Category> GetSubSetCategoriesWithMenuItems()
        {
            int oneFifthCategoryCount = _context.Category.Count() / 5;
            int randomNumber = new Random().Next(0, oneFifthCategoryCount);
            return _context.Category.Where(item => item.CategoryId % oneFifthCategoryCount == randomNumber)
                                             .Include(item => item.MenuItem).ToList();
        }

        /********************************************************************************************
         * All tests will fail if GoldenCrownSalemApi is not running and _portNumber is not the     *
         * correct port number ISS Express choses to run your project on.                           *
         *******************************************************************************************/
        [Test]
        public void PopulateMenuCategories()
        {
            var menuCategories = GetCategoryViewModels();
            Assert.That(menuCategories.Count > 1);
        }

        [Test]
        public void ContainValidMenuCategories()
        {
            var menuCategories = GetCategoryViewModels();
            var categoryNames = _context.Category.Select(cat => cat.Label).ToList();
            Assert.That(menuCategories.Where(item => categoryNames.Contains(item.Label)).Count() == categoryNames.Count);
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