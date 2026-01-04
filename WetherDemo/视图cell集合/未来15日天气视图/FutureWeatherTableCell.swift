
import UIKit

/// 未来天气单元格视图
class FutureWeatherTableCell: UITableViewCell {
    
    /// 当视图从nib文件加载完成后调用，用于执行额外的初始化操作
    override func awakeFromNib() {
        super.awakeFromNib()
        // 初始化代码（如果有需要）
    }
    
    /// 设置单元格的选中状态，并进行相应的视图配置
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 配置选中状态下的视图（如果有需要）
    }
    
    // MARK: - UI 组件
    
    /// 显示时间的标签
    lazy var time: UILabel = {
        let label = UILabel()
        label.textColor = .white // 文字颜色为白色
        label.textAlignment = .left // 文字左对齐
        label.backgroundColor = .clear // 背景透明
        label.font = UIFont(name: "Avenir-Book", size: 20) // 使用 Avenir-Book 字体，大小为20
        return label
    }()
    
    /// 显示天气状况的标签
    lazy var weather: UILabel = {
        let label = UILabel()
        label.textColor = .white // 文字颜色为白色
        label.textAlignment = .left // 文字左对齐
        label.backgroundColor = .clear // 背景透明
        label.font = UIFont(name: "Avenir-Book", size: 20) // 使用 Avenir-Book 字体，大小为20
        return label
    }()
    
    /// 显示天气图标的图像视图
    lazy var weaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // 图片按比例缩放以适应视图
        return imageView
    }()
    
    /// 显示温度范围的标签
    lazy var temRange: UILabel = {
        let label = UILabel()
        label.textColor = .white // 文字颜色为白色
        label.textAlignment = .left // 文字左对齐
        label.backgroundColor = .clear // 背景透明
        label.font = UIFont.boldSystemFont(ofSize: 20) // 使用加粗的系统字体，大小为20
        return label
    }()
    
    // MARK: - 约束设置
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupViews()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       private func setupViews() {
           // 添加子视图
           contentView.addSubview(time)
           contentView.addSubview(weather)
           contentView.addSubview(temRange)
           contentView.addSubview(weaImage)

           // 设置约束
           time.translatesAutoresizingMaskIntoConstraints = false
           weather.translatesAutoresizingMaskIntoConstraints = false
           temRange.translatesAutoresizingMaskIntoConstraints = false
           weaImage.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               time.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               time.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
               time.widthAnchor.constraint(equalToConstant: 60),
               time.heightAnchor.constraint(equalToConstant: 60),

               weather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
               weather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
               weather.widthAnchor.constraint(equalToConstant: 150),
               weather.heightAnchor.constraint(equalToConstant: 60),

               temRange.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ScreenWidth * 0.65),
               temRange.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
               temRange.widthAnchor.constraint(equalToConstant: ScreenWidth * 0.3),
               temRange.heightAnchor.constraint(equalToConstant: 60),

               weaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ScreenWidth * 0.40),
               weaImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               weaImage.widthAnchor.constraint(equalToConstant: 45),
               weaImage.heightAnchor.constraint(equalToConstant: 45)
           ])
       }
}
