//
//  ViewController.swift
//  SwifterTips
//
//  Created by Moch on 10/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 测试 正则表达式
        if "onev@onevcat.com" =~ "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
                println("有效的邮箱地址")
        }
        
        // MARK: 模式匹配
        let contact = ("http://onevcat.com", "onev@onevcat.com")
        let mailRegex = ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let siteRegex = ~/"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        
        switch contact {
            case (siteRegex!, mailRegex!): println("同时拥有有效的网站和邮箱")
            case (_, mailRegex!): println("只拥有有效的邮箱")
            case (siteRegex!, _): println("只拥有有效的网站")
            default: println("嘛都没有")
        }
        
        var arr = [0, 0, 0]
        var newArr = arr
        newArr[0] = 1;

//        let time: NSTimeInterval = 2.0
//        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
//        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
//            println("延时2秒调用")
//        }
        
        let task = delay(2) { println("call 911") }
        cancel(task)
        
    }
}
