//
//  ViewController.swift
//  RxSwift_MVVM
//
//  Created by lizhe on 16/4/11.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        
        let btn = UIButton(frame: CGRect(x: 40, y: 100, width: 50, height: 40));
        btn.setTitle("login", forState: UIControlState.Normal);
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(btn);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func login()->Void {
        print("login")
        myExample()
//        let tarBar = TabBarViewControlelr();
//        self.presentViewController(tarBar, animated: true, completion: nil)
    }
    
    func example(description: String, action: () -> ()) {
        print("\n--- \(description) example ---")
        action()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func myExample()->Void {
         //Observable<Element> 是观察者模式中被观察的对象，相当于一个事件序列 (GeneratorType) ，会向订阅者发送新产生的事件信息
/*有多种创建Observable对象的方法，主要有以下几种：
        
        asObservable
        create
        deferred
        empty
        error
        toObservable/from
        interval
        never
        just
        of
        range
        repeatElement
        timer
 */
        //empty 是一个空的序列，它只发送 .Completed 消息。
        let disposeBag = DisposeBag()
        example("empty") {
            let emptySequence: Observable<Int> = .empty()
            
            _ = emptySequence.subscribe { event in
                print(event)
            }
        }
        
        //never 是没有任何元素、也不会发送任何事件的空序列。返回一个无终止的观察者事件序列，可以用来表示无限持续时间。尽管我们给安排了next事件，但实际上，他是不会执行的。不会输出onNext
        example("never") { 
            let neverSequence:Observable<Int> = .never()
            neverSequence.subscribe({ (event) in
                print(event)
            })
        }
        
        //just 是只包含一个元素的序列，它会先发送 .Next(value) ，然后发送 .Completed 。
        example("just") {
            let singleElementSequence:Observable<Int>  = .just(32)
            
            let subscription = singleElementSequence
                .subscribe { event in
                    print(event)
            }
        }
        //just方法是一个多态方法，允许在传入参数时候指定线程
        example("justScheduler") { 
            Observable<String>
                .just("just with Scheduler", scheduler: CurrentThreadScheduler.instance)
                .subscribeNext({ (str) -> Void in
                    print(str)
                })
                .dispose()
        }
        //sequenceOf 可以把一系列元素转换成事件序列
        example("sequenceOf") { 
            let sequenceOf:Observable<Int> = Observable<Int>.of(1,2,3)
            
            let subscription = sequenceOf.subscribe {event in
                print(event)
            }
        }
        //error方法是返回一个只能调用onError方法的Observable序列。其中的onNext和OnComleted方法是不会执行的
        example("error") { 
            Observable<String>
                .error(RxError.Timeout)
                .subscribe(
                    onNext: { (str) -> Void in
                        print(str)
                        print("onNext")
                    },
                    onError: { (error)-> Void in
                        print(error)
                    },
                    onCompleted: { () -> Void in
                        print("onCompleted")
                    },
                    onDisposed: { () -> Void in
                        print("dispose")
                })
                .addDisposableTo(disposeBag)
        }
        
        
        example("form") {
//            let sequenceFromArray:Observable<Int>  = [1,2,3].asObservable()
//            let form = [1,2,3,4] as Observable
        }
        
        //create 可以通过闭包创建序列，通过 .on(e: Event) 添加事件。
        
        example("create") { 
            let myCreate = { (singleElement:Int)->Observable<Int> in
                return Observable<Int>.create({ (res) -> Disposable in
                    res.onNext(singleElement)
                    res.onNext(singleElement + 2)
                    res.onCompleted()
                    return NopDisposable.instance
                })
                
            }
            
            let test = myCreate(5).subscribe({ (event) in
                print(event)
            })
        }
        
        //deferred 会等到有订阅者的时候再通过工厂方法创建 Observable 对象，每个订阅者订阅的对象都是内容相同而完全独立的序列
        example("No Deferred") { 
            var value:String? = nil
            var subScription:Observable<String?> = .just(value)
            
            value = "hello"
            subScription.subscribe({ (event) in
                print(event)
            })
            value = "world"
        }
        //deferred不是第一步创建Observable，而是在subscriber的时候创建的
        example("deferred") { 
            var value:String? = nil
            var deferSubscribe:Observable<String?> = Observable<String?>.deferred({ () -> Observable<String?> in
                return Observable<String?>.just(value)
            })
            value = "world"
            deferSubscribe.subscribe({ (event) in
                print(event)
            })
        }
        //generate方法是一个迭代器，它一直循环onNext事件，直到condition不满足要求退出。generate有四个参数，第一个是最开始的循环变量，第二个是条件，第三个是迭代器，这个迭代器每次运行都会返回一个E类型，作为下一次是否执行onNext事件源，而是否正的要执行则看是否满足condition条件。其实我们可以理解generate就是一个循环体（其内部实现也正是一个循环，代码在：GenerateSink的run方法中）
        example("general") { 
            Observable<String>
                .generate(
                    initialState: "ah",
                    condition: ({ (str) -> Bool in
                        return str.hasPrefix("ah")
                    }),
                    iterate: ({ (str1) -> String in
                        return "h" + str1
                    }))
                //.subscribeOn(MainScheduler.instance)
                .subscribe ({ (event) -> Void in
                    if let res = event.element {
                        print(res)
                    }
                })
                .addDisposableTo(disposeBag)
        }
        //asObservable其实是相当于clone方法,你必须先有Observable对象才能调用asObservable方法
        example("asObservable") { 
            var obs = Observable<String>.create { (observer) -> Disposable in
                observer.on(.Next("hahah"))
                observer.on(.Next("deasd"))
                observer.on(.Completed)
                return NopDisposable.instance
            }
            let observable = obs.asObservable()
            observable.subscribeOn(MainScheduler.instance)
                .subscribe{ event in
                    print(event.debugDescription)
            }
        }
        
        //repeatElement方法是一个无限循环的，它会一直循环onNext方法。当然这种循环是可以指定线程的
//        example("repeatElement") {
//            Observable<String>
//                .repeatElement("daa")
//                .subscribeNext { (str) -> Void in
//                    print(str)
//                }
//                .addDisposableTo(disposeBag)
//        }
        
        //using方法是通过Factory方法生成一个对象（resourceFactory）再转换成Observable，中间我们要使用Factory方法，上面已经介绍过一次Factory方法。using方法相对其他的方法比较复杂和特殊，原因是using方法是由我们构建出资源和构建清除资源的，中间通过一个转换生成Observable对象
//        example("using") {
////
//            Observable<String>
//                .using( { () -> Student<String> in
//                    return Student(source: Observable<String>.just("jarlene"), disposeAction: { () -> () in
//                        print("hah")
//                    })
//                    },
//                    observableFactory: { (r) -> Observable<String> in
//                        return r.asObservable()
//                })
//                .subscribeNext( { (ss) -> Void in
//                    print(ss)
//                })
//                .dispose()
//        }
        
        //range
        example("range") { 
            let array:Array = ["a","b","c","d"]
            Observable<Int>.range(start: 1, count: 3)
            .subscribeNext({ (event) in
                print(array[event])
            })
        }
        
        //toObservable方法是扩展自Array，是将一个一个array转换成Observable，其内部实调用了一个序列Sequence，其用法很简单
        example("toObservable") { 
            let arr: [String] = ["ab", "cd", "ef", "gh"]
            arr.toObservable()
                .subscribeNext { (s) -> Void in
                    print(s)
                }
                .dispose()
        }
        //interval方法是定时产生一个序列，interval第一个参数就是时间间隔，第二个参数是指定线程。 可以看出interval是range和repeateElement的结合。timer方法和interval方法类似。差别在于timer可以设置间隔时间和持续时间，而interval的间隔时间和持续时间是一样的。
        
        
        
        
        
        
/*对观察者对象进行变换使得一个对象变换成另一个对象，这个是RxSwift核心之一，因此对于熟悉RxSwift特别重要。RxSwift存在以下变换方法：
 - buffer
 - flatMap
 - flatMapFirst
 - flatMapLatest
 - map
 - scan
 - window
 过滤方法
 - debounce / throttle
 - distinctUntilChanged
 - elementAt
 - filter
 - sample
 - skip
 - take
 - takeLast
 - single
 */
        
        /*
         变换
        */
        //buffer方法是extension ObservableType中的一个方法，它的作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。总体来说就是经过一定时间，将一定个数的事件组合成一个数组，一起处理，在组合的过程中，你可以选择线程。
        example("buffer") { 
            let array1:Array = [1,2,3,4,5]
            Observable<Int>.of(1,2,3,4,5)
            .buffer(timeSpan: 1, count: 2, scheduler: MainScheduler.instance)
            .subscribeNext({ (a) in
                if !a.isEmpty {
                    print(a)
                }
            })
        }
        
        //flatMap也是扩展自ObservableType，它的作用是将一种类型变换成另一种类型。flatMap的参数是一个方法，这个方法的输入参数与Observable的E是同一种类型，输出依然是Observable类型
        //例子中首先是一组Observable，通过flatMap后还是一组Observable，但是flatMap作用是，如果元素中遇到“a”字母开头的，那么它就重新组装一个数组，这个数组是只有元素和“a”；如果元素不是“a”字母开头的就与“b”字母组装成另一个数组。这两种情况都通过调用toObservable返回Observable。flatMapFirst、flatMapLast、flatMapWithIndex都是类似的作用
        example("flatMap") { 
            Observable<String>.of("ab","bc","ca","ad","ef")
                .flatMap({ (element:String) -> Observable<String> in
                    if element.hasPrefix("a") {
                        let sd : [String] = [element, "a"]
                        return sd.toObservable()
                    } else {
                        let sd : [String] = [element, "b"]
                        return sd.toObservable()
                    }

            }).subscribeNext({ (str) in
                print("--\(str)--")
            })
        }
        
        //map方法是通过其实flatMap的简化版本，它返回的可以是任何类型。其中R是返回类型。
        example("map") {
            Observable<String>.of("ab","bc","ca","ad","ef")
                .map({ (element:String) -> String in
                    return element + "haha"
                }).subscribeNext({ (str) in
                    print("--\(str)--")
                })
        }
        //scan方法有两个参数，第一个参数是种子，第二个参数是加速器。所谓的种子就是最初的状态，加速器就是将每一次运行的结果延续到下一次。scan方法也是扩展自ObservableType
        example("scan") {
            let arr:[Int] = [1,2,3,4]
            Observable<String>.of("5","6","7","8")
            .scan("k", accumulator: { (arr1, str) -> String in
                print("arr1:\(arr1) str:\(str)")
                return arr1 + str
            }).subscribeNext({ (n) -> Void in
                print(n)
            })
                .dispose()
        }
        
        //window方法同样扩展自ObservableType，它有三个参数，第一个是时间间隔，第二个是数量，第三个是线程。时间间隔指的的是window方法开窗的时间间隔；第二个参数数量指的的是每次通过窗口的个数；线程就是这种操作执行在什么线程上
        example("window") { 
            Observable<String>
                .of("ab", "bc", "cd", "de", "ef")
                .window(timeSpan: 1, count: 2, scheduler: MainScheduler.instance)
                .subscribeNext({ (n) -> Void in
                    print("===========")
                    n.subscribeNext({ (ss) -> Void in
                        print(ss)
                    })
                })
                .dispose()
        }
        
        /*
         *过滤
        */
        //debounce／throttle 方法在规定的时间中过滤序列元素，就如上图描述的一样，当debounce打开的时候，刚好那个黄色的序列元素过来，那么它就不会通知到事件（onNext、onError、onComplete）上去。下面是debounce方法源码。
        
        example("debounce") { 
            Observable<Int>.of(1,2,3,4,5,6,7,8,9)
            .debounce(2, scheduler: MainScheduler.instance)
            .subscribeNext({ (a) in
                print(a)
            })
        }
        
        //distinctUntilChanged主要是过滤相邻两个元素是否重复，重复的话就过滤掉其中之一
        example("distinctUntilChanged") { 
            Observable<String>.of("a","a","c","d","d")
            .distinctUntilChanged({ (lhs, rhs) -> Bool in
                return lhs==rhs
            }).subscribeNext({ (str) in
                print(str)
            })
        }
        
        //elementAt方法其实就挑选出所需要的序列元素,当index超界的时候，throwOnEmpty参数是否抛出异常。
        example("distinctUntilChanged") {
            Observable<String>
                .of("aa", "av", "cs", "ed", "ee", "ff")
                .elementAt(2)
                .subscribeNext { (str) -> Void in
                    print(str)
                }
                .dispose()
        }
        
        //filter指出过滤条件就行，满足过滤条件的就能执行事件通知，否则不行
        example("distinctUntilChanged") {
            Observable<String>
                .of("aa", "av", "cs", "ed", "ee", "ff")
                .filter({ (ss) -> Bool in
                    return ss.hasPrefix("a")
                })
                .subscribeNext { (str) -> Void in
                    print(str)
                }
                .dispose()
        }

        /*
        RxSwift的Observable事件处理以及线程调度,几乎在创建所有的Observable的时候都要用到Producer，而在事件处理（onNext、onError、onComplete）过程中经常要用到线程调度（Scheduler），它们之间存在一种很巧妙的设计
        */
        
        
/*
 对观察着合并就是将多个观察着（Observables）合并起来处理，使用起来更方便。它主要由以下方法：
 - merge
 - startWith
 - switchLatest
 - combineLatest
 - zip
 链接器
 - multicast
 - publish
 - refCount
 - replay
 - shareReplay
*/
        
        //merge方法就是将多个Observable对象合并处理。 startWith方法可以说是定制开始位置的，是一种比较特殊的merge方法
        example("merge and startWith") { 
            Observable.of(
                Observable.of("a", "b"),
                Observable.of("c", "d"),
                Observable.of("e", "f"),
                Observable.of("g", "h"))
                .merge()
                .startWith("x")
                .subscribeNext { (str) -> Void in
                    print(str)
                }
                .dispose()
        }
        
        //RxSwift中switchLatest相当与其他语言的switch方法
        //switchLatest,将一个Observable<Observable<T>>转为为这样的Observable,它逐个发射数据的Observable
        example("switchLatest") { 
            let var1 = Variable(0)
            let var3 = Variable(var1)
//            let d = var3.switchLatest().subscribe { print($0) }
        }
        
        //combineLatest 如果存在两条事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest 会将每个队列的最新的一个元素进行合并。
        example("combineLatest") { 
            let intOb1 = PublishSubject<String>()
            let intOb2 = PublishSubject<Int>()
            
            Observable.combineLatest(intOb1, intOb2, resultSelector: { (ob1, ob2) -> Bool in
                print(ob1)
                print(ob2)
                return true
            })
        }
        
    }
    
}

