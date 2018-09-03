using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi.Models.Dtos
{
    public class AccountPostDto
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Password { get; set; } = null;
        public string Token { get; set; }
    }
}
