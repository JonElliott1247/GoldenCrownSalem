using NUnit.Framework;
using System.Net.Http;
using GoldenCrownSalemApi;
using Newtonsoft.Json;
using GoldenCrownSalemApi.Models.ViewModels;
using System.Collections.Generic;
using System;
using System.Linq;

namespace Tests
{
    [TestFixture]
    public class ApiShould
    {
        //Run GoldenCrownSalemApi project first and change this out with the port number ISS Express choses.
        private static readonly int _portNumber = 51075;
        private static readonly HttpClient client = new HttpClient();

        private List<CategoryViewModel> GetCategoryViewModels()
        {
            string requestUrl = $"http://localhost:{_portNumber}/api/menu";
            string menuCategoriesResponse = client.GetStringAsync(requestUrl).Result;
            return JsonConvert.DeserializeObject<List<CategoryViewModel>>(menuCategoriesResponse);
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
        public void ContainsValidMenuCategories()
        {
            var menuCategories = GetCategoryViewModels();
            var sampleCategories = new List<string> { "Appetizers", "Soups", "Beef" };
            Assert.That(menuCategories.Where(item => sampleCategories.Contains(item.Label)).Count() == 3);
        }
        
    }
}