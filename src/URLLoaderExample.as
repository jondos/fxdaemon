package {
    import flash.display.Sprite;
    import flash.events.*;
    import flash.net.*;

    public class URLLoaderExample {
        public function URLLoaderExample() {
            var loader:URLLoader = new URLLoader();
            configureListeners(loader);

            var request:URLRequest = new URLRequest("http://what-is-my-ip-address.anonymous-proxy-servers.net/iptools?ip=1&method=FLASH");
            try {
                loader.load(request);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
        }
		
		private function traceArray(arr:Array):void{
			for( var i:Number = 0; i < arr.length; i++){			
				trace(arr[i]);			
			}
		}

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void {
            var loader:URLLoader = URLLoader(event.target);
            //trace("completeHandler: " + loader.data);
			
			var codedString:String = loader.data;
			var decodedString:String = Base64.decode(codedString).toString();
			
			var strArr:Array = new Array();
			//trace(typeof(decodedString));
			strArr = decodedString.split(";");
			//traceArray(strArr);

        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
    }
}
