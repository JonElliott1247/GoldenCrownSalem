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
    public static class TestHelper
    {
        private static readonly string _url = "http://localhost:51099";
        private static readonly GoldenCrownSalemContext _context = new GoldenCrownSalemContext();
        private static readonly HttpClient _client = new HttpClient();

        public static IList<CategoryViewModel> GetCategoryViewModelsFromApi()
        {
            string requestUrl = _url+"/api/menu";
            string menuCategoriesResponse = _client.GetStringAsync(requestUrl).Result;
            return JsonConvert.DeserializeObject<List<CategoryViewModel>>(menuCategoriesResponse);
        }

        public static IList<Category> GetSubSetCategoriesWithMenuItemsUsingContext()
        {
            int oneFifthCategoryCount = _context.Category.Count() / 5;
            int randomNumber = new Random().Next(0, oneFifthCategoryCount);
            return _context.Category.Where(item => item.CategoryId % oneFifthCategoryCount == randomNumber)
                                             .Include(item => item.MenuItem).ToList();
        }

        public static GoldenCrownSalemContext Context() { return _context; }



    }



    [TestFixture]
    public class ApiShould
    {

        [Test]
        public void PopulateMenuCategories()
        {
            var menuCategories = TestHelper.GetCategoryViewModelsFromApi();
            Assert.That(menuCategories.Count > 1);
        }



        [Test]
        public void ContainValidMenuCategories()
        {
            var menuCategories = TestHelper.GetCategoryViewModelsFromApi();
            var categoryNames = TestHelper.Context().Category.Select(cat => cat.Label).ToList();
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