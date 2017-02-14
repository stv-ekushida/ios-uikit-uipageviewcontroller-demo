//
//  PageViewProvider.swift
//  ios-uikit-uipageviewcontroller-demo
//
//  Created by Kushida　Eiji on 2017/02/15.
//  Copyright © 2017年 Kushida　Eiji. All rights reserved.
//

import UIKit

final class PageViewProvider: NSObject, UIPageViewControllerDataSource {
    
    var imageFiles: [String] = []
    
    func setupImageFile(imageFiles: [String]) {
        self.imageFiles = imageFiles
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return goFowardPage(viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return goBackPage(viewController)
    }
    
    private func goBackPage(_ viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageInnerViewController).pageIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    private func goFowardPage(_ viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageInnerViewController).pageIndex
        
        if index == NSNotFound {
            return nil;
        }
        index += 1
        if index == imageFiles.count {
            return nil;
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(_ index:Int) -> PageInnerViewController? {
        
        if imageFiles.count == 0 || index >= imageFiles.count {
            return nil
        }
        if let vc = UIStoryboard.getViewController("Main", identifier: "PageInnerViewController") as? PageInnerViewController {
            vc.pageIndex = index
            vc.filePath = imageFiles[index]
            return vc
        }
        return nil
    }
}
