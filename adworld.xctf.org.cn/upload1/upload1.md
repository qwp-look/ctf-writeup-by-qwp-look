upload1
[原理]
浏览器绕过验证

[目的]
了解文件上传漏洞

[环境]
windows 11 LTSC

[工具]
edge
AntSword

[步骤]
1.发现这是一个文件上传界面

2.查看源码

3.尝试上传

4.发现只允许图片

5.在代码中发现"
 

Array.prototype.contains = function (obj) {  
    var i = this.length;  
    while (i--) {  
        if (this[i] === obj) {  
            return true;  
        }  
    }  
    return false;  
}  

function check(){
upfile = document.getElementById("upfile");
submit = document.getElementById("submit");
name = upfile.value;
ext = name.replace(/^.+\./,'');

if(['jpg','png'].contains(ext)){
	submit.disabled = false;
}else{
	submit.disabled = true;

	alert('请选择一张图片文件上传!');
}


}
"
6.尝试将'jpg','png'改成php，上传木马

7.写一个php后门程序 见1.php 或图4

8.尝试上传

9.失败见图5

10.思考：见到文件已经在那了 见图6

11.想怎么上传，因为上传按钮已经不允许点击了 见图6

12.想到重新激活按钮 见图7

13.将disable 改为able 见图8

14.又可以点了 嘿嘿 见图8

15.试一下

16.成功上传 见图9

17.尝试使用AntSword进行连接 见图10

18.填写内容 见图11

19.成功连接 见图12

20浏览文件 见图13

21发现flag 见图14

22.找到flag 见图15 嘿嘿
[图片]
1.![alt text]({CD0D831A-A61D-4032-90E6-4C877636C84A}.png)

2.![alt text](image.png)

3.![alt text](image-1.png)

4.![alt text](image-2.png)

5.![alt text](image-3.png)

6.![alt text](image-4.png)

7.![alt text](image-5.png)

8.![alt text](image-6.png)

9.![alt text](image-7.png)

10.![alt text]({51FA584C-BC15-4404-9E6A-6ECA30E5CD69}.png)

11.![alt text]({B457BF8F-4ED2-4709-85D0-5D495C640333}.png)

12.![alt text]({465C9A27-DF30-4C39-94D0-F270542364B7}.png)

13.![alt text]({86CED542-67CC-47C7-9538-5269C3966820}.png)

14.![alt text]({1D38A005-3402-443B-A305-099CB327C9CF}.png)

15.![alt text]({44484FE2-0598-4C8A-9789-1E5BD8092A3D}.png)
[答案]
cyberpeace{45bb2e0db6e44c01230c81c98671dbee}