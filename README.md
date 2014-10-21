a simple class which can prevent application crash due to unrecognized selector.
All code shared,you can use it in anywhere.

The introductin of simple principle:
if a object cannot find the selector in it's own class and it's parent class,it will look for dynamic method by runtime,if not too,it will forward into the message,the default message forwarding are inherited NSObject,is to throw an exception,then the end.
Here to do is application startup replaced the NSObject forward function,make it not throw an exception.
