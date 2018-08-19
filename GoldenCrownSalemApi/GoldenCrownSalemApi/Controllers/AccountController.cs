using System;
using System.Collections.Generic;
using System.Linq;
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
                viewModel.Token = _accountService.IssueToken(account.AccountId, _appSettings.Secret);
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
            Account account;
            AccountGetDto viewModel;
            try
            {
                account = _accountService.Authenticate(establishedAccount.UserName, establishedAccount.Password);
                viewModel = _mapper.Map<AccountGetDto>(account);
                viewModel.Token = _accountService.IssueToken(account.AccountId, _appSettings.Secret);
            }
            catch(Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }

            return Ok(viewModel);
        }


        [HttpGet]
        public IActionResult GetAccounts()
        {
            var accounts = _accountService.GetAll().ToList();
            var viewModel = new List<AccountGetDto>();

            foreach(var account in accounts)
            {
                viewModel.Add(_mapper.Map<AccountGetDto>(account));
            }

            return Ok(viewModel);
        }
        

    }
}