using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models.EF_Generated_Models;
using GoldenCrownSalemApi.Models.ViewModels;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;


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
                    config.CreateMap<MenuItem, MenuItemViewModel>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.MenuItemId))
                                                                            .ForMember(view => view.DefaultSpicyOption, opts => opts.MapFrom(item => item.DefaultSpicyOption.Label))
                                                                            .ForMember(view => view.Category, opts => opts.MapFrom(item => item.Category.Label))
                                                                            .ForMember(view => view.SubLabel, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.DefaultSpicyOption, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" + item.Category.Label.Path() +'/' + item.Label.Path(item.SubLabel)));

                    config.CreateMap<Category, CategoryViewModel>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.CategoryId))
                                                                            .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" +item.Label.Path()));
                }

            });

            services.AddSingleton(mapperConfiguration);
            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseMvc();
        }
    }
}
