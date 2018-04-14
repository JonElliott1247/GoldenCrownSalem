using GoldenCrownSalemApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GoldenCrownSalemApi
{
    public static class ExtensionMethods
    {
        public static string Path(this string label)
        {
            char[] charArray = label.Trim().ToCharArray();
            charArray = Array.FindAll<char>(charArray, (c => (char.IsLetterOrDigit(c) || c == ' ' || c == '-')));
            var path = new string(charArray).Replace(' ', '-').ToLower();
            return path;
        }

        public static string Path(this string label, string subLabel)
        {
            var subPath = subLabel != null ? '/' +subLabel.Path() : "";
            var path = $"{label.Path()}{subPath}";
            return path;
        }
    }
}
