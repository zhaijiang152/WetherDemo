


import UIKit

class FutureWeatherView:UIViewController{
    
    let reuseIdenFuture = "reusedCellofFuture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupView()
    }
    func setupView(){
        self.view.addSubview(effectView) //添加背景虚化
        self.view.addSubview(FutureTableView)
        self.view.addSubview(closeBtn)
    }
   
   
    lazy var effectView:UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = ScreenFrame
        return effectView
    }()
    
    
    lazy var FutureTableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x:20,y:130,width:ScreenWidth-40,height:780))
        tableView.backgroundColor = .clear
        tableView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        tableView.layer.cornerRadius = 30
        tableView.layer.opacity = 0.8
        
        tableView.register(FutureWeatherTableCell.self, forCellReuseIdentifier: "reusedCellofFuture")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
 
    lazy var closeBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: ScreenWidth - 50, y: 100, width: 30, height: 30))
        button.setImage(UIImage(named: "close"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(clickCloseBtn), for: .touchUpInside)
        return button
    }()

    @objc func clickCloseBtn(){
        dismiss(animated: true,completion: nil)
    }
}

extension FutureWeatherView : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
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
