using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models.Entities;
using GoldenCrownSalemApi.Models.Dtos;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using System.Text;
using GoldenCrownSalemApi.Services;

namespace GoldenCrownSalemApi
{
    public class Startup
    {
        private readonly IConfiguration _configuration;

        public Startup(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var mapperConfiguration = new AutoMapper.MapperConfiguration(config =>
            {
                using (var context = new GoldenCrownSalemContext())
                {
                    config.CreateMap<MenuItem, MenuItemDto>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.MenuItemId))
                                                                            .ForMember(view => view.DefaultSpicyOption, opts => opts.MapFrom(item => item.DefaultSpicyOption.Label))
                                                                            .ForMember(view => view.Category, opts => opts.MapFrom(item => item.Category.Label))
                                                                            .ForMember(view => view.SubLabel, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.DefaultSpicyOption, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" + item.Category.Label.Path() +'/' + item.Label.Path(item.SubLabel)));

                    config.CreateMap<Category, CategoryDto>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.CategoryId))
                                                                            .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" +item.Label.Path()));
                }

            });
            services.AddCors();
            services.AddSingleton(mapperConfiguration);
            services.AddMvc();
            services.AddScoped<IAccountService, AccountService>();


            // configure strongly typed settings objects
            
            var appSettingsSection = _configuration.GetSection("AppSettings");
            services.Configure<AppSettings>(appSettingsSection);

            // configure jwt authentication
            var appSettings = appSettingsSection.Get<AppSettings>();
            var key = Encoding.ASCII.GetBytes(appSettings.Secret);


            services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(x =>
            {
                x.Events = new JwtBearerEvents
                {
                    OnTokenValidated = context =>
                    {
                        var accountService = context.HttpContext.RequestServices.GetRequiredService<IAccountService>();
                        var accountId = int.Parse(context.Principal.Identity.Name);
                        var account = accountService.GetById(accountId);
                        if (account == null)
                        {
                                        // return unauthorized if user no longer exists
                                        context.Fail("Unauthorized");
                        }
                        return Task.CompletedTask;
                    }
                };
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };
            });
            
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }


            app.UseCors(builder => builder.WithOrigins("http://localhost:3000").AllowAnyHeader());
            app.UseMvc();
        }
    }
}
