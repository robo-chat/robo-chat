//
//  LogInView.swift
//  robochat
//
//  Created by xiao on 2020/6/20.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI//引入swiftui组件  375*667
let btnBgColor = Color(red: 231/255.0, green:231.0/255.0, blue:231.0/255.0,opacity:1.0)//声明按钮背景色-常量，可以放在配置文件里面读取

struct LogInView: View{//定义 登录 界面的结构体
    
    @State var account : String = ""//声明属性装置器，记录账号数据
    @State var password : String = ""//声明属性装置器，记录密码数据
    
    var body : some View {
        ZStack{//覆盖视图，解决z轴布局
            VStack{//垂直视图，y轴方向布局
                Color(red:250/255.0,green:250/255.0,blue:250/255.0)//定义背景色
            }
            VStack(alignment: .leading){//垂直方向视图-左对齐
                Text("微信号/QQ/邮箱登录").font(.title).padding(.top, 40.0)//设置上边距
                HStack{
                    Text("账号")
                    TextField("请填写微信号/QQ号/邮箱",text: $account).padding(.leading, 20.0).frame(width:300.0)//textfield 输入框 frame 组件大小
                }
                .padding(.top, 25.0)
                Divider()//分割线 根据视图确认
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
                Spacer()//自适应留白空间，两个组件之间，根据位置
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
