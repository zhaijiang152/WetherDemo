import UIKit
import CoreData

class ViewController: UIViewController {
    
    // 存储城市视图数据的数组
//    fileprivate var cityViewData: [CityView] = [] //初次加载e
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "天气查看"
        loadInitialData() // 先加载数据
        addViewandnavigation()
    }
    
    
    // 初始化加载数据
    func loadInitialData() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            cityViewData.removeAll() // 清空原有数据
            
            for cityEntity in results {
                cityViewData.append(CityView(
                    now: cityEntity.now ?? Data(),
                    future: cityEntity.future ?? Data(),
                    today: cityEntity.today ?? Data(),
                    backID: cityEntity.backIden ?? ""
                ))
            }
        } catch {
            print("Failed to fetch initial data: \(error)")
        }
    }
    
    
    func refreshView() {
        loadInitialData() // 刷新时重新加载数据
        collectionView.reloadData()
        pageControl.numberOfPages = cityViewData.count
        pageControl.currentPage = 0 // 重置到第一页
    }
    
    func addViewandnavigation() {
        self.view.addSubview(image1)
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        // 添加齿轮设置按钮
        navigationItem.leftBarButtonItem = settingsButton
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        // 设置约束
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    lazy var image1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.frame = CGRect(x: -200, y: 0, width: ScreenWidth, height: ScreenHeight)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        return button
    }()
    
    @objc func settingsButtonTapped() {
        let viewController2 = ViewController2()
        viewController2.refreshHandler = { [weak self] in
            self?.refreshView()
        }
        self.navigationController?.pushViewController(viewController2, animated: true)
    }
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = cityViewData.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
   
    @objc func pageControlChanged() {
        let offsetX = CGFloat(pageControl.currentPage) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = cityViewData.count // 确保pageControl同步
        return cityViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let cityView = cityViewData[indexPath.item]
        cell.contentView.addSubview(cityView)
        
        cityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            cityView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            cityView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            cityView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        
        if let currentPage = Int(exactly: pageIndex) {
            pageControl.currentPage = currentPage
        } else {
            print("无法将 pageIndex 转换为 Int，值为无效（NaN 或 infinite）")
        }
    }
}
