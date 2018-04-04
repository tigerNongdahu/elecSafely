//
//  ElecAPIHeader.h
//  ElecSafely
//
//  Created by Tianfu on 01/02/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#ifndef ElecAPIHeader_h
#define ElecAPIHeader_h

#define FrigateAPI_Login_Check @"http://www.frigate-iot.com/data/login_chk.php"

/*加载热点问题的url*/
#define FrigateAPI_Help_AnswerForAsk @"http://www.frigate-iot.com/MonitoringCentre/MsgCenter/InformationList.php"

/*意见反馈的url*/
#define FrigateAPI_SubmitAsk @"http://www.frigate-iot.com/MonitoringCentre/MsgCenter/SubmitAsk.php"

/*修改密码*/
#define FrigateAPI_ChangePW @"http://www.frigate-iot.com/MonitoringCentre/Data/ChangePW.php"

/*设备注册*/
#define FrigateAPI_Register @"http://www.frigate-iot.com/API/Register.php"

/*公告列表*/
#define FrigateAPI_loadNotice @"http://www.frigate-iot.com/MonitoringCentre/Data/loadNewNotice.php"

/*公告内容*/
#define FrigateAPI_noticeContent(noticeID) ([NSString stringWithFormat:@"http://www.frigate-iot.com/MonitoringCentre/Data/loadNoticeContent.php?ID=%@",noticeID])

#endif /* ElecAPIHeader_h */
