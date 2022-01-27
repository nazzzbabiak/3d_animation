//
//  MotionObserver.swift
//  3dAnimation
//
//  Created by Nazar Babyak on 17.12.2021.
//

// імрортуємо CoreMotion

import SwiftUI

import CoreMotion

class MotionObserver: ObservableObject {
    
    
    @Published var motionManager = CMMotionManager()
    
    //Storing Motion Data для анімації перегляду в paralaxx...
    //role -> X-Axis
    //pitch -> Y-Axis
    
    @Published var xValue: CGFloat = 0
    @Published var yValue: CGFloat = 0
    @Published var movingOffSet: CGSize = .zero
    

     
    func fetchMotionData(duration: CGFloat){
        
        motionManager.startDeviceMotionUpdates(to: .main) {
            data, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else{
                print("ERROR IN DATA")
                return
                
            }
            withAnimation(.timingCurve(0.18, 0.78, 0.18, 1, duration: 0.77)){
                self.xValue = data.attitude.roll
                self.yValue = data.attitude.pitch
                self.movingOffSet = self.getOffset(duration: duration)
                
            }
        
         
    }

}
    func getOffset(duration: CGFloat)->CGSize{
         
        var widht = xValue * duration
        var  height = yValue * duration
         
        widht = (widht < 0 ? (-widht > 30 ? -30 : widht) : (widht > 30 ? 30 : widht))
        height = (height < 0 ? (-height > 30 ? -30 : height) : (height > 30 ? 30 : height))
        
        return CGSize(width: widht , height: height)
    }
}

