using AssessmentTest.Model;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Threading.Tasks;

namespace AssessmentTest.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        [HttpGet]
        [Route("GetCityWeather")]
        public async Task<IActionResult> GetCityWeather(string city)
        {
            try
            {
                var client = new RestClient("http://api.openweathermap.org/data/2.5");
                var request = new RestRequest("weather", Method.GET, DataFormat.Json);
                request.AddParameter("q", city);
                request.AddParameter("appid", "bcba6d8f9072c18310cac8c3fb3bbea8");
                var response = await client.ExecuteAsync(request);
                var result = JsonConvert.DeserializeObject<ResponseModel>(response.Content);
                result.main.temp_celcius = FarToCelcius(result.main.temp);
                result.main.temp_celcius_min = FarToCelcius(result.main.temp_min);
                result.main.temp_celcius_max = FarToCelcius(result.main.temp_max);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest("Something When Wrong");
            }
        }

        [AllowAnonymous]
        [HttpGet]
        [Route("GetCountries")]
        public async Task<IActionResult> GetCountries()
        {
            try
            {
                var client = new RestClient("http://countriesnow.space/api/v0.1/countries/");
                var request = new RestRequest("", Method.GET, DataFormat.Json);
                var response = await client.ExecuteAsync(request);
                var result = JsonConvert.DeserializeObject<CountriesResponse>(response.Content);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest("Something When Wrong");
            }
        }

        private double FarToCelcius(double temp)
        {
            return (temp - 32) * 5 / 9;
        }
    }
}
