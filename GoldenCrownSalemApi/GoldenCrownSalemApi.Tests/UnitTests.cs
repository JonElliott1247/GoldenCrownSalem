using GoldenCrownSalemApi.Models.Entities;
using Moq;
using NUnit.Framework;
using System.Linq;
using System.Collections.Generic;
using System;

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

        /*
        [Test]
        public void CanCreateNewAccount(Account account)
        {
            var mockedDbContext = new Mock<GoldenCrownSalemContext>();
            List<string> passwords = new List<string> { "password1", "password2", "password3" };

            List<(byte[], byte[])> saltsAndHashes = new List<(byte[], byte[])>();
            foreach(var password in passwords)
            {
                byte[] passwordSalt, passwordHash;
                using (var hmac = new System.Security.Cryptography.HMACSHA512())
                {
                    passwordSalt = hmac.Key;
                    passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                }
                saltsAndHashes.Add((passwordSalt, passwordHash));
            }

            var accounts = new List<Account>();
            int count = 1;
            foreach(var saltAndHash in saltsAndHashes)
            {
                accounts.Add(new Account { AccountId = count++, FirstName = 'Joe', LastName = 'Frank',
                                           Salt = saltAndHash.Item1, Hash = saltAndHash.Item2, UserName =" });
            }

            mockedDbContext.Setup(x => x.Account = accounts.AsQueryable<Account>);
        }
        */
        
    }
}