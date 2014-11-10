//
//  ThirtyYearWhoSaveMyselfViewController.swift
//  TTing
//
//  Created by JNYJ on 14-10-30.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//

import UIKit

let DEF_3M : Double = 0.0285
let DEF_3M_per : Double = 4.0
let DEF_3M_times_per : Int = 4

let DEF_6M : Double = 0.0305
let DEF_6M_per : Double = 2.0
let DEF_6M_times_per : Int = 2

let DEF_1Y : Double = 0.0325
let DEF_1Y_per : Double = 1.0
let DEF_1Y_times_per : Int = 1

let DEF_2Y : Double = 0.0375
let DEF_2Y_per : Double = (1.0/2.0)
let DEF_2Y_times_per : Int = 2

let DEF_3Y : Double = 0.0425
let DEF_3Y_per : Double = (1.0/3.0)

let DEF_5Y : Double = 0.0475
let DEF_5Y_per : Double = (1.0/5.0)

class ThirtyYearWhoSaveMyselfViewController: ViewController,UITextViewDelegate,UITextFieldDelegate {

	@IBOutlet var textFiled_money : UITextField!
	@IBOutlet var textFiled_rate : UITextField!
	@IBOutlet var textFiled_cycle : UITextField!
	@IBOutlet var textFiled_year : UITextField!

	@IBOutlet var textFiled_one_time : UITextField!

	@IBOutlet var textView_description: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.textFiled_money.text = "10000"
		self.textFiled_cycle.text = "3"
		self.textFiled_rate.text = "0.0285"
		self.textFiled_year.text = "1"

