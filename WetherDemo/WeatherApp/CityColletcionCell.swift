//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by 陈爽 on 2024/8/23.
//

import UIKit

struct cityInfo{
    var name :String = ""
    var tem : String = ""
    var temRange:String = ""
    var weather:String = ""
}

class CityColletcionCell:UICollectionViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    lazy var cityName:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    lazy var cityWeather:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 25)
        return label
    }()
    lazy var cityTemRange:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Book", size: 25)
        return label
    }()
    lazy var cityTem:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 80)
        return label
    }()
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cityTem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 250),
            cityTem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cityTem.widthAnchor.constraint(equalToConstant: 160),
            cityTem.heightAnchor.constraint(equalToConstant: 120),//温度
            
            cityTemRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 240),
            cityTemRange.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 105),
            cityTemRange.widthAnchor.constraint(equalToConstant: 120),
            cityTemRange.heightAnchor.constraint(equalToConstant: 45),//温度范围
            
            
            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cityName.widthAnchor.constraint(equalToConstant: 120),
            cityName.heightAnchor.constraint(equalToConstant: 100),
            
            cityWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cityWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            cityWeather.widthAnchor.constraint(equalToConstant: 50),
            cityWeather.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityWeather.translatesAutoresizingMaskIntoConstraints = false
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityTem.translatesAutoresizingMaskIntoConstraints = false
        cityTemRange.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cityName)
        addSubview(cityWeather)
        addSubview(cityTem)
        addSubview(cityTemRange)
        setupConstraints()
    }
}
