//
//  AppDelegate.swift
//  Dec4
//
//  Created by edwin vazquez on 12/4/14.
//  Copyright (c) 2014 A Perfect Empire. All rights reserved.
//

import UIKit;
import AVFoundation;

class ViewController: UIViewController, AVAudioPlayerDelegate {
	let player: AVAudioPlayer?;

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);

		//Find the full pathname of the sound file musette.mp3.
		let bundle: NSBundle = NSBundle.mainBundle();
		var path: String? = bundle.pathForResource("TheWolfMan", ofType: "mp3");
		if path == nil {
			println("could not find path to file TheWolfMan.mp3");
			return;
		}
		println("path = \(path!)\n");

		//Store the full pathname into a url object.
		let url: NSURL? = NSURL(fileURLWithPath: path!, isDirectory: false);
		if url == nil {
			println("could not create URL");
			return;
		}
		println("url = \(url!)\n");

		//Create the audio player.
		var error: NSError?
		player = AVAudioPlayer(contentsOfURL: url!, error: &error);
		if player == nil {
			println("could not create AVAudioPlayer: \(error!)\n");
			return;
		}

		//Configure the audio player.
		//Let the view controller be the delegate of the audio player.
		player!.delegate = self;
		player!.numberOfLoops = 0;	//negative for infinite loop
		player!.pan = 0.0;			//-1.0 is left, +1.0 is right
		println("player!.numberOfChannels = \(player!.numberOfChannels)"); //mono or stereo

		if !player!.prepareToPlay() {	//means if player!.prepareToPlay() == false {
			println("player!.prepareToPlay failed");
		}
		let settings: [NSObject: AnyObject]! = player!.settings;

			for (key, value) in settings {
				if key == AVFormatIDKey {
					let s: Int = value as Int;
					var format: String = "";
					for var i = 3; i >= 0; --i {
						format += String(UnicodeScalar(s >> (i * 8) & 0xFF));
					}
					println("\(key): \(format)");
				} else {
					println("\(key): \(value)");
				}
			}
	}

	//Implant a reference to my own self (i.e., the ViewController)
	//into the newborn View.

	override func loadView() {
		view = View(viewController: self);
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	func valueChanged(mySwitch: UISwitch!) {
		if player == nil {
			return;
		}

		if mySwitch.on {
			//The switch has just been turned on.
			if !player!.play() {
				println("player!.play failed.");
			}
			println("Playing at \(player!.currentTime) of \(player!.duration) seconds.");
		} else {
			//The switch has just been turned off.
			player!.pause();
			println("Paused at \(player!.currentTime) of \(player!.duration) seconds.");
			//Don't need to prepareToPlay again after a pause.
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}