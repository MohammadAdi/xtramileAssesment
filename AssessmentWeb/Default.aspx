<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AssessmentWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h2>Xtramile Assessment Test</h2>
        <p class="lead">Mohammad Adi Fadilah</p>
    </div>

    <div class="row">
        <div class="col-md-3">
            <h2>Location</h2>
            <br />
            <select id="countries" class="form-control">
                <option value="">Select Country</option>
            </select>
            <br />
            <select id="cities" class="form-control">
                <option value="">Select City</option>
            </select>
        </div>
        <div class="col-md-9">
            <h2>Result</h2>
            <br />
            <div class="row">
                <div class="col-md-4">
                    <p>Location / Coordinate</p>
                    <ul>
                        <li>Longitude : <label id="lon"></label></li>
                        <li>Latitude : <label id="lat"></label></li>
                    </ul>
                    <br />                    
                    <p>Time</p>
                    <ul>
                        <li>Timezone : <label id="timezone"></label></li>
                    </ul>

                    <br />                    
                    <p>Wind</p>
                    <ul>
                        <li>Speed : <label id="speed"></label></li>
                        <li>Deg : <label id="deg"></label></li>
                        <li>Gust : <label id="gust"></label></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <p>Sky Conditions</p>
                    <ul>
                        <li>Weather : <label id="main"></label></li>
                        <li>Description : <label id="main_des"></label></li>
                    </ul>
                    <br />                    
                    <p>Temperature</p>
                    <ul>
                        <li>Celcius
                            <ul>
                                <li><label id="celcius"></label></li>
                                <li><label id="celcius_min"></label></li>
                                <li><label id="celcius_max"></label></li>
                            </ul>
                           </li>
                        <li>Farenheit
                            <ul>
                                <li><label id="far"></label></li>
                                <li><label id="far_min"></label></li>
                                <li><label id="far_max"></label></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <p>Dew Point</p>
                    <ul>
                    </ul>
                    <br />                    
                    <p>Relative Humidity</p>
                    <ul>
                        <li>Humidity : <label id="humidity"></label></li>
                    </ul>
                    <br />                    
                    <p>Pressure</p>
                    <ul>
                        <li>Pressure : <label id="pressure"></label></li>
                    </ul>
                    <br />                    
                </div>
            </div>
        </div>
    </div>
    <script>
        // A $( document ).ready() block.
        $(document).ready(function () {
            var resultArr = new Array();
            $.ajax({
                url: 'http://localhost:5000/weatherforecast/getcountries',
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json'
                },
                method: 'GET',
                dataType: 'json',
                success: function (response) {
                    if (response.data != null) {
                        resultArr = response.data;
                        $.each(response.data, function (i, data) {
                            var div_data = "<option>" + data.country + "</option>";
                            $("#countries").append(div_data);
                        });
                    }
                }
            });

            $("#countries").on('change', function () {
                var value = this.value;
                if (resultArr.length > 0) {
                    var data = resultArr.find(x => x.country == value);
                    if (data.cities.length>0) {
                        $.each(data.cities, function (i, d) {
                            var div_data = "<option>" + d + "</option>";
                            $("#cities").append(div_data);
                        });
                    }
                } 
            });

            $("#cities").on('change', function () {
                var value = this.value;
                $.ajax({
                    url: 'http://localhost:5000/weatherforecast/GetCityWeather?city=' + value,
                    headers: {
                        'Access-Control-Allow-Origin': '*',
                        'Content-Type': 'application/json'
                    },
                    method: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response!=null) {
                            $("#lon").text(response.coord.lon);
                            $("#lat").text(response.coord.lat);
                            $("#timezone").text(response.timezone);
                            $("#speed").text(response.wind.speed);
                            $("#deg").text(response.wind.deg);
                            $("#gust").text(response.wind.gust);
                            $("#main").text(response.weather[0].main);
                            $("#main_des").text(response.weather[0].description);
                            $("#humidity").text(response.main.humidity);
                            $("#pressure").text(response.main.pressure);
                            $("#far").text(response.main.temp);
                            $("#far_min").text(response.main.temp_min);
                            $("#far_max").text(response.main.temp_max);
                            $("#celcius").text(response.main.temp_celcius);
                            $("#celcius_min").text(response.main.temp_celcius_min);
                            $("#celcius_max").text(response.main.temp_celcius_max);

                        }
                    }
              });
        });
    });
    </script>
</asp:Content>
