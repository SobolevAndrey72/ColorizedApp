//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet var redEdit: UITextField!
    @IBOutlet var greenEdit: UITextField!
    @IBOutlet var blueEdit: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
 
    
    // MARK: - Public Properties
    var sendColor : UIColor!
    var delegate :  SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        colorView.backgroundColor = sendColor
     
        setSliders()
        setColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redEdit.text = string(from: redSlider)
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenEdit.text = string(from: greenSlider)
            greenLabel.text = string(from: greenSlider)
        default:
            blueEdit.text = string(from: blueSlider)
            blueLabel.text = string(from: blueSlider)
        }
    }
    
    @IBAction func buttonDone() {
        view.endEditing(true)
        delegate?.setProtoColor(colorView.backgroundColor ?? .gray)
        dismiss(animated: true)
    }
    
    @IBAction func endEdit(_ sender: UITextField ) {
        
        guard let text =  sender.text  // redEdit.text
        else { showAlert(title: "Внимание!", message: "Нет ввода!", textField: sender)
               return }
        guard let number = Float(text)
        else {  showAlert(title: "Внимание!", message: "Введите число!", textField: sender)
                return }
        if !validEnter(number: number) {
            showAlert(title: "Внимание!", message: "Введите число от 0 до 1", textField: sender)
            return
        }
        
        switch sender {
        case redEdit:
            redSlider.value = number
            redLabel.text = string(from: redSlider)
        case greenEdit:
            greenSlider.value = number
            greenLabel.text = string(from: greenSlider)
        default:
            blueSlider.value = number
            blueLabel.text = string(from: blueSlider)
        }
    }
    
    
    // MARK: - Private Properties
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                textField?.text = "?"
            }
            alert.addAction(okAction)
            present(alert, animated: true)
    }
    
    private func validEnter( number: Float) -> Bool {
        number <= 1 && number >= 0
    }
        
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redEdit.text = string(from: redSlider)
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenEdit.text = string(from: greenSlider)
                greenLabel.text = string(from: greenSlider)
            default:
                blueEdit.text = string(from: blueSlider)
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setSliders() {
        let convColor = CIColor(color: sendColor)
        
        redSlider.value = Float(convColor.red)
        greenSlider.value = Float(convColor.green)
        blueSlider.value = Float(convColor.blue)
    }
}

extension SettingViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
