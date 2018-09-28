# IOSToUnity

ios和unity交互

unity端和ios端定义好方法名，ios实现之后，unity即可调用

注意：

unity端传过来的string参数，ios端必须分配空间，否则会造成内存泄漏崩溃

            strdup(parameterString)
            
并且必须在之前使用parameterString

ios端调用unity方法：
            
            UnitySendMessage("objectName", "functionName", "parameter");

