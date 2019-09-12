//
//  FifthViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/9.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

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
        
        passwordValid.bind(to: passwordOutlet.rx.isHidden).disposed(by: disposeBag)
        
        
        //2
        let submitBtnValid = Observable.combineLatest(userNameValid, passwordValid){$0 && $1}.share(replay:1)
        
        submitBtnValid.bind(to: self.submitBtn.rx.isEnabled).disposed(by: disposeBag)
        
        submitBtn.rx.tap.subscribe(onNext: { [weak self] in self?.showAlert() })
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
