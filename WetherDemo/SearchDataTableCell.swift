
import UIKit

class SearchDataTableCell:UITableViewCell{
    override func awakeFromNib() {
        // 当从 nib 文件加载时调用，通常用于初始化操作
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       
        super.setSelected(selected, animated: animated)
    }

    // 主文本标签（懒加载）
    lazy var mainText: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 5, width: 200, height: 30))
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    // 副文本标签（懒加载）
    lazy var secondText: UILabel = {
        let label = UILabel(frame: CGRect(x: 30, y: 33, width: 200, height: 20))
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func layoutSubviews() {

        super.layoutSubviews()

        addSubview(mainText)
        addSubview(secondText)
    }
}
