import UIKit
import Alamofire
import SwiftyJSON
import Hero

var ScreenFrame = UIScreen.main.bounds
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

// 城市天气详情页面
class CityView: UIView {
    
    let apiKey = "4B097C1688cA4A4Db31F534B0EFd9C3e"
    
    // 当前天气数据
    var now: Data
    // 未来天气数据
    var future: Data
    // 今日天气数据
    var today: Data
    // 背景标识
    var backID: String
    
    // 自定义初始化方法
    init(now: Data, future: Data, today: Data, backID: String) {
        self.now = now
        self.future = future
        self.today = today
        self.backID = backID
        super.init(frame: .zero) // 调用父类的初始化方法
        setupViews() // 调用 setupViews 方法
    }
    
    // 默认初始化方法
    override init(frame: CGRect) {
        self.now = Data() // 提供默认值
        self.future = Data() // 提供默认值
        self.today = Data() // 提供默认值
        self.backID = "" // 提供默认值
        super.init(frame: frame)
        setupViews() // 调用 setupViews 方法
    }
    
    required init?(coder: NSCoder) {
        self.now = Data() // 提供默认值
        self.future = Data() // 提供默认值
        self.today = Data() // 提供默认值
        self.backID = "" // 提供默认值
        super.init(coder: coder)
        setupViews() // 调用 setupViews 方法
    }
    
    // 设置视图
    private func setupViews() {
        addSubview(collectionView)
        
        // 设置 Auto Layout 约束
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // 集合视图
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 垂直滚动
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册自定义的 UICollectionViewCell
        collectionView.register(MainWeatherCell.self, forCellWithReuseIdentifier: "cell0")
        collectionView.register(FutureWeatherCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(hourWeatherCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(WeatherDetailCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.translatesAutoresizingMaskIntoConstraints = false // 启用 Auto Layout
        
        return collectionView
    }()
    
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension CityView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4 // 4 个 section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // 每个 section 有 1 个 item
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: ScreenWidth, height: 350)
        } else if indexPath.section == 1 {
            return CGSize(width: ScreenWidth, height: 280)
        } else if indexPath.section == 2 {
            return CGSize(width: ScreenWidth, height: 280)
        } else {
            return CGSize(width: ScreenWidth, height: 600) // 第 4 个 section 的高度
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell0", for: indexPath) as! MainWeatherCell
            cell.updateUI(with: JSON(now))
             // 传递数据
            return cell
        } else if indexPath.section == 1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! FutureWeatherCell
            cell1.updateUI(with: JSON(future))
            return cell1
        } else if indexPath.section == 2 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! hourWeatherCell
            cell2.updateUI(with: JSON(today))
            return cell2
        } else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! WeatherDetailCell
            cell3.updateUI(with: JSON(now))
            return cell3
        }
    }
    

}
