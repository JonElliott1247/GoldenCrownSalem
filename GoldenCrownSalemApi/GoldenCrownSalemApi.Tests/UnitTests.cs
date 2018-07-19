using NUnit.Framework;
using System.Linq;

namespace Tests
{

    [TestFixture]
    public class ApiShould
    {
        private static readonly string _url = "http://localhost:51099";
        private static readonly string _menuUrl = _url + "/api/menu";
        private static readonly string _searchMenuUrl = _menuUrl + "/search=";

        private static TestHelper _helper = new TestHelper();
        static ITestHelper Helper => _helper;

        [Test]
        public void PopulateMenuItems()
        {
            var menuItems = Helper.GetMenuItemsFromApi(_menuUrl);
            Assert.That(menuItems.Count > 0);
        }

        [Test]
        public void ContainValidMenuItems()
        {
            var menuItems = Helper.GetMenuItemsFromApi(_menuUrl).Select(item => item.Label);
            var subset = Helper.GetSubSetMenuItemsUsingContext().Select(item => item.Label);
            Assert.That(subset.Where(item => menuItems.Contains(item)).Count() == subset.Count());
        }

        [Test]
        public void PopulateMenuItemSearchResults()
        {
            string searchTerm = Helper.GetValidSearchTerm();
            //TestContext.Out.WriteLine("searchTerm : " + searchTerm);
            var menuItems = Helper.GetMenuItemsFromApi(_searchMenuUrl + searchTerm);
            Assert.That(menuItems.Count() > 0);
        }

        [Test]
        public void ContainValidMenuItemSearchResults()
        {
            string searchTerm = Helper.GetValidSearchTerm();
            var searchResults = Helper.GetMenuItemsFromApi(_searchMenuUrl + searchTerm).Select(item => item.Label);
            var filteredResults = Helper.GetMenuItemsFromApi(_menuUrl)
                                        .Where(item => item.Label.Contains(searchTerm))
                                        .Select(item => item.Label);

            bool containsAllItems = true;
            foreach(var item in searchResults)
            {
                if (!filteredResults.Contains(item))
                {
                    containsAllItems = false;
                }
            }

            Assert.That(containsAllItems && searchResults.Count() == filteredResults.Count());
        }

        [TestCase("")]
        [TestCase("sdfajgalg2efkv")]
        [TestCase("igsFJ")]
        public void ReturnNoResultsIfSearchTermIsNotValid(string searchTerm)
        {

            var searchResults = Helper.GetMenuItemsFromApi(_searchMenuUrl + searchTerm);
            Assert.That(searchResults.Count() == 0);
        }
        
    }
}