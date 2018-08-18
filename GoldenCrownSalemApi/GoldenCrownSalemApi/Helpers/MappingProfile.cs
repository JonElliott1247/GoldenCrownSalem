using AutoMapper;
using GoldenCrownSalemApi.Models.Dtos;
using GoldenCrownSalemApi.Models.Entities;
using GoldenCrownSalemApi.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi.Helpers
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        { 

            CreateMap<MenuItem, MenuItemDto>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.MenuItemId))
                .ForMember(view => view.DefaultSpicyOption, opts => opts.MapFrom(item => item.DefaultSpicyOption.Label))
                .ForMember(view => view.Category, opts => opts.MapFrom(item => item.Category.Label))
                .ForMember(view => view.SubLabel, opts => opts.NullSubstitute(string.Empty))
                .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                .ForMember(view => view.DefaultSpicyOption, opts => opts.NullSubstitute(string.Empty))
                .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" + item.Category.Label.Path() +'/' + item.Label.Path(item.SubLabel)));

            CreateMap<Category, CategoryDto>().ForMember(view => view.Id, opts => opts.MapFrom(item => item.CategoryId))
                                                                            .ForMember(view => view.Description, opts => opts.NullSubstitute(string.Empty))
                                                                            .ForMember(view => view.Path, opts => opts.MapFrom(item => "/menu/" + item.Label.Path()));

            CreateMap<Account, AccountPostDto>().ReverseMap();
            CreateMap<Account, AccountGetDto>().ForMember(x => x.AccountId, opt => opt.Ignore());
            CreateMap<AccountGetDto, AccountPostDto>().ReverseMap();
        }
    }
}
