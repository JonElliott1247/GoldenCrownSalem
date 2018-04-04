using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using GoldenCrownSalemApi.Models;
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
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var config = new AutoMapper.MapperConfiguration(configuration =>
                                                                            {
                                                                                using (var context = new GoldenCrownSalemContext())
                                                                                {
                                                                                    configuration.CreateMap<MenuItem, MenuItemViewModel>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.MenuItemId))
                                                                                                                                          .ForMember(view => view.DefaultSpicyOption, opts => opts.MapFrom(item => item.DefaultSpicyOption.Label))
                                                                                                                                          .ForMember(view => view.Category, opts => opts.MapFrom(item => item.Category.Label))
                                                                                                                                          .ForMember(view => view.SubLabel, opts => opts.NullSubstitute(string.Empty))
                                                                                                                                          .ForMember(view => view.Path, opts => opts.MapFrom(
                                                                                                                                              item => item.Label.Path(item.SubLabel)));
                                                                                    configuration.CreateMap<Category, CategoryViewModel>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.CategoryId))
                                                                                                                                          .ForMember(view => view.SubLabel, opts => opts.NullSubstitute(string.Empty));
                                                                                                                                          //.ForMember(view => view.Path, opts => opts.MapFrom(item => item.Label.Path()));
                                                                                }

                                                                            });

            services.AddSingleton(config);
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
