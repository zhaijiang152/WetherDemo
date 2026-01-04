import UIKit

class CityColletcionCell: UICollectionViewCell {

    // 当从 nib 文件加载时调用
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // 当布局子视图时调用
    override func layoutSubviews() {
        super.layoutSubviews()
        // 将子视图添加到内容视图中
        addSubview(cityName)
        addSubview(cityTemRange)
        addSubview(cityTem)
        addSubview(cityWeather)
        // 设置约束
        setupConstraints()
    }

    // 设置子视图的约束
    private func setupConstraints() {
        // 禁用自动转换约束
        // 默认情况下，UIView 的 `translatesAutoresizingMaskIntoConstraints` 属性为 true，
        // 表示系统会根据 frame 自动生成约束。这里设置为 false，表示我们手动设置约束。
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityWeather.translatesAutoresizingMaskIntoConstraints = false
        cityTem.translatesAutoresizingMaskIntoConstraints = false
        cityTemRange.translatesAutoresizingMaskIntoConstraints = false

        // 激活约束
        // 使用 `NSLayoutConstraint.activate` 方法一次性激活一组约束，简化代码。
        NSLayoutConstraint.activate([
 
            cityTem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 260),
            cityTem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cityTem.widthAnchor.constraint(equalToConstant: 170),
            cityTem.heightAnchor.constraint(equalToConstant: 120),

          
            cityTemRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 250),
            cityTemRange.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            cityTemRange.widthAnchor.constraint(equalToConstant: 120),
            cityTemRange.heightAnchor.constraint(equalToConstant: 45),

            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cityName.widthAnchor.constraint(equalToConstant: 120),
            cityName.heightAnchor.constraint(equalToConstant: 100),

            cityWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cityWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 90),
            cityWeather.widthAnchor.constraint(equalToConstant: 50),
            cityWeather.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // 城市名称标签（懒加载）
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left // 文本左对齐
        label.textColor = .white // 文本颜色为白色
        label.font = UIFont(name: "Avenir-Book", size: 40) // 字体和大小
        return label
    }()

    // 天气标签（懒加载）
    lazy var cityWeather: UILabel = {
        let label = UILabel()
        label.textAlignment = .left // 文本左对齐
        label.textColor = .white // 文本颜色为白色
        label.font = UIFont(name: "Avenir-Book", size: 25) // 字体和大小
        return label
    }()

    // 温度范围标签（懒加载）
    lazy var cityTemRange: UILabel = {
        let label = UILabel()
        label.textAlignment = .left // 文本左对齐
        label.textColor = .white // 文本颜色为白色
        label.font = UIFont(name: "Avenir-Book", size: 25) // 字体和大小
        return label
    }()

    // 温度标签（懒加载）
    lazy var cityTem: UILabel = {
        let label = UILabel()
        label.textAlignment = .left // 文本左对齐
        label.textColor = .white // 文本颜色为白色
        label.font = UIFont(name: "Avenir-Book", size: 90) // 字体和大小
        return label
    }()
}
