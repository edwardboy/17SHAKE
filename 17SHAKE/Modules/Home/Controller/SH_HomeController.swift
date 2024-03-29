//
//  SH_HomeController.swift
//  17SHAKE
//
//  Created by gyh on 2019/12/10.
//  Copyright © 2019 com.berman.www. All rights reserved.
//

import UIKit
import OpenGLES
import Metal
import WebKit
import SnapKit
import Kingfisher
import Alamofire

class SH_HomeController: SH_BaseController {
    
    //    let waterfallListView = UICollectionView()
    let pageControl = UIPageControl()
    
    lazy var webView : WKWebView = WKWebView()
    
    var step = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.init(named: "theme")
         
        // for循环
        for i in 0...100 {
            print(i)
        }
        
//        increment(&step)
        
        var dic:Dictionary = [String:Any]()
        dic["123"] = false
        print(dic["123"] ?? "sss")
        
    }
    /*
     内存访问冲突会在两个访问满足下列条件时发生：
     1> 至少一个是写入操作
     2> 它们访问的是同一块内存
     3> 它们的访问时间重叠（比如在同一个函数）
     
     同时访问同一块结构体的内存也会冲突
     */
    // Simultaneous accesses to 0x7fe3bd4058a0, but modification requires exclusive access
    func increment(_ num: inout Int) {
        num += step
    }
    
    
    
    
    /*
     指针类型， Unsafe ，常见的4种指针类型
     UnsafePointer<Pointee> 类似于 const Pointee *
     UnsafeMutablePointer<Pointee> 类似于 Pointee *
     UnsafeRawPointer 类似于 const void *
     UnsafeMutableRawPointer 类似于 void *
     */
    func testPointee(_ ptr: UnsafeMutablePointer<Int>){
        ptr.pointee = 10
    }
    
    func testPointee1(_ ptr: UnsafePointer<Int>){
        print(ptr.pointee)
    }
    
    func testPointee2(_ ptr: UnsafeRawPointer){
//        ptr.pointee = 10
        print(ptr.load(as: Int.self))
    }
    
    func testPointee3(_ ptr: UnsafeMutableRawPointer){
//        ptr.pointee = 10
        ptr.storeBytes(of: 30, as: Int.self)
    }
    
    
    func testKeyWord(){
//        let p = P()
//        p[index:0] = 100
//        print(p[index:0])
//        print(p[10,20])
        
        let pk = PK()
        pk.test()
        pk.testReturnValue()
        
//        print(Sex.male.rawValue)
//        print(ESize.large)
        
        print(CustomObj(name: "hello") == CustomObj(name: "hello"))
        
        let str = "123123123123"
        
        let a = 10
        let b = 11
        let c = 12
        let res = a + b + c
        
        
    }
    
    func setupView(){
//        let configuration = WKWebViewConfiguration()
//        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
//        self.view.addSubview(webView)
//
//        webView.snp.makeConstraints { (make) in
//            make.width.height.left.top.equalTo(self.view)
//        }
        
//        testNetwork()
        
        testClosureExpression()
        
        let textLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 60))
        textLabel.text = "123"
        textLabel.textColor = .cyan
        textLabel.font = .preferredFont(forTextStyle: .title1)
        self.view.addSubview(textLabel)
    }
    
    
    typealias Fn = (Int) -> Int
    
    func getFn() -> Fn {
        var num = 0
        func plus(_ i:Int) -> Int {
            num += i
            return num
        }
        return plus
    }
    
    func testClosureExpression() {
        
//        let fn = getFn()
//        print(fn(1))
//        print(fn(2))
//        print(fn(3))
//        print(fn(4))
        
        let fn1 = getFn()
        let fn2 = getFn()
        let fn3 = getFn()
        let fn4 = getFn()
        print(fn1(1))
        print(fn2(2))
        print(fn3(3))
        print(fn4(4))
        
//        let fn = {
//            (v1:Int, v2: Int) -> Int in
//            return v1 + v2
//        }
        
        
//        let fn = { $0 }
//        print(fn(10,11))
        
//        exec(v1: 18, v2: 19, fn: {$0 + $1})
        
//        print(exec1())
    }
    
//    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
//        print(fn(v1, v2))
//    }
    
    func exec1(v1:Int = 10, v2:Int = 29) -> Int{
       return v1 + v2
    }
    
    func testSth() {
        //        self.printPropertyList()
        
        //        print(TestNum.FIRST.rawValue)
        
        //        print(testFucntion(cal: 1, second: 2))
        
        //        let f: Double = 1.0
        
//        let p1 = Point()
//        print(p1.x)
//
//        print("point.x值为\(String(describing: p1.x))")
//        print("point.x",p1.x)
        
//        let ptr = malloc(16)
//        malloc_size(ptr)
        
        //        let e = TestNum.test2(false)
        //        switch e {
        //        case let .test1(v):
        //            print("test1",v)
        //        case let .test2(v):
        //            print("test2",v)
        //        default:
        //            print("-=-=-=-----")
        //        }
    }
    
    func testUIMenu() {
        navigationController?.isToolbarHidden = false
        
        if #available(iOS 14.0, *) {
            let addNewItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: createMenuIOS13())
            //            toolbarItems = [addNewItem]
            navigationItem.rightBarButtonItem = addNewItem
        } else {
            // Fallback on earlier versions
        }
    }
    
    func testNetwork(){
        
        let urlStr = "http://www.baidu.com".urlEncode()
        
        AF.request(urlStr).responseString(completionHandler: { (response) in
            guard let res = response.value else {
                print("百度请求失败：",response.error?.localizedDescription as Any)
                return
            }
            
            print("当前线程:",Thread.current);
            
            print("百度请求返回：",res)
            let url = URL(string: urlStr)!
            let request = URLRequest(url: url)
            self.webView.load(request)
        })
    }
    
    func testFucntion(cal first:Int, second:Int) -> Int{
        first + second
    }
    
    @available(iOS 13.0, *)
    func createMenuIOS13() -> UIMenu {
        // 第一个菜单
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in
            print("favorite")
        }
        // 第二个菜单
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
            print("share")
        }
        // 第三个菜单
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { _ in
            print("delete")
        }
        
        let menuActions = [favorite, share, delete]
        
        let addNewMenu = UIMenu(
            title: "",
            children: menuActions)
        
        return addNewMenu
    }
}
