import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer //初始化
    
    // 单例实例，确保全局只有一个 CoreDataManager 对象
    static let shared = CoreDataManager(modelName: "Mydata")
    // 初始化方法，根据模型名称创建持久化容器
   
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)//获取对应名称的持久化容器
    }
 
    // 视图上下文，用于操作 CoreData 数据
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }   //获取对应的（MyNotes文件）视图上下文
    
    func saveContext() {
        // 检查视图上下文是否有未保存的更改
        if context.hasChanges {
            do {
                // 尝试保存更改
                try context.save()
            } catch {
                // 如果保存失败，打印错误信息
                print("Error occured while saving data: \(error.localizedDescription)")
            }
        }
    }
    
    
    // 添加 load 方法
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores {
            (description, error) in
            guard error == nil else {
                // 如果加载失败，抛出致命错误
                fatalError(error!.localizedDescription)
            }
            // 加载成功后执行回调
            completion?()
        }
    }
}
