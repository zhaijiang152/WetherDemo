import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Hero
import CoreData

var cityData: [cityInfo] = []
var filteredcities = [City]()
var cities: [City] = []
var cityAll: [String] = []
var cityViewData: [CityView] = []

class ViewController2: UIViewController {
   
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        getCityInfo()
        loadCitiesFromCoreData() // 加载数据
        collectionView.dragInteractionEnabled = true
           collectionView.reorderingCadence = .fast
    }
    
    private func configNav() {
        self.view.addSubview(tableViewData)
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .white
        self.title = "城市管理"
        navigationController?.hero.isEnabled = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    var refreshHandler: (() -> Void)?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshHandler?()
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView?.tintColor = .systemBlue
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.systemBlue
            ]
            textField.attributedPlaceholder = NSAttributedString(
                string: "请输入你想搜索的城市",
                attributes: attributes
            )
        }
        return searchController
    }()
    
    let reuseIdenData = "reuseCellData"
    lazy var tableViewData: UITableView = {
        let tableView = UITableView(frame: ScreenFrame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(SearchDataTableCell.self, forCellReuseIdentifier: reuseIdenData)
        tableView.isHidden = true
        return tableView
    }()
    
    let reuseIdenCity = "reuseCellCity"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: ScreenWidth - 40, height: 140)
        let collectionView = UICollectionView(frame: CGRect(x: 20, y: 160, width: ScreenWidth - 40, height: ScreenHeight * 0.80), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(CityColletcionCell.classForCoder(), forCellWithReuseIdentifier: reuseIdenCity)
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:))))
        return collectionView
    }()
   
   
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        var fromPoint: CGPoint = .zero
        var movementPoint: CGPoint = .zero

        switch sender.state {
        case .began:
            fromPoint = sender.location(in: sender.view)
            if let indexPath = collectionView.indexPathForItem(at: fromPoint) {
                collectionView.beginInteractiveMovementForItem(at: indexPath)
            }

        case .changed:
            movementPoint = sender.location(in: sender.view)
            if (sender.view?.point(inside: movementPoint, with: nil))! {
                collectionView.updateInteractiveMovementTargetPosition(movementPoint)
            }

        case .ended:
            collectionView.endInteractiveMovement()

        case .cancelled, .failed:
            collectionView.cancelInteractiveTransition()

        default:
            break
        }
    }
    
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCityInfo() {
        guard let filePath = Bundle.main.path(forResource: "city", ofType: "json") else {
            print("city文件未找到")
            return
        }
        
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            cities = try JSONDecoder().decode([City].self, from: fileData)
        } catch {
            print("文件读取有误 或 JSON 解析错误:", error)
        }
    }
    
    func getJSONData(_ city: String) {
        let apiKey = "4B097C1688cA4A4Db31F534B0EFd9C3e"
        let nowURL = "https://route.showapi.com/9-2?appKey=\(apiKey)"
        let futureURL = "https://route.showapi.com/9-9?appKey=\(apiKey)"
        let todayURL = "https://route.showapi.com/9-8?appKey=\(apiKey)"
        let para: [String: String] = ["area": city]
        let urls = [nowURL, futureURL, todayURL]
        let parameters: [Parameters?] = [para, para, para]

        NetWorkManager.shared.fetchMultipleData(urls: urls, parameters: parameters) { result in
            switch result {
            case .success(let dataArray):
                guard dataArray.count == 3 else {
                    print("数据不完整")
                    return
                }

                let nowdata = dataArray[0]
                let futuredata = dataArray[1]
                let todaydata = dataArray[2]

                let nowJSON = JSON(nowdata)
                let minTemp = nowJSON["showapi_res_body"]["f1"]["night_air_temperature"].stringValue
                let maxTemp = nowJSON["showapi_res_body"]["f1"]["day_air_temperature"].stringValue
                let weather = nowJSON["showapi_res_body"]["now"]["weather"].stringValue
                let temperature = nowJSON["showapi_res_body"]["now"]["temperature"].stringValue

                let air = nowJSON["showapi_res_body"]["now"]["aqiDetail"]["quality"].stringValue
                let weatherCode = nowJSON["showapi_res_body"]["now"]["weather_code"].stringValue
                let currentTime = nowJSON["showapi_res_body"]["now"]["temperature_time"].stringValue
                let sun = nowJSON["showapi_res_body"]["f1"]["sun_begin_end"].stringValue
                let times = sun.components(separatedBy: "|")

                let backIden = self.determineBackground(air: air, weatherCode: weatherCode, currentTime: currentTime, times: times)

                let info = cityInfo(
                    name: city,
                    tem: temperature,
                    temRange: "\(minTemp)° ~ \(maxTemp)°",
                    weather: weather,
                    backIden: backIden
                )

                self.saveCityToCoreData(info: info, now: nowdata, future: futuredata, today: todaydata)

                cityAll.append(city)
                cityData.append(info)
                let viewControllerA = CityView(now: nowdata, future: futuredata, today: todaydata, backID: backIden)
                cityViewData.append(viewControllerA)

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    func determineBackground(air: String, weatherCode: String, currentTime: String, times: [String]) -> String {
        var backIden = ""

        if air == "重度污染" || air == "严重污染" || air == "很差" || air == "中度污染" {
            backIden = "badAirDay"
        }

        if weatherCode == "00" || weatherCode == "01" || weatherCode == "03" {
            if times.count > 1 && currentTime > times[1] {
                backIden = "sunnyEvening"
            } else {
                backIden = "sunnyDay"
            }
        } else {
            if times.count > 1 && currentTime > times[1] {
                backIden = "rainyEvening"
            } else {
                backIden = "rainyDay"
            }
        }

        if times.count > 1 && (currentTime == times[1] || currentTime == times[0]) {
            backIden = "sunRiseSet"
        }

        return backIden
    }
    
    func saveCityToCoreData(info: cityInfo, now: Data, future: Data, today: Data) {
        let context = CoreDataManager.shared.context
        let cityEntity = CityEntity(context: context)
        cityEntity.name = info.name
        cityEntity.tem = info.tem
        cityEntity.temRange = info.temRange
        cityEntity.weather = info.weather
        cityEntity.backIden = info.backIden
        cityEntity.now = now
        cityEntity.future = future
        cityEntity.today = today
        CoreDataManager.shared.saveContext()
    }
    
    func loadCitiesFromCoreData() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            cityAll.removeAll()
            cityData.removeAll()
            cityViewData.removeAll()
            
            for cityEntity in results {
                cityAll.append(cityEntity.name ?? "")
                cityData.append(cityInfo(
                    name: cityEntity.name ?? "",
                    tem: cityEntity.tem ?? "",
                    temRange: cityEntity.temRange ?? "",
                    weather: cityEntity.weather ?? "",
                    backIden: cityEntity.backIden ?? ""
                ))
                cityViewData.append(CityView(
                    now: cityEntity.now ?? Data(),
                    future: cityEntity.future ?? Data(),
                    today: cityEntity.today ?? Data(),
                    backID: cityEntity.backIden ?? ""
                ))
            }
            
            collectionView.reloadData()
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
    
 
    func deleteCity(at index: Int) {
        // 从CoreData删除
        deleteCityFromCoreData(at: index)
        
        // 更新数据源
        cityAll.remove(at: index)
        cityData.remove(at: index)
        cityViewData.remove(at: index)
        
        // 更新UI
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }, completion: nil)
    }

    // 3. CoreData删除方法
    func deleteCityFromCoreData(at index: Int) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", cityAll[index])
        
        do {
            let results = try context.fetch(fetchRequest)
            if let cityEntity = results.first {
                context.delete(cityEntity)
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Failed to delete data: \(error)")
        }
    }
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredcities.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCellData", for: indexPath) as! SearchDataTableCell
        if isFiltering() {
            cell.mainText.text = filteredcities[indexPath.row].NAMECN
            cell.secondText.text = filteredcities[indexPath.row].PROVCN
        } else {
            cell.mainText.text = cities[indexPath.row].NAMECN
            cell.secondText.text = cities[indexPath.row].PROVCN
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var flag = 0
        let selectedCell = tableView.cellForRow(at: indexPath) as? SearchDataTableCell
        let selectedData = selectedCell?.mainText.text

        for i in 0..<cityAll.count {
            if cityAll[i] == selectedData! {
                flag = 1
                showCityRepeat()
            } else {
                continue
            }
        }

        if flag == 0 {
            getJSONData(selectedData!)
        }

        searchController.isActive = false
        navigationController?.navigationBar.isHidden = false
        searchController.searchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showCityRepeat() {
        let alert = UIAlertController(title: "重复添加城市‼️", message: "You already have added this city", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Get it", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension ViewController2: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredcities = cities.filter({ (city: City) -> Bool in
            return city.NAMECN.lowercased().contains(searchText.lowercased())
        })
        tableViewData.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableViewData.isHidden = false
        collectionView.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableViewData.isHidden = true
        collectionView.isHidden = false
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCellCity", for: indexPath) as! CityColletcionCell
        cell.layer.cornerRadius = 25
        cell.cityName.text = cityData[indexPath.row].name
        cell.cityTem.text = cityData[indexPath.row].tem
        cell.cityTemRange.text = cityData[indexPath.row].temRange
        cell.cityWeather.text = cityData[indexPath.row].weather
        HandleData.shared.setWeatherGradientBackground(for: cell, weatherCondition: cityData[indexPath.row].backIden)
        cell.hero.isEnabled = true
        cell.hero.id = "shareId"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.item
        let toRow = destinationIndexPath.item
        let city = cityData[fromRow]
        cityData.remove(at: fromRow)
        cityData.insert(city, at: toRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let deleteAction = UIContextualAction(style: .destructive, title: "删除") { [weak self] (_, _, completionHandler) in
             self?.deleteCity(at: indexPath.item)
             completionHandler(true)
         }
         deleteAction.backgroundColor = .red
         return UISwipeActionsConfiguration(actions: [deleteAction])
     }
    
}

// MARK: - CLLocationManagerDelegate

extension ViewController2: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 确保 locations 数组中有最新的位置信息，如果数组为空，则 last 为 nil，直接返回
        guard let location = locations.last else { return }

        // 停止位置更新以节省电池
        locationManager.stopUpdatingLocation()

        // 使用地理编码器将位置信息反编码为城市名称
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            // 确保反编码结果中有第一个地点信息，否则直接返回
            guard let placemark = placemarks?.first else { return }

            // 在主线程中执行 UI 更新操作
            DispatchQueue.main.async {
                // 获取地点的城市名称（locality）
                let rawCity = placemark.locality

                // 使用 HandleData 工具类格式化城市名称
                let finalCity = HandleData.shared.formatCityName(rawCity!)

                // 打印格式化后的城市名称
                print(finalCity)

                // 调用 getJSONData 方法，获取该城市的天气数据
                self.getJSONData(finalCity)

                // 刷新集合视图（collectionView），更新 UI
                self.collectionView.reloadData()
            }
        }
    }
    // 定位失败处理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get user location: \(error.localizedDescription)")
    }
}
 