		self.textFiled_one_time.text = "1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func event_submit(){
		self.textView_description.text =  ""
		//
		var int_money : Int! = self.textFiled_money.text?.toInt()
		var int_cycle : Int! = self.textFiled_cycle.text?.toInt()
		var string_rate : NSString = self.textFiled_rate.text!
		var int_year : Int! = self.textFiled_year.text?.toInt()
		var int_one_time : Int! = self.textFiled_one_time.text?.toInt()
		if let int_ = int_money {
			var string_description = "\n\n Description: ------->"
			//1
			var double_money_per_PO : Double = Double(int_)
			var double_money_per_P : Double = double_money_per_PO
			var double_total_money_F : Double = double_money_per_PO
			var double_total_money_self_F : Double = double_total_money_F
			var is_money_per_month = true

			if let int_ = int_one_time {
				if int_ == 1 {
				}else{
					is_money_per_month = false
				}
			}else{
				is_money_per_month = false
			}

			//Configure values

			var double_per_I : Double  = 0.0
			var double_per_in_I : Double! = string_rate.doubleValue
			var int_times_per : Int = 0
			var int_total_cycle : Int = 0

			if int_cycle < 12 {
				if int_cycle == 3 {
					double_per_I = (double_per_in_I/DEF_3M_per)
					int_times_per = DEF_3M_times_per
					int_total_cycle = (int_times_per*int_year)
				}else if int_cycle == 6 {
					double_per_I = (double_per_in_I/DEF_6M_per)
					int_times_per = DEF_6M_times_per
					int_total_cycle = (int_times_per*int_year)
				}
			}else if int_cycle == 12 {
				double_per_I = (double_per_in_I/DEF_1Y_per)
				int_times_per = DEF_1Y_times_per
				int_total_cycle = (int_times_per*int_year)
			}
			//Set values   expect
			string_description = string_description + "\n\n ------->values expect<-------"
			//
			var double_money_per_PO_cycle : Double = double_money_per_PO*Double(int_cycle)
			double_total_money_F = double_money_per_PO_cycle
			double_total_money_self_F = double_total_money_F
			//x`
			if is_money_per_month {

				for index in 1...int_total_cycle {
					/*
					P = PO
					F = P

					1 P = F+F*I
					2 F = P + PO
					*/
					double_money_per_P = double_total_money_F + double_total_money_F * double_per_I
					double_total_money_F = double_money_per_P
					string_description = string_description + "\n\n ---one record---\(double_money_per_P)"
					//
					if index == int_total_cycle {
						break
					}
					double_total_money_F += double_money_per_PO_cycle
					double_total_money_self_F += double_money_per_PO_cycle

				}
			}else{
				for index in 1...int_total_cycle {
					/*
					P = PO
					F = P

					1 P = F+F*I
					*/
					double_money_per_P = double_total_money_F + double_total_money_F * double_per_I
					double_total_money_F = double_money_per_P
					string_description = string_description + "\n\n ---one record---\(double_money_per_P)"
					//
					if index == int_total_cycle {
						break
					}
				}
			}


			string_description = string_description + "\n\n ------------------------------------------------------------------------------ \n\n"

			var string_end = "------->Total cash: (\(double_total_money_F)-(G: \(double_total_money_F-double_total_money_self_F)))<-------\n------->Total cash in: (\(double_total_money_self_F))<-------\n-------> (\(double_total_money_self_F/double_total_money_F)) <-------"

			println(string_end)

			string_description = string_description + string_end

			string_description = string_description + "\n\n ------------------------------------------------------------------------------ \n\n"
			//Set values  real
			string_description = string_description + "\n\n ------->values real<-------"
			//

			//
			var array_total_money_F : NSMutableArray = NSMutableArray()
			var is_end_of_cycle : Bool = false
			var int_total_cycle_per_month : Int = int_total_cycle*int_cycle
			var is_need_log : Bool = false
			double_total_money_self_F = 0.0
			if is_money_per_month {

				for index in 1...int_total_cycle_per_month {
					is_need_log =  (index==int_total_cycle_per_month) ? true :  false
					/*
					F = 0.0
					+ PO1 =  if end_of_cycle{PO(1+i)}else{PO}    // per three month
					+ PO2 =  if end_of_cycle{PO(1+i)}else{PO}    // per three month
					+ PO3 =  if end_of_cycle{PO(1+i)}else{PO}    // per three month
					+ PO4 =  if end_of_cycle{PO(1+i)}else{PO}    // per three month
					+ PO5 =  if end_of_cycle{PO(1+i)}else{PO}    // per three month
					...
					*/
					array_total_money_F.insertObject(NSNumber(double: double_money_per_PO), atIndex: 0)

					double_total_money_F = 0.0
					double_total_money_self_F += double_money_per_PO
					for var i : Int =  0; i < array_total_money_F.count; ++i {
						is_end_of_cycle =   ((i+1)%int_cycle==0) ? true : false
						double_money_per_P = Double(array_total_money_F[i] as NSNumber)
						if is_end_of_cycle {

							double_money_per_P = double_money_per_P + double_money_per_P * double_per_I
							//
							array_total_money_F[i] = NSNumber(double: double_money_per_P)
							//
							if is_need_log {
								string_description = string_description + "\n\n ----------------------------->\(double_money_per_P)"
							}
						}else{
							if is_need_log {
								string_description = string_description + "\n\n ----------------------------->\(double_money_per_P)"
							}
						}
						double_total_money_F += double_money_per_P
					}
					string_description = string_description + "\n\n ---one record---\(double_total_money_F)"
//					//
//					if index == int_total_cycle {
//						break
//					}
//					double_total_money_F += double_money_per_PO
//					double_total_money_self_F += double_money_per_PO

				}
			}else{
				for index in 1...int_total_cycle {
				}
			}
			//


			string_description = string_description + "\n\n ------------------------------------------------------------------------------ \n\n"

			string_end = "------->Total cash: (\(double_total_money_F)-(G: \(double_total_money_F-double_total_money_self_F))-(Others\(double_money_per_P-double_money_per_PO))--Total(\(double_total_money_F+double_money_per_P-double_money_per_PO)))<-------\n------->Total cash in: (\(double_total_money_self_F))<-------\n-------> (\(double_total_money_self_F/double_total_money_F)) <-------"

			println(string_end)

			string_description = string_description + string_end

			string_description = string_description + "\n\n ------------------------------------------------------------------------------ \n\n"


			//
			string_description = string_description + "\n\n <-------END Description"
			//
			self.textView_description.text =  string_description
		}
		//
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	//MARK: delegates

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	func textViewShouldEndEditing(textView: UITextView) -> Bool {
		textView.resignFirstResponder()
		return true
	}
}
