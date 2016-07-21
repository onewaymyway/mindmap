package wwlayout.treelayout 
{
	import laya.display.Sprite;
	import laya.events.Event;
	/**
	 * ...
	 * @author ww
	 */
	public class TreeRender extends Sprite
	{
		public var data:TreeData;
		public var layout:TreeLayout;
		public function TreeRender() 
		{
			size(100, 30);
			this.graphics.drawRect(0, 0, this.width, this.height, "#ff00ff");
			//on(Event.CLICK, this, onMouseClick);
			on(Event.CLICK, this, onRightClick);
		}
		private function onMouseClick():void
		{
			data.isOpen = !data.isOpen;
			layout.fresh();
		}
		private function onRightClick():void
		{
			trace("rightClick");
			TreeData.addChilds(data, 1);
			if (!data.isOpen) data.isOpen = true;
			layout.fresh();
		}
	}

}