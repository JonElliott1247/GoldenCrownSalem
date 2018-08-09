using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GoldenCrownSalemApi.Models.EF_Generated_Models;

//This service was heavily inspired/loosely basically a direct copy of the UserService.cs file 
//located here https://github.com/cornflourblue/aspnet-core-registration-login-api/blob/master/Services/UserService.cs
namespace GoldenCrownSalemApi.Services
{
    public interface IAccountService
    {
        Account Authenticate(string username, string password);
        IEnumerable<Account> GetAll();
        Account GetById(int id);
        Account Create(Account user, string password);
        void Update(Account user, string password = null);
        void Delete(int id);

    }
    /*
    public class AccountService : IAccountService
    {
        private GoldenCrownSalemContext _context;

        public AccountService(GoldenCrownSalemContext context)
        {
            _context = context;
        }

        public Account Authenticate(string username, string password)
        {

            if(string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return null;
            }

            var account = _context.Account.SingleOrDefault(x => x.UserName == username);






            return null;
        }

    }
    */
}
