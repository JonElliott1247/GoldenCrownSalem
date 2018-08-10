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
namespace GoldenCrownSalemApi.Controllers
{
    [Produces("application/json")]
    [Route("api/auth")]
    public class AuthenticateController : Controller
    {
        /*

        [AllowAnonymous]
        [HttpPost]
        public IActionResult RequestToken([FromBody] string userName, string password)
        {
            using (var context = new GoldenCrownSalemContext())
            {
                var user = context.Account.FirstOrDefault(account => account.Name == userName);
                if(user == null)
                {
                    return BadRequest("Could not verify username and password");
                }

                var hash = new Rfc2898DeriveBytes(password, user.Salt, 10000).GetBytes(36);
                bool validCredentials = true;
                for(int i = 0; i < user.Hash.Length; i++)
                {
                    if(hash[i] != user.Hash[i])
                    {
                        validCredentials = false;
                    }
                }

                if(validCredentials)
                {
                    var claims = new Claim[] { new Claim(ClaimTypes.Name, user.Name) };
                    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["SecurityKey"]));

                }
            }
            

            if (userName == "Jon" && password == "Again, not for production use, DEMO ONLY!")
            {
                var claims = new Claim[] { new Claim(ClaimTypes.Name, userName) };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["SecurityKey"]));
                var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                var token = new JwtSecurityToken(
                    issuer: "yourdomain.com",
                    audience: "yourdomain.com",
                    claims: claims,
                    expires: DateTime.Now.AddMinutes(30),
                    signingCredentials: creds);

                return Ok(new
                {
                    token = new JwtSecurityTokenHandler().WriteToken(token)
                });
            }
        }
        */
    }
}