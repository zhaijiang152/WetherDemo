import Foundation
import Alamofire
import SwiftyJSON

// 网络请求 API 类，用于发送网络请求并解析数据
class NetWorkAPI {
    
    // 获取天气信息
    // @discardableResult 表示可以忽略返回值
    @discardableResult
    static func GetWeatherInformation(url: String, parameters: Parameters?, completion: @escaping (Result<Data, Error>) -> Void) -> DataRequest {
        // 使用 NetWorkManager 发送 GET 请求
        NetWorkManager.shared.requestGet(url: url, parameters: parameters) { AFResult in
            // 处理请求结果
            switch AFResult {
            case let .success(AFdata):
                // 请求成功，解析数据
                let ParseResult: Result<Data, Error> = self.parseData(AFdata)
                // 调用完成处理程序，返回解析结果
                completion(ParseResult)
            case let .failure(error):
                // 请求失败，返回错误
                completion(.failure(error))
            }
        }
    }
    
    // 解析数据
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        // 尝试将 JSON 数据解码为指定类型 T
        guard let response = try? JSONDecoder().decode(T.self, from: data) else {
            // 如果解析失败，返回自定义错误
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "can not parse data"])
            return .failure(error)
        }
        // 解析成功，返回解析后的数据
        return .success(response)
    }
}
