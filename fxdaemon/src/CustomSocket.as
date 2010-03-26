package {
	
import flash.errors.*;
import flash.events.*;
import flash.net.Socket;
import Main;

class CustomSocket extends Socket {
    public var response:String;
	//private caller:Applicatoin;
	
    public function CustomSocket(host:String = null, port:uint = 0) {
        
		
		super();
        configureListeners();
        if (host && port)  {
            super.connect(host, port);
        }
    }
	
	public function getRawResponse():String {
		trace("call to getRawResponse():String");
		return this.response;
	}

    private function configureListeners():void {
        addEventListener(Event.CLOSE, closeHandler);
        addEventListener(Event.CONNECT, connectHandler);
        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
    }

    private function writeln(str:String):void {
        str += "\n";
        try {
            writeUTFBytes(str);
        }
        catch(e:IOError) {
            trace(e);
        }
    }

    private function sendRequest():void {
        trace("sendRequest");
        response = "";
        //writeln("GET /iptools?ip=1&method=JAVA");
		writeln("GET /apache2-default/srv/infoip.php");
        flush();
    }

    private function readResponse():void {
        var str:String = readUTFBytes(bytesAvailable);
        response += str;
		
    }

    private function closeHandler(event:Event):void {
        trace("closeHandler: " + event);
        trace(response.toString());
    }

    private function connectHandler(event:Event):void {
        trace("connectHandler: " + event);
        sendRequest();
    }
	
	private function socketDataHandler(event:ProgressEvent):void {
        trace("socketDataHandler: " + event);
        readResponse();
    }

    private function ioErrorHandler(event:IOErrorEvent):void {
        trace("ioErrorHandler: " + event);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void {
        trace("securityErrorHandler: " + event);
    }

   
}
}