import Foundation
import Alamofire
import SwiftyJSON

// 定义网络请求结果的类型别名
typealias NetWorkRequestResult = Result<Data, Error>

// 定义网络请求完成处理程序的类型别名
typealias NetWorkCompletionHandler = (NetWorkRequestResult) -> Void

// 网络请求管理类，封装网络请求和错误处理
class NetWorkManager {
    // 单例模式，确保全局只有一个实例
    static let shared = NetWorkManager()

    // 私有化初始化方法，防止外部创建新的实例
    private init() {}

    // 发送 GET 请求
    // @discardableResult 表示可以忽略返回值
    @discardableResult
    func requestGet(url: String, parameters: Parameters?, completion: @escaping NetWorkCompletionHandler) -> DataRequest {
        // 使用 Alamofire 发送 GET 请求
        AF.request(url,
                   parameters: parameters,
                   requestModifier: { $0.timeoutInterval = 15 }
                  ) // 设置请求超时时间为 15 秒
            .responseData { response in
                // 处理请求结果
                switch response.result {
                case let .success(data):
                    // 请求成功，返回数据
                    completion(.success(data))
                case let .failure(error):
                    // 请求失败，处理错误
                    completion(self.handleError(error))
                }
            }
    }

    // 发送 POST 请求
    @discardableResult
    func requestPost(url: String, parameters: Parameters?, completion: @escaping NetWorkCompletionHandler) -> DataRequest {
        // 使用 Alamofire 发送 POST 请求
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default, // 使用 JSON 编码
                   requestModifier: { $0.timeoutInterval = 10 }) // 设置请求超时时间为 10 秒
            .responseData { response in
                // 处理请求结果
                switch response.result {
                case let .success(data):
                    // 请求成功，返回数据
                    completion(.success(data))
                case let .failure(error):
                    // 请求失败，处理错误
                    completion(self.handleError(error))
                }
            }
    }

    // 处理网络错误
    private func handleError(_ error: AFError) -> NetWorkRequestResult {
        // 检查是否是网络问题
        if let underlyingError = error.underlyingError {
            // 将错误转换为 NSError
            let nserror = underlyingError as NSError
            let code = nserror.code

            // 判断错误类型
            if code == NSURLErrorNotConnectedToInternet || // 无网络连接
               code == NSURLErrorTimedOut || // 请求超时
               code == NSURLErrorInternationalRoamingOff || // 国际漫游关闭
               code == NSURLErrorDataNotAllowed || // 数据不可用
               code == NSURLErrorCannotFindHost || // 找不到主机
               code == NSURLErrorCannotConnectToHost || // 无法连接到主机
               code == NSURLErrorNetworkConnectionLost // 网络连接丢失
            {
                // 修改错误信息，使其更友好
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题😯"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        // 如果不是网络问题，直接返回原始错误
        return .failure(error)
    }

    // 发送多个 GET 请求，并等待所有请求完成
    func fetchMultipleData(urls: [String], parameters: [Parameters?], completion: @escaping (Result<[Data], Error>) -> Void) {
        // 使用 DispatchGroup 管理多个异步请求
        let dispatchGroup = DispatchGroup()
        // 初始化结果数组，用于存储每个请求的返回数据
        var results = [Data?](repeating: nil, count: urls.count)
        // 用于存储请求过程中的错误
        var requestError: Error?

        // 遍历 URL 数组，发送多个请求
        for (index, url) in urls.enumerated() {
            // 进入 DispatchGroup
            dispatchGroup.enter()
            // 发送 GET 请求
            requestGet(url: url, parameters: parameters[index]) { result in
                switch result {
                case .success(let data):
                    // 请求成功，存储数据
                    results[index] = data
                case .failure(let error):
                    // 请求失败，存储错误
                    requestError = error
                }
                // 离开 DispatchGroup
                dispatchGroup.leave()
            }
        }

        // 所有请求完成后执行
        dispatchGroup.notify(queue: .main) {
            if let error = requestError {
                // 如果有错误，返回错误
                completion(.failure(error))
            } else {
                // 如果所有请求成功，返回数据数组
                completion(.success(results.compactMap { $0 }))
            }
        }
    }
}
