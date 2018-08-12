using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using GoldenCrownSalemApi.Models.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.Configuration;
using GoldenCrownSalemApi.Services;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/auth")]
    public class AuthenticateController : Controller
    {
        /*
        private readonly GoldenCrownSalemContext _context;

        public AuthenticateController(GoldenCrownSalemContext context)
        {
            _context = context;
        }
        */

        /*
        [HttpGet]
        public List<Account> GetAccounts()
        {
            var accounts = new List<Account>(); 
            using (var context = new GoldenCrownSalemContext())
            {
                accounts = context.Account.ToList();
            }
            return accounts;
        }
        */

        [HttpGet]
        public Account Create(string username, string password)
        {
            var account = new Account() { UserName = username, FirstName="jon", LastName = "elliott" };
            AccountService accountService;
            using (var context = new GoldenCrownSalemContext())
            {
                try
                {
                    accountService = new AccountService(context);
                    account = accountService.Create(account, password);
                }

                catch(Exception)
                {
                    return null;
                }
            }

            return account;
        }
    }
}