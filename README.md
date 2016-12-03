#WWDC2016 Session 707 - Introduction to Notifications
> 视频地址：[传送门](https://developer.apple.com/videos/play/wwdc2016/707/)
>
> 字幕：[传送门](http://asciiwwdc.com/2016/sessions/707)

----------
#### 现有通知API的缺点：
1、本地通知和远程通知用的是两套回调方法

2、可控性差，比如无法控修改已在调度队列中的通知，换句话说就是发出去的通知等于泼出去的水。
#### 新通知框架的优点：
1、与旧API相似

2、内容易扩展，可发送的内容更丰富

3、本地与远程通知统一处理，减少了重复代码

4、通知更容易管理，比如在代理方法中更改通知内容

5、可以在扩展中处理通知（不知道这个怎么玩儿）

6、支持🍎多平台（iOS、watchOS、tvOS）

以前是通过别的设备建立连接，然后通知才能转到watch上，现在可以在watchOS上添加本地通知了，比如手机上装了一个锻炼app，但是锻炼时没带着手机，戴着watch呢，当用户完成训练时依然能够发送完成训练的通知。

> 至于watchOS如何进行通知，🍎没说，只是说他们是利用`Quick Interaction Techniques`实现的。

### 进入正题
应用先注册通知来获取用户的授权（本地通知也需要）。



## 推荐文章：
+ [活见久的重构 - iOS 10 UserNotification 框架解析](http://onevcat.com/2016/08/notification/)
+ [WWDC2016 Session笔记 - iOS 10  推送Notification新特性](http://www.jianshu.com/p/9b720efe3779)
