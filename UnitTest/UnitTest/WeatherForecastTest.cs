using AssessmentTest.Controllers;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Xunit;

namespace UnitTest
{
    public class WeatherForecast
    {
        [Fact]
        public async Task GetCountriesTest()
        {
            var controller = new WeatherForecastController();

            // Act
            var result = await controller.GetCountries();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetCitiesTest()
        {
            var controller = new WeatherForecastController();

            // Act
            var result = await controller.GetCityWeather("Tokyo");

            // Assert
            Assert.NotNull(result);
        }


    }
}
