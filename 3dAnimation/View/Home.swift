//
//  Home.swift
//  3dAnimation
//
//  Created by Nazar Babyak on 17.12.2021.
//

import SwiftUI

struct Home: View {
    @StateObject  var motionData = MotionObserver()
    
    @GestureState var scale: CGFloat = 1.0
    var body: some View {
        
        
        
        ZStack{
            if #available(iOS 15.0, *) {
                GeometryReader{ proxy in
                    
                    
                    let size = proxy.size
                    
                    Image("aaa")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(0)
                    
                    Color.black
                        .opacity(0.05)
                    
                }
                //розмиття
                .overlay(.ultraThinMaterial)
                .ignoresSafeArea()
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image("aaa")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(motionData.movingOffSet)
                        .frame(width: size.width, height: size.height)
                        
                        
                        .scaledToFill()
                        .cornerRadius(33)
                        .scaleEffect(scale)
                        .gesture(MagnificationGesture()
                                    .updating($scale, body: {
                            (value, scale, trans) in
                            scale = value.magnitude
                        })
                        )
                        
                    
                    
                }
                
                
                
                .frame(height: 500)
                .cornerRadius(25)
                .padding(.horizontal, 40)
                
                //Застосовуємо offset тут щоб
                //глянути так, ніби він рухається в режимі реального часу moving data...
                .offset(motionData.movingOffSet)
                
            } else {
                
            }
            
            
        }
        //Calling Motion Updater with duration
        .onAppear(perform: {
            motionData.fetchMotionData(duration: 30)
        })
        
        .environment(\.colorScheme, .dark)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
