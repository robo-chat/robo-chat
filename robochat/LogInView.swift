//
//  LogInView.swift
//  robochat
//
//  Created by xiao on 2020/6/20.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI
let btnBgColor = Color(red: 231/255.0, green:231.0/255.0, blue:231.0/255.0,opacity:1.0)

struct LogInView: View{
    
    @State var account : String = ""
    @State var password : String = ""
    
    var body : some View {
        ZStack{
            VStack{
                Color(red:250/255.0,green:250/255.0,blue:250/255.0)
            }
            VStack(alignment: .leading){
                Text("微信号/QQ/邮箱登录").font(.title).padding(.top, 40.0)
                HStack{
                    Text("账号")
                    TextField("请填写微信号/QQ号/邮箱",text: $account).padding(.leading, 20.0).frame(width:300.0)
                }
                .padding(.top, 25.0)
                Divider()
                    .padding(.trailing, 20.0)
                HStack(alignment: .top){
                    Text("密码")
                    TextField("请填写密码",text: $password).padding(.leading, 20.0).frame(width:200)
                }
                Divider()
                    .padding(.trailing, 20.0)
                Text("用手机号登录").foregroundColor(.blue).padding(.vertical, 20)
                HStack{
                    Button(action: {
                        
                        }){
                            Text("登录").frame(width: 335.0,height: 50)
                                .foregroundColor(Color.gray).background(btnBgColor).cornerRadius(5)
                    }
                
                }
                Spacer()
                HStack(){
                    Text("找回密码")
                        .font(.caption)
                        .foregroundColor(Color.blue)
                    Divider().frame(height:10)
                    Text("紧急冻结")
                        .font(.caption)
                        .foregroundColor(Color.blue)
                    Divider().frame(height:10)
                    Text("微信安全中心")
                        .font(.caption)
                        .foregroundColor(Color.blue)
                }
                .padding(.bottom, 20.0).frame(width: 335)
                
            }
            .padding(.leading, 20.0)
            
        }
    
    }
    
    
}



struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
