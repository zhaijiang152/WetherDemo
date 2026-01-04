import UIKit
import SwiftyJSON

class MainWeatherCell: UICollectionViewCell {
    
    // 温度标签
    lazy var temperatureText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = UIFont(name: "Avenir-Book", size: 165)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 温度单位标签
    lazy var sighText: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: "Avenir-Book", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 城市名称标签
    lazy var cityText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center // 文本居中
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: "Avenir-Book", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 天气信息标签
    lazy var weatherText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center // 文本居中
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: "Avenir-Book", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 添加子视图并设置布局
    private func setupViews() {
        contentView.addSubview(temperatureText)
        contentView.addSubview(sighText)
        contentView.addSubview(cityText)
        contentView.addSubview(weatherText)
        
        // 设置 Auto Layout 约束
        NSLayoutConstraint.activate([
            // 温度标签
            temperatureText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            temperatureText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 130),
            temperatureText.widthAnchor.constraint(equalToConstant: 250),
            temperatureText.heightAnchor.constraint(equalToConstant: 200),
            
            // 温度单位标签
            sighText.leadingAnchor.constraint(equalTo: temperatureText.trailingAnchor, constant: -50),
            sighText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 145),
            sighText.widthAnchor.constraint(equalToConstant: 60),
            sighText.heightAnchor.constraint(equalToConstant: 60),
            
            // 城市名称标签
            cityText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), // 水平居中
            cityText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            cityText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // 左边距
            cityText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20), // 右边距
            
            // 天气信息标签
            weatherText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor), // 水平居中
            weatherText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 300),
            weatherText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20), // 左边距
            weatherText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20) // 右边距
        ])
    }
    
    func updateUI(with json: JSON) {
        let shengname = json["showapi_res_body"]["cityInfo"]["c7"].stringValue // 省
        let shiname = json["showapi_res_body"]["cityInfo"]["c3"].stringValue // 市
        let temperature = json["showapi_res_body"]["now"]["temperature"].stringValue // 温度
        let weather = json["showapi_res_body"]["now"]["weather"].stringValue // 天气
        let minTemp = json["showapi_res_body"]["f1"]["night_air_temperature"].stringValue // 最低温度
        let maxTemp = json["showapi_res_body"]["f1"]["day_air_temperature"].stringValue // 最高温度
        
        temperatureText.text = temperature
        cityText.text = "\(shengname)省 \(shiname)市"
        weatherText.text = "\(weather)  最低\(minTemp)°  最高\(maxTemp)°"
    }
}
