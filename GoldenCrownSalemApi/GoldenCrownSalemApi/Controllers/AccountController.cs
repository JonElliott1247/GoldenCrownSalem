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
using AutoMapper;
using Microsoft.Extensions.Options;
using GoldenCrownSalemApi.Models.Dtos;

namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/auth")]
    public class AccountController : Controller
    {
        
        //private readonly GoldenCrownSalemContext _context;
        private IAccountService _accountService;
        private IMapper _mapper;
        private readonly AppSettings _appSettings;

        //GoldenCrownSalemContext context, 
        public AccountController(IMapper mapper, IAccountService accountService, IOptions<AppSettings> appSettings)
        {
            //_context = context;
            _mapper = mapper;
            _accountService = accountService;
            _appSettings = appSettings.Value;

        }


        [HttpPost]
        public Account Create(AccountPostDto newAccount)
        {
            var account = _mapper.Map<Account>(newAccount);
            var password = newAccount.Password;
            account = _accountService.Create(account, password);
            return account;
        }

                

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


    }
}