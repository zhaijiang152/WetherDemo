//
//  hourweather.swift
//  练习表格和集合
//
//  Created by gaoang on 2025/3/23.
//

import UIKit
import SwiftyJSON
var todayData: [HourInfo] = []

class hourWeatherCell:  UICollectionViewCell{
   

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(todayCollectionView)
      
        NSLayoutConstraint.activate([
                  // 宽度为屏幕宽度减 40
                  todayCollectionView.widthAnchor.constraint(equalToConstant: ScreenWidth - 40),
                  // 高度为 200
                  todayCollectionView.heightAnchor.constraint(equalToConstant: 200),
                  // 水平居中
                  todayCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                  // 垂直居中
                  todayCollectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
              ])
        
    }
   
    lazy var todayUpText: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 6, width: 100, height: 20))
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "24小时预报"
        label.textAlignment = .left
        return label
    }()
    
    let reuseIdenToday = "reusedCellofToday"
    lazy var todayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        collectionView.layer.cornerRadius = 30
        collectionView.layer.opacity = 0.8
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdenToday)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        collectionView.addSubview(todayUpText)
        return collectionView
    }()
 
    
    func updateUI(with json: JSON) {
        
        do {
            // 解析小时天气数据
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: json.rawData())
            let hourList = weatherResponse.showapi_res_body.hourList
            for i in hourList {//循环十五次
                var data = HourInfo() // 创建小时天气数据对象
                data.temperature = i.temperature // 温度
                data.time = HandleData.shared.formatTime(i.time, inputformat: "yyyyMMddHHmm", outformat: "HH:mm") ?? "unkonw" // 格式化时间
                data.weather = i.weather // 天气
                data.weather_code = i.weather_code // 天气代码
                data.wind_power = String(i.wind_power.split(separator: " ").first ?? "Unknown") // 风力
                todayData.append(data) // 添加到全局数组
            }
            // 刷新小时天气集合视图
            self.todayCollectionView.reloadData()
        } catch {
            print("parse data failed with error: \(error)")
        }
    }
    
    
}

extension hourWeatherCell: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusedCellofToday", for: indexPath) as! TodayCollectionViewCell
        if todayData.count > indexPath.row {
                cell.TodayTem.text = "\(todayData[indexPath.row].temperature)°" // 温度
                cell.TodayWind.text = "\(todayData[indexPath.row].wind_power)" // 风力
                cell.TodayTime.text = todayData[indexPath.row].time // 时间
                let code = todayData[indexPath.row].weather_code // 天气代码
            if let todayTime = cell.TodayTime.text, let sunsetTime = usetext {
                if todayTime > sunsetTime {
                    if (code == "00") || (code == "01") || (code == "03") {
                        cell.TodayWeaImage.image = UIImage(named: "\(code)-1")
                    } else {
                        cell.TodayWeaImage.image = UIImage(named: code)
                    }
                } else {
                    cell.TodayWeaImage.image = UIImage(named: code)
                }
            } else {
                // 如果 todayTime 或 sunsetTime 为 nil，设置默认图标
                cell.TodayWeaImage.image = UIImage(named: code)
            }
            } else {
                // 如果数据不足，设置默认值
                cell.TodayTem.text = "--°"
                cell.TodayWind.text = "--"
                cell.TodayTime.text = "--:--"
                cell.TodayWeaImage.image = nil
            }
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 200)
    }
}

