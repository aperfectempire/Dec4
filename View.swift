//
//  View.swift
//  Dec4
//
//  Created by edwin vazquez on 12/4/14.
//  Copyright (c) 2015 A Perfect Empire. All rights reserved.
//

import UIKit

class View: UIView {

	//Called by the ViewController.

	init(viewController: ViewController) {
		//This dummy frame will soon be replaced by the real frame.
		super.init(frame: CGRectZero);

		// Initialization code
		backgroundColor = UIColor.whiteColor();

		//Center the switch in this View,
		let mySwitch: UISwitch = UISwitch(); //but don't give it a size.
		mySwitch.center = center;

		//Keep the switch centered in this View,
		//even when the size of the View changes.

		mySwitch.autoresizingMask =
			UIViewAutoresizing.FlexibleLeftMargin
			| UIViewAutoresizing.FlexibleRightMargin
			| UIViewAutoresizing.FlexibleTopMargin
			| UIViewAutoresizing.FlexibleBottomMargin;

		mySwitch.addTarget(viewController,
			action: "valueChanged:",
			forControlEvents: UIControlEvents.ValueChanged
		);

		addSubview(mySwitch);
	}

	//Not called.
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}

	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect)
	{
		// Drawing code
	}
	*/

}
