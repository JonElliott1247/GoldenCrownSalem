using System;
using System.Collections.Generic;
using System.Text;

namespace Tests
{
    public static class ExtensionMethods
    {
        public static IList<T> Shuffle<T>(this IList<T> list, int seed)
        {
            int n = list.Count;
            Random rnd = new Random(seed);
            while (n > 1)
            {
                int k = (rnd.Next(0, n) % n);
                n--;
                T value = list[k];
                list[k] = list[n];
                list[n] = value;
            }

            return list;
        }
    }
}
