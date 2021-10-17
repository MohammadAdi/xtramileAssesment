using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AssessmentTest.Model
{
    public class Countries
    {
        public string Country { get; set; }

        public List<string> Cities { get; set; }
    }

    public class CountriesResponse
    {
        public bool Error { get; set; }

        public string Msg { get; set; }

        public List<Countries> Data { get; set; }
    }
}
