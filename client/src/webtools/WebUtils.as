package webtools 
{
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ww
	 */
	public class WebUtils 
	{
		
		public function WebUtils() 
		{
			
		}
		public static function openPage(url:String="http://baidu.com"):void
		{		
			var a:* = Browser.createElement("A");
			a.href = url;
			a.target = "_blank";
              
            var e:* = Browser.document.createEvent('MouseEvents');  
  
            e.initEvent('click', true, true);  
            a.dispatchEvent(e);  
            trace('event has been changed');  
		}
	}

}