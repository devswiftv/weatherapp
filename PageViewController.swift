//
//  PageViewController.swift
//  PageControl
//
//  Created by Andrew Seeley on 2/2/17.
//  Copyright © 2017 Seemu. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var typedCity = ""
    var allDaysData : Data?
    var pageControl = UIPageControl()
    
    // MARK: UIPageViewControllerDataSource
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "day1"),
                self.newVc(viewController: "day2"),
                self.newVc(viewController: "day3"),
                self.newVc(viewController: "day4"),
                self.newVc(viewController: "day5"),
                self.newVc(viewController: "day6"),
                self.newVc(viewController: "day7")]
        }() as! [FutureDayViewController]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
      

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        configurePageControl()
        
        // Do any additional setup after loading the view.
    }

    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func newVc(viewController: String) -> UIViewController {
       
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        if (orderedViewControllers[previousIndex] as? FutureDayViewController) != nil{
            (orderedViewControllers[previousIndex] as? FutureDayViewController)?.currentCity = self.typedCity}
        else {
          (orderedViewControllers[previousIndex] as? TodayViewController)?.currentCity = self.typedCity}
        
        return orderedViewControllers[previousIndex]    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        if (orderedViewControllers[nextIndex] as? FutureDayViewController) != nil{
            (orderedViewControllers[nextIndex] as? FutureDayViewController)?.currentCity = self.typedCity}
        else {
            (orderedViewControllers[nextIndex] as? TodayViewController)?.currentCity = self.typedCity}
        return orderedViewControllers[nextIndex]
    }
    

}
