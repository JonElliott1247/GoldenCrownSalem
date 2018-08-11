using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GoldenCrownSalemApi.Models.Entities;

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
        Account Update(Account user, string password = null);
        void Delete(int id);

    }

    public class AccountService : IAccountService
    {
        private GoldenCrownSalemContext _context;

        public AccountService(GoldenCrownSalemContext context)
        {
            _context = context;
        }

        public Account GetById(int id)
        {
            return _context.Account.Find(id);
        }

        public Account Create(Account account, string password)
        {
            //is username null?
            if(account.UserName == null)
            {
                throw new ArgumentNullException("user.UserName");
            }
            //is username empty or whitespace?
            if(string.IsNullOrEmpty(account.UserName) || string.IsNullOrEmpty(account.UserName))
            {
                throw new ArgumentException("username is empty or whitespace.");
            }

            //does account already exist?
            /*
            if (_context.Account.Any(x => x.UserName == account.UserName))
            {
                throw new Exception("Username already exists.");
            }
            */

            byte[] passwordHash, passwordSalt;
            CreatePasswordHash(password, out passwordHash, out passwordSalt);

            account.Hash = passwordHash;
            account.Salt = passwordSalt;

            _context.Account.Add(account);
            _context.SaveChanges();

            return account;

        }

        public Account Update(Account updatedAccountInformation, string password = null)
        {
            if(updatedAccountInformation == null)
            {
                throw new ArgumentNullException("updatedAccountInformation");
            }

            var account = _context.Account.Find(updatedAccountInformation.AccountId);

            //check if account exists
            if(account == null)
            {
                throw new ArgumentException($"user account {updatedAccountInformation.AccountId} does not exist.");
            }

            //update user name
            if(account.UserName != updatedAccountInformation.UserName)
            {
                if(_context.Account.Any(x => x.UserName == updatedAccountInformation.UserName))
                {
                    throw new Exception("Username already exists.");
                }

                else
                {
                    account.UserName = updatedAccountInformation.UserName;
                }
            }

            //update password if it was entered
            if( !( string.IsNullOrWhiteSpace(password) || string.IsNullOrEmpty(password) ))
            {
                byte[] passwordHash, passwordSalt;
                CreatePasswordHash(password, out passwordHash, out passwordSalt);

                account.Hash = passwordHash;
                account.Salt = passwordSalt;

            }

            _context.Account.Add(account);
            _context.SaveChanges();

            return account;
        }




        public Account Authenticate(string username, string password)
        {
            //sanity check input
            if(string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return null;
            }

            var account = _context.Account.SingleOrDefault(x => x.UserName == username);

            //check if username exists
            if(username == null)
            {
                return null;
            }

            //check password
            if(!ValidatePasswordHash(password, account.Hash, account.Salt))
            {
                return null;
            }

            // acount authenticated
            return account;
        }

        public IEnumerable<Account> GetAll()
        {
            return _context.Account;
        }
        
        //private helper methods
        private static void CreatePasswordHash(string password, out byte[] passwordHash, out byte[] passwordSalt)
        {
            if(password == null)
            {
                throw new ArgumentNullException("password");
            }

            if (string.IsNullOrWhiteSpace(password) || string.IsNullOrEmpty(password))
            {
                throw new ArgumentException("Value cannot be empty or whitespace");
            }

            using (var hmac = new System.Security.Cryptography.HMACSHA512())
            {
                passwordSalt = hmac.Key;
                passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
            }

        }

        private static bool ValidatePasswordHash(string password, byte[] recordHash, byte[] recordSalt)
        {
            //check if password is null
            if(password == null)
            {
                throw new ArgumentNullException("password");
            }

            //check if password is whitespace or empty
            if(string.IsNullOrWhiteSpace(password) || string.IsNullOrEmpty(password))
            {
                throw new ArgumentException("password is whitespace or empty.");
            }

            if(recordHash.Length != 64)
            {
                throw new ArgumentException("password hash length invalid.  (Expected 64 bytes.)");
            }

            if(recordSalt.Length != 128)
            {
                throw new ArgumentException("password salt length invalid.  (Expected 128 bytes.)");
            }

            using (var hmac = new System.Security.Cryptography.HMACSHA512(recordSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                for(int i = 0; i < computedHash.Length; i++)
                {
                    if(computedHash[i] != recordHash[i])
                    {
                        return false;
                    }
                }
            }


            return true;
        }

        public void Delete(int id)
        {
            var account = _context.Account.Find(id);
            if(account != null)
            {
                _context.Account.Remove(account);
                _context.SaveChanges();
            }
            throw new NotImplementedException();
        }
    }

}
