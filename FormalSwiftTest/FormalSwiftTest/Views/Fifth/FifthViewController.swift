//
//  FifthViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/9.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

//MVC的模式使用RX
class FifthViewController: UIViewController {
    
    let minimumUserNameLength = 5
    let minimumPasswordLength = 5
    let disposeBag = DisposeBag()
    
    let userNameTf : UITextField = {
        
        let tf = UITextField.init(frame: CGRect(x: 20, y: 70, width: kScreenWidth-40, height: 40))
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let userNameOutlet : UILabel = {
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 120, width: kScreenWidth-40, height: 40))
        label.textColor = .red
        return label
    }()
    
    
    let passwordTf : UITextField = {
        
        let tf = UITextField.init(frame: CGRect(x: 20, y: 200, width: kScreenWidth-40, height: 40))
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let passwordOutlet : UILabel = {
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 250, width: kScreenWidth-40, height: 40))
        label.textColor = .red

        return label
    }()
    
    let submitBtn : UIButton = {
       
        let btn = UIButton.init(frame: CGRect(x: 20, y: 320, width: kScreenWidth - 40, height: 40))
        btn.setTitle("do something", for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.userNameOutlet.text = "userName has to be at least \(self.minimumUserNameLength) characters"
        self.passwordOutlet.text = "password has to be at least \(self.minimumPasswordLength) characters"

        self.view.addSubview(self.userNameTf)
        self.view.addSubview(self.userNameOutlet)
        self.view.addSubview(self.passwordTf)
        self.view.addSubview(self.passwordOutlet)
        self.view.addSubview(self.submitBtn)
        
        self.setup()
    }
    
    func setup(){
        //一般的套路是先创建一个observable，在用此来订阅事件。 RxCocoa封装了UI，通过UI方法即可以得到observable。 RX也提供了create方法（及of， from方法），用于手动创建observable
        
        
        //0
        //        let userNameValid = self.userNameTf.rx.text.orEmpty.map{$0.count >= self.minimumUserNameLength}.share(replay: 1) 这段代码等同下面两段之和
        
        let userNameObservable = userNameTf.rx.text.orEmpty.asObservable()
    
        let userNameValid = userNameObservable.map{$0.count >= self.minimumUserNameLength}.share(replay:1)
        
        //用户名是否有效 -> 密码输入框是否可用
        userNameValid.bind(to: passwordTf.rx.isEnabled).disposed(by: disposeBag)
        
        //用户名是否有效 -> 用户名提示语是否隐藏
        userNameValid.bind(to: userNameOutlet.rx.isHidden).disposed(by: disposeBag)
        
        //1
        let passwordValid = self.passwordTf.rx.text.orEmpty.map{$0.count >= self.minimumPasswordLength}.share(replay:1)
        
        //订阅 passwordValid的方式1，最原始的方式
        passwordValid.subscribe{
            
            event in
            
//            switch event{
//
//            case .next(let value): break
//            case .completed: break
//            case .error(let err): break
//
//            }
            
            
            print("event",event)
            print("event\(event.element!)")
        }.disposed(by: disposeBag)
        
        //订阅 passwordValid的方式2，常规方式，比较全面
        passwordValid.subscribe(
            
            onNext: {
            
            //这里的next就是个bool值
            [weak self] (element) in
            
            print("next\(element)")
            
                self!.passwordOutlet.isHidden = element
                
           },
            onError:{
                error in
                print(error)
          },
            
            onCompleted:{
                
           },
            onDisposed:{}
            
        )
        .disposed(by: disposeBag)//这样的写法与bindto效果一样，也就能理解了所谓的observable的原理，套壳的KVO
        
        //订阅 passwordValid的方式3， 由于RXCocoa封装了UI层，可以用这个方法来将event与UI绑定
//        passwordValid.bind(to: passwordOutlet.rx.isHidden).disposed(by: disposeBag)
        
        
        //2
        let submitBtnValid = Observable.combineLatest(userNameValid, passwordValid){$0 && $1}.share(replay:1)
        
        submitBtnValid.bind(to: self.submitBtn.rx.isEnabled).disposed(by: disposeBag)
        
        //submitBtn.rx.tap就是个observable，已经由RXCocoa封装，此处直接订阅即可. tap => ControlEventType => ObservableType
        submitBtn.rx.tap.subscribe(
            
            onNext: {
                [weak self] in
//                self?.showAlert()
                
                self?.view.endEditing(true)

                self?.navigationController?.pushViewController(Fifth_MVVM_ViewController(), animated: true)
                
        })
            .disposed(by: disposeBag)
    }
    
    func showAlert(){
        
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


