

import UIKit

class TodayCollectionViewCell : UICollectionViewCell {
    lazy var TodayTem : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var TodayWeaImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var TodayWind : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var TodayTime : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.textColor = .white
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }//用于在代码中创建单元格时初始化
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }//用于从 Interface Builder 加载单元格时初始化
    
    private func setupViews(){
        //配置控件
        TodayTem.translatesAutoresizingMaskIntoConstraints = false
        TodayWeaImage.translatesAutoresizingMaskIntoConstraints = false
        TodayWind.translatesAutoresizingMaskIntoConstraints = false
        TodayTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(TodayTem)
        contentView.addSubview(TodayWeaImage)
        contentView.addSubview(TodayWind)
        contentView.addSubview(TodayTime)
    }
    
    private func setupConstraints(){
        //添加约束
        NSLayoutConstraint.activate([
            TodayTem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            TodayTem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            TodayTem.widthAnchor.constraint(equalToConstant: 60),
            TodayTem.heightAnchor.constraint(equalToConstant: 60),
            //
            TodayWeaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            TodayWeaImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            TodayWeaImage.widthAnchor.constraint(equalToConstant: 40),
            TodayWeaImage.heightAnchor.constraint(equalToConstant: 40),
            //
            TodayWind.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            TodayWind.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 110),
            TodayWind.widthAnchor.constraint(equalToConstant: 40),
            TodayWind.heightAnchor.constraint(equalToConstant: 60),
            //
            TodayTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            TodayTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 140),
            TodayTime.widthAnchor.constraint(equalToConstant: 40),
            TodayTime.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
