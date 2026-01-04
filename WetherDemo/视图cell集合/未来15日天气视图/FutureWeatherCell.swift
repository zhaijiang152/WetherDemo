import UIKit
import Alamofire
import SwiftyJSON
import Hero

var futureData: [FutureInfo] = []

class FutureWeatherCell:  UICollectionViewCell {

    
    lazy var futureTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        tableView.register(FutureWeatherTableCell.self, forCellReuseIdentifier: "reusedCellofFuture")
        tableView.layer.cornerRadius = 30
        tableView.layer.opacity = 0.8
        tableView.isScrollEnabled = false // 禁用滚动
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // 查看更多按钮
    lazy var lookMoreFuturebtn: UIButton = {
        let button = UIButton()
        button.setTitle("查看近十五日天气", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.3)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(clickFuturebtn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(futureTableView)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width - 40, height: 60))
        footerView.addSubview(lookMoreFuturebtn)
        lookMoreFuturebtn.center = footerView.center
        futureTableView.tableFooterView = footerView
        
        NSLayoutConstraint.activate([
            futureTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            futureTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            futureTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            futureTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            lookMoreFuturebtn.centerXAnchor.constraint(equalTo: footerView.centerXAnchor), // 水平居中
            lookMoreFuturebtn.centerYAnchor.constraint(equalTo: footerView.centerYAnchor), // 垂直居中
            lookMoreFuturebtn.widthAnchor.constraint(equalToConstant: 350), // 按钮宽度
            lookMoreFuturebtn.heightAnchor.constraint(equalToConstant: 45), // 按钮高度
         
        ])
        
    }
    
    // 按钮点击事件
    @objc func clickFuturebtn() {
        let toVC = FutureWeatherView() // 跳转到未来天气页面
        toVC.modalPresentationStyle = .custom // 设置为自定义过渡动画
        
        // 获取当前视图控制器
        if let parentVC = self.parentViewController {
            parentVC.present(toVC, animated: true, completion: nil) // 由当前视图控制器调用 present
        } else {
            print("无法获取父视图控制器")
        }
    }
    
    func updateUI(with json: JSON) {
        do {
            // 解析未来天气数据
            let weatherResponseFuture = try JSONDecoder().decode(WeatherResponseFuture.self, from: json.rawData())
            let dayList = weatherResponseFuture.showapi_res_body.dayList
            for i in dayList {
                var data = FutureInfo() // 创建未来天气数据对象
                data.day_air_temperature = i.day_air_temperature // 白天温度
                data.night_air_temperature = i.night_air_temperature // 夜间温度
                data.day_weather = i.day_weather // 白天天气
                data.daytime = HandleData.shared.formatTime(i.daytime, inputformat: "yyyyMMdd", outformat: "M-d") ?? "unkonw" // 格式化日期
                data.day_weather_code = i.day_weather_code // 天气代码
                futureData.append(data) // 添加到全局数组
            }
            // 刷新未来天气表格视图
            self.futureTableView.reloadData()
        } catch {
            print("parse data failed with error: \(error)")
        }
    }
}

// 扩展 UITableViewDataSource 和 UITableViewDelegate
extension FutureWeatherCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedCellofFuture", for: indexPath) as! FutureWeatherTableCell
        cell.backgroundColor = .clear

        // 清空单元格内容
        cell.weaImage.image = nil
        cell.time.text = nil
        cell.weather.text = nil
        cell.temRange.text = nil

        // 如果有未来天气数据，更新单元格内容
        if futureData.count > 0 {
            cell.time.text = futureData[indexPath.row].daytime // 日期
            cell.weather.text = futureData[indexPath.row].day_weather // 天气
            cell.weaImage.image = UIImage(named: futureData[indexPath.row].day_weather_code) // 天气图标
            cell.temRange.text = "\(futureData[indexPath.row].night_air_temperature)° ~ \(futureData[indexPath.row].day_air_temperature)°" // 温度范围
        }
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
