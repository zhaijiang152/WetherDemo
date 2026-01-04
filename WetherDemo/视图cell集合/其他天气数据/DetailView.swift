import UIKit

class sunRiseD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(sunRiseImage)
        self.addSubview(sunRiseText)
        self.addSubview(sunRiseTime)
    }

    lazy var sunRiseImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "日出"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 90, y: 0, width: 95, height: 120)
        return image
    }()
    lazy var sunRiseText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "日出"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var sunRiseTime : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}

class sunSetD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(sunSetImage)
        self.addSubview(sunSetText)
        self.addSubview(sunSetTime)
    }
    lazy var sunSetImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "日落"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 90, y: 0, width: 95, height: 120)
        return image
    }()
    lazy var sunSetText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "日落"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var sunSetTime : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        //label.text = "19:00"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}

class windD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(wind)
        self.addSubview(windWhere)
        self.addSubview(windLevel)
    }
    lazy var wind : UIImageView = {
        let image = UIImageView(image:UIImage(named: "风向"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 90, y: 0, width: 95, height: 120)
        return image
    }()
    lazy var windWhere : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "风向"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var windLevel : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}

class airQualityD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(airImage)
        self.addSubview(airText)
        self.addSubview(air)
    }
    lazy var airImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "空气质量"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 108, y: 8, width: 70, height: 100)
        return image
    }()
    lazy var airText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "空气质量"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var air : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}
class rayD:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(rayImage)
        self.addSubview(ray)
        self.addSubview(rayText)
    }
    lazy var rayImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "紫外线"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 100, y: 15, width: 80, height: 90)
        return image
    }()
    lazy var rayText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "紫外线"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var ray : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}
class rainPossibilityD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(rainImage)
        self.addSubview(rainPos)
        self.addSubview(rainText)
    }
    lazy var rainImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "降雨概率"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 90, y: 0, width: 95, height: 120)
        return image
    }()
    lazy var rainText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 80, height: 40))
        label.text = "降雨概率"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var rainPos : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}

class pressureD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(preImage)
        self.addSubview(preText)
        self.addSubview(pressure)
    }
    lazy var preImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "大气压"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 100, y: 8, width: 80, height: 100)
        return image
    }()
    lazy var preText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 60, height: 40))
        label.text = "气压"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var pressure : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}

class moistD:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    func setupView(){
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.layer.cornerRadius = 30
        self.layer.opacity = 0.8
        self.addSubview(moistImage)
        self.addSubview(moistText)
        self.addSubview(moist)
    }
    lazy var moistImage : UIImageView = {
        let image = UIImageView(image:UIImage(named: "湿度"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 100, y: 8, width: 70, height: 100)
        return image
    }()
    lazy var moistText : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: 60, height: 40))
        label.text = "湿度"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    lazy var moist : UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 60))
        //label.text = "99 %"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
}
