//
//  ViewController.swift
//  ImagePicker
//
//  Created by Seungjun Lim on 21/05/2019.
//  Copyright © 2019 Seungjun Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var images: [UIImage] = {
        return (0...6).compactMap { UIImage(named: "slot-machine-\($0)")}
    }()
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBAction func shuffle(_ sender: Any?) {
        let firstIndex = Int(arc4random_uniform(UInt32(images.count))) + images.count
        let secondIndex = Int(arc4random_uniform(UInt32(images.count))) + images.count
        let thirdIndex = Int(arc4random_uniform(UInt32(images.count))) + images.count
        
        picker.selectRow(firstIndex, inComponent: 0, animated: true)
        picker.selectRow(secondIndex, inComponent: 1, animated: true)
        picker.selectRow(thirdIndex, inComponent: 2, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.isUserInteractionEnabled = false
        
        // 이 메소드를 호출하는 시점에 피커뷰의 데이터가 모두 구성되지 않았을수도 있기때문에 바로전에 모든컴포넌트를 리프레쉬 하는 코드 추가
        picker.reloadAllComponents()
        // 화면진입시점에도 렌덤으로 표시되도록 한다.
        // 셔플메소드를 직접호출하려면 전달할 아규먼트가 필요합니다.
        // 버튼을 아울렛으로 연결하고 아울렛을 연결하는것도 가능하고, 파라미터 형식을 옵셔널로 선언하고, nil을 전달하는것도 가능합니다.
        shuffle(nil)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count * 3
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if let imgView = view as? UIImageView {
            imgView.image = images[row % images.count]
            return imgView
        }
        
        let imgView = UIImageView()
        imgView.image = images[row % images.count]
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}

