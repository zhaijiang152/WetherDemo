import UIKit

// 数据处理工具类，提供时间格式化、正则提取、渐变背景设置等功能
class HandleData {
    // 单例模式，确保全局只有一个实例
    static let shared = HandleData()
    
    // 私有化初始化方法，防止外部创建新的实例
    private init() {}
    
    // MARK: - 时间处理

    /// 将时间戳转换为指定格式的时间字符串
    /// - Parameter value: 时间戳（秒级）
    /// - Returns: 格式化后的时间字符串（HH:mm）
    func getTime(_ value: Int) -> String {
        let timestamp = TimeInterval(value) // 将时间戳转换为 TimeInterval 类型
        let date = Date(timeIntervalSince1970: timestamp) // 转换为 Date 对象
        let dataFormatter = DateFormatter() // 创建一个 DateFormatter 对象
        dataFormatter.timeZone = TimeZone(abbreviation: "UTC+8") // 设置为 UTC+8 时区
        dataFormatter.dateFormat = "HH:mm" // 设置时间格式为 "小时:分钟"
        let result = dataFormatter.string(from: date) // 转换为字符串
        return result
    }
    
    // MARK: - 正则表达式处理

    /// 使用正则表达式提取字符串中的数字
    /// - Parameter value: 输入的字符串
    /// - Returns: 提取到的数字字符串
    func ExtractNum(_ value: String) -> String {
        var number: Substring = ""
        do {
            // 创建正则表达式，匹配一个或多个数字
            let regex = try NSRegularExpression(pattern: "\\d+", options: [])
            // 在输入字符串中查找匹配项
            let matches = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.utf16.count))
            if let match = matches.first { // 如果找到第一个匹配项
                if let range = Range(match.range, in: value) { // 获取匹配的范围
                    number = value[range] // 提取子字符串
                }
            }
        } catch {
            // 如果正则表达式创建失败，打印错误信息
            print("An error occurred while creating the regular expression: \(error)")
        }
        return String(number) // 返回提取到的数字字符串
    }
    
    // MARK: - 时间格式转换

    /// 将时间从一种格式转换为另一种格式
    /// - Parameters:
    ///   - time: 输入的时间字符串
    ///   - inputformat: 输入时间的格式
    ///   - outformat: 输出时间的格式
    /// - Returns: 转换后的时间字符串，如果转换失败则返回 nil
    func formatTime(_ time: String, inputformat: String, outformat: String) -> String? {
        let inputFormatter = DateFormatter() // 创建输入时间的格式化器
        inputFormatter.dateFormat = inputformat
        
        let outputFormatter = DateFormatter() // 创建输出时间的格式化器
        outputFormatter.dateFormat = outformat
        
        // 将输入的时间字符串转换为 Date 对象
        guard let date = inputFormatter.date(from: time) else { return nil }
        // 将 Date 对象格式化为目标格式的字符串
        return outputFormatter.string(from: date)
    }
    
    // MARK: - 渐变背景设置

    func setWeatherGradientBackground(for view: UIView, weatherCondition: String) {
        let gradientLayer = CAGradientLayer() // 创建渐变层
        
        // 根据天气条件设置渐变的颜色
        if weatherCondition == "sunRiseSet" {
            // 日出日落时的渐变颜色
            let topColor = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 112.0/255.0, alpha: 1.0).cgColor
            let middleColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
            let bottomColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [topColor, middleColor, bottomColor]
            gradientLayer.locations = [0.0, 0.5, 1.0]
        } else {
            // 其他天气条件的渐变颜色
            let sunnyDayTopColor = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            let rainyDayTopColor = UIColor(red: 80.0/255.0, green: 85.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
            let sunnyDayBottomColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
            let rainyDayBottomColor = UIColor(red: 40.0/255.0, green: 45.0/255.0, blue: 55.0/255.0, alpha: 1.0).cgColor
            let badAirtopColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
            let badAirBottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
            
            var topColor: CGColor
            var bottomColor: CGColor
            
            // 根据天气条件选择颜色
            switch weatherCondition {
            case "sunnyDay":
                topColor = sunnyDayTopColor
                bottomColor = sunnyDayBottomColor
            case "rainyDay":
                topColor = rainyDayTopColor
                bottomColor = rainyDayBottomColor
            case "sunnyEvening":
                topColor = UIColor(red: 100.0/255.0, green: 149.0/255.0, blue: 237.0/255.0, alpha: 1.0).cgColor
                bottomColor = UIColor(red: 70.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
            case "rainyEvening":
                topColor = UIColor(red: 70.0/255.0, green: 130.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
                bottomColor = UIColor(red: 50.0/255.0, green: 100.0/255.0, blue: 150.0/255.0, alpha: 1.0).cgColor
            case "badAirDay":
                topColor = badAirtopColor
                bottomColor = badAirBottomColor
            default:
                topColor = sunnyDayTopColor
                bottomColor = sunnyDayBottomColor
            }
            
            gradientLayer.colors = [topColor, bottomColor]
            gradientLayer.locations = [0.0, 1.0]
        }
        
        // 如果是 UICollectionViewCell，设置圆角和渐变背景
        if let collectionViewCell = view as? UICollectionViewCell {
            gradientLayer.cornerRadius = 25 // 设置圆角
            gradientLayer.frame = collectionViewCell.bounds // 设置渐变层的大小
            collectionViewCell.layer.masksToBounds = true // 确保圆角效果显示
        } else if let scrollView = view as? UIScrollView {
            // 如果是 UIScrollView，设置渐变背景的大小
            gradientLayer.frame = CGRect(x: 0, y: -80, width: ScreenWidth, height: scrollView.contentSize.height + 80)
        }
        
        // 将渐变层添加到视图的图层中
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - 城市名称处理

    func formatCityName(_ raw: String) -> String {
        let suffixes = ["市", "省", "自治区", "特别行政区"] // 城市名称的后缀列表
        var formatted = raw
        for suffix in suffixes {
            if formatted.hasSuffix(suffix) { // 如果城市名称以某个后缀结尾
                formatted = String(formatted.dropLast(suffix.count)) // 去掉后缀
                break // 只需处理一次
            }
        }
        return formatted
    }
}
