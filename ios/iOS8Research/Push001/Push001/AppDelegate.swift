//
//  AppDelegate.swift
//  Push001
//
//  Created by JNYJ on 14-10-20.
//  Copyright (c) 2014年 52com. All rights reserved.
//

import UIKit
import Handoff
import Parse
extension NSData {
	func hexString() -> NSString {
		var str = NSMutableString()
		let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
		for byte in bytes {
			str.appendFormat("%02hhx", byte)
		}
		return str
	}
}

let  DEF_parse_appid =  "Ds6ldii9PGNZsjoxc7jOqIsJKYtQJdHWgPpPGkX8"
let  DEF_parse_clientKey =  "U6mXOQZ5uUd7iSYu74ELeDisnqqxCM6H7XeMaPDE"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.

		//{"aps":{"alert":"测试推送的快捷回复", "sound":"default", "badge": 1, "category":"alert"}}
		//
		var	notificationAction_accept =	UIMutableUserNotificationAction()
		notificationAction_accept.identifier = "acceptAction"
		notificationAction_accept.title = "Accept"
		notificationAction_accept.activationMode = UIUserNotificationActivationMode.Foreground

		var notifcationAction_reject = UIMutableUserNotificationAction()
		notifcationAction_reject.identifier =  "rejectAction"
		notifcationAction_reject.title = "reject"
		notifcationAction_reject.activationMode = UIUserNotificationActivationMode.Background
		notifcationAction_reject.authenticationRequired = true
		notifcationAction_reject.destructive = true

		var notification_category = UIMutableUserNotificationCategory()
		notification_category.identifier = "alert"
		notification_category.setActions([notificationAction_accept,notifcationAction_reject], forContext: UIUserNotificationActionContext.Minimal)


		var types: UIUserNotificationType = UIUserNotificationType.Badge |
			UIUserNotificationType.Alert |
			UIUserNotificationType.Sound

		application.registerForRemoteNotifications()
		application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: types,
			categories: NSSet(array: [notification_category])))



		//			application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Alert|UIRemoteNotificationType.Badge|UIRemoteNotificationType.Sound)
		//			UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)
		Parse.setApplicationId(DEF_parse_appid, clientKey: DEF_parse_clientKey)
		//
		return true
	}
	func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

		println("deviceToken---1: \(deviceToken.hexString())");
		println("deviceToken---2: \(deviceToken)");
				PFPush.storeDeviceToken(deviceToken)
				PFPush.subscribeToChannelInBackground("", block: {(value : Bool!, error : NSError!) in
					if (value != nil) {
						println("Successfully subscribed to broadcast channel!")
					}else{
						println("Failed to subscribe to broadcast channel; Error: %@",error);
					}
				})
	}
	func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
		println("注册推送服务时，发生以下错误： %@",error);
	}
	func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {

		UIApplication.sharedApplication().applicationIconBadgeNumber = 1;
		PFPush.handlePush(userInfo)
		println("Message-Notification(%@)",userInfo);

//		UIAlertView(title: "didReceiveRemoteNotification", message: "\(userInfo)", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()

		let alert = UIAlertController(title: "didReceiveRemoteNotification", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
		var var_alertAction: UIAlertAction = UIAlertAction(title: "Warning", style: UIAlertActionStyle.Cancel, handler: { (alertAction: UIAlertAction?) -> Void in
			println("The action sheet's cancel action occured.")
		})
		alert.addAction(var_alertAction)


	}
	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

