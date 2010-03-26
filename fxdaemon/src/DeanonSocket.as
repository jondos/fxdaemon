package {

	import flash.display.Sprite;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.Socket;
	import org.osflash.thunderbolt.Logger;
	//import Main;

	public class DeanonSocket extends Socket {
		
		public var response:String;

		public function DeanonSocket(host:String = null, port:uint = 0) {
			super();
			configureListeners();
			if (host && port)  {
				super.connect(host, port);
			}
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
				Logger.error(e.getStackTrace());
			}
		}

		private function sendRequest():void {
			Logger.debug("sendRequest");
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
			//trace("DeAnonSock_closeHandler: " + event);
			Logger.debug("DeAnonSock_dispatchDataEvent(1): " + response.toString());
			var deAnonMsg:DataEvent = new DataEvent(DataEvent.DATA);
			deAnonMsg.data = response.toString();
			Logger.debug("DeAnonSock_dispatchDataEvent(2): " + deAnonMsg.data);
			dispatchEvent(deAnonMsg);
		}

		private function connectHandler(event:Event):void {
			Logger.debug("DeAnonSock_connectHandler: " + event);
			sendRequest();
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			Logger.error("DeAnonSock_ioErrorHandler: " + event);
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			Logger.error("DeAnonSock_ecurityErrorHandler: " + event);
		}

		private function socketDataHandler(event:ProgressEvent):void {
			Logger.debug("DeAnonSock_socketDataHandler: " + event);
			readResponse();
		}
	}
}