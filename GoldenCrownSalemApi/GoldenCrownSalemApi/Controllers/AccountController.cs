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
        private readonly IAccountService _accountService;
        private readonly IMapper _mapper;
        private readonly AppSettings _appSettings;

        //GoldenCrownSalemContext context, 
        public AccountController(IMapper mapper, IAccountService accountService, IOptions<AppSettings> appSettings)
        {
            //_context = context;
            _mapper = mapper;
            _accountService = accountService;
            _appSettings = appSettings.Value;

        }


        [HttpPost("create")]
        public IActionResult Create(AccountPostDto newAccount)
        {
            Account account;
            AccountGetDto viewModel;
            try
            {
                account = _mapper.Map<Account>(newAccount);
                var password = newAccount.Password;
                _accountService.Create(account, password);
   
                viewModel = _mapper.Map<AccountGetDto>(account); 
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }

            return Ok(viewModel);
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate(AccountPostDto establishedAccount)
        {
            var account = _accountService.Authenticate(establishedAccount.UserName, establishedAccount.Password);

            if (account == null)
            {
                return BadRequest(new { message = "Could not authenticate.  Are you sure the username and/or password are correct?" });
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, account.AccountId.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            // return user information without password and token
            var viewModel = _mapper.Map<AccountGetDto>(account);
            viewModel.Token = tokenString;

            return Ok(viewModel);
        }


        [HttpGet]
        public IActionResult GetAccounts()
        {
            var accounts = _accountService.GetAll().ToList();
            var viewModel = new List<AccountGetDto>();
            /*
            foreach(var account in accounts)
            {
                viewModel.Add(_mapper.Map<AccountGetDto>(account));
            }

            return Ok(viewModel);
            */
            return Ok(accounts);
        }
        

    }
}