---
sidebar: auto
---
# 内部类
内部类是定义在另一个类中的类。使用内部类的三种主要的原因是：
* 内部类可以对同一个包的其他类隐藏起来
* 内部类方法可以访问该类定义所在的作用域中的数据，包括私有数据
* 当想要定义一个回调函数且不想编写大量代码时，使用匿名内部类比较方便

## 内部类访问机制
1.访问方式
为了能够运行正常的运行程序，内部类的对象总有一个隐式的引用，它指向创建它的外部类对象。
  使用外围类引用
   `OuterClass.this`
  外围类的作用域之外引用内部类
   `OuterClass.InnerClass`
2.实现机制
    内部类是一种编译器现象，与虚拟机无关。编译器会把内部类翻译成用$分割外部类名与内部类名的常规类文件。
例如:
```java
class TalkingClock2//时钟
{
       private int interval;

       private boolean beep;

       public TalkingClock2(int interval,boolean beep){
             this.beep=beep;
             this.interval=interval;
       }

       class TimePrinter implements ActionListener{//时间监听器
            @Override
             public void actionPerformed(ActionEvent e) {
                    Date now=new Date();
                    System.out.println("At the tone, the time is " + now);
                    if(beep)Toolkit.getDefaultToolkit().beep();
             }             
       }
       
       public void start(){
             Timer timer=new Timer(interval, new TimePrinter());

             timer.start();
       }
}
```
javacore.inner.TalkingClock2$TimePrinter
```java
class javacore.inner.TalkingClock2$TimePrinter
{
   javacore.inner.TalkingClock2$TimePrinter(javacore.inner.TalkingClock2);

   public void actionPerformed(java.awt.event.ActionEvent);
   
   final javacore.inner.TalkingClock2 this$0;//对应外围类
}
```
编译器为了引用外围类建立一个this$0
外围类添加静态方法确保内部类可以访问到外围类中的任意成员
```java
class javacore.inner.TalkingClock2
{
   public javacore.inner.TalkingClock2(int, boolean);

   public void start();

   static boolean access$0(javacore.inner.TalkingClock2);//对应beep属性

   private int interval;
   
   private boolean beep;
}
```
 access$0将返回外围类的beep属性的属性值
 ![2f0ebf0cd74af5fb3d72185acd3dfb02.png](en-resource://database/1256:0)
 
 ## 定义内部类的几种用法
 1.局部内部类
 在方法中定义内部类
 ```java
     public void start(int interval, final boolean beep)
   {
        //仅start方法可以访问TimePrinter类
      class TimePrinter implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
            Date now = new Date();
            System.out.println("At the tone, the time is " + now);
            if (beep) Toolkit.getDefaultToolkit().beep();
         }
      }
      ActionListener listener = new TimePrinter();
      Timer t = new Timer(interval, listener);
      t.start();
   }
```
局部内部类可以访问方法的局部变量，但此变量必须设置为final类型
```java
class javacore.inner.TalkingClock$1TimePrinter
{
   javacore.inner.TalkingClock$1TimePrinter(javacore.inner.TalkingClock, 
boolean);
   public void actionPerformed(java.awt.event.ActionEvent);
   final javacore.inner.TalkingClock this$0;
   private final boolean val$beep;//对应局部变量beep
}
```
 2.匿名内部类
 实现接口或继承类的同时建立对象
 ```java
  public void start(int interval, final boolean beep)
   {
      ActionListener listener = new ActionListener()
         {
            public void actionPerformed(ActionEvent event)
            {
               Date now = new Date();
               System.out.println("At the tone, the time is " + now);
               if (beep) Toolkit.getDefaultToolkit().beep();
            }
         };
      Timer t = new Timer(interval, listener);
      t.start();
   }
```
 3.静态内部类
 将类隐藏于外围类，但不调用外围类的成员
 用static修饰内部类
 