import UIKit
import SwiftyJSON

var usetext: String!

class WeatherDetailCell: UICollectionViewCell {
    
    // 定义 UI 元素
    let sunRiseView = sunRiseD()
    let sunSetView = sunSetD()
    let windView = windD()
    let rainView = rainPossibilityD()
    let airView = airQualityD()
    let pressureView = pressureD()
    let moistView = moistD()
    let rayView = rayD()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        
        // 添加 UI 元素并设置约束
        contentView.addSubview(sunRiseView)
        contentView.addSubview(sunSetView)
        contentView.addSubview(windView)
        contentView.addSubview(rainView)
        contentView.addSubview(airView)
        contentView.addSubview(pressureView)
        contentView.addSubview(moistView)
        contentView.addSubview(rayView)
        
        // 设置 UI 元素的约束
        sunRiseView.frame = CGRect(x: 10, y: 10, width: (ScreenWidth - 40) / 2, height: 120)
        sunSetView.frame = CGRect(x: (ScreenWidth - 40) / 2 + 20, y: 10, width: (ScreenWidth - 40) / 2, height: 120)
        windView.frame = CGRect(x: 10, y: 140, width: (ScreenWidth - 40) / 2, height: 120)
        rainView.frame = CGRect(x: (ScreenWidth - 40) / 2 + 20, y: 140, width: (ScreenWidth - 40) / 2, height: 120)
        airView.frame = CGRect(x: 10, y: 270, width: (ScreenWidth - 40) / 2, height: 120)
        pressureView.frame = CGRect(x: (ScreenWidth - 40) / 2 + 20, y: 270, width: (ScreenWidth - 40) / 2, height: 120)
        moistView.frame = CGRect(x: 10, y: 400, width: (ScreenWidth - 40) / 2, height: 120)
        rayView.frame = CGRect(x: (ScreenWidth - 40) / 2 + 20, y: 400, width: (ScreenWidth - 40) / 2, height: 120)
    }
    
    // 更新 UI 数据
    func updateUI(with json: JSON) {
        let sun = json["showapi_res_body"]["f1"]["sun_begin_end"].stringValue // 日出日落时间
        let currentTime = json["showapi_res_body"]["now"]["temperature_time"].stringValue // 当前时间
        let uv = json["showapi_res_body"]["f1"]["ziwaixian"].stringValue // 紫外线指数
        let pressure = json["showapi_res_body"]["f1"]["air_press"].stringValue // 大气压
        let rain = json["showapi_res_body"]["f1"]["jiangshui"].stringValue // 降水概率
        let windlevel = json["showapi_res_body"]["now"]["wind_power"].stringValue // 风力
        let winddeg = json["showapi_res_body"]["now"]["wind_direction"].stringValue // 风向
        let humidity = json["showapi_res_body"]["now"]["sd"].stringValue // 湿度
        let air = json["showapi_res_body"]["now"]["aqiDetail"]["quality"].stringValue // 空气质量
        let times = sun.components(separatedBy: "|")
        
        // 设置紫外线信息（晚上显示“弱”）
        if times.count > 1 && currentTime > times[1] {
            rayView.ray.text = "弱"
        } else {
            rayView.ray.text = uv
        }
        
        // 更新 UI 数据
        sunRiseView.sunRiseTime.text = times[0] // 日出时间
        sunSetView.sunSetTime.text = times[1] // 日落时间
        usetext = times[1]
        windView.windLevel.text = windlevel // 风力
        windView.windWhere.text = winddeg // 风向
        pressureView.pressure.text = HandleData.shared.ExtractNum(pressure) // 大气压
        moistView.moist.text = humidity // 湿度
        airView.air.text = air // 空气质量
        rainView.rainPos.text = rain // 降水概率
    }
    var sunSetTimeText: String? {
         return sunSetView.sunSetTime.text
     }
    
}
