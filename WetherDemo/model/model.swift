
struct cityInfo{
    var name :String = ""
    var tem : String = ""
    var temRange:String = ""
    var weather:String = ""
    var backIden:String = ""
}

struct FutureInfo:Codable{
    var daytime:String = ""//时间
    var day_weather:String = ""//天气
    var night_air_temperature:String = ""//晚上气温
    var day_air_temperature:String = ""//白天气温
    var day_weather_code:String = ""//天气图标
}


struct WeatherResponseFuture: Codable {
    let showapi_res_body: WeatherBodyFuture
}



struct WeatherBodyFuture: Codable {
    let dayList: [FutureInfo]
}



struct HourInfo: Codable {
    var temperature: String = ""
    var weather: String = ""
    var time: String = ""
    var wind_power: String = ""
    var weather_code:String = ""//图标
}



struct WeatherResponse: Codable {
    let showapi_res_body: WeatherBody
}



struct WeatherBody: Codable {
    let hourList: [HourInfo]
}


struct City:Decodable{
    var NAMECN = ""  // 城市名
    var PROVCN = ""  // 省份名
}
