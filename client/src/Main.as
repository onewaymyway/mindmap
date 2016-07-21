package 
{
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.events.Event;
	import webtools.WebUtils;
	import wwlayout.treelayout.TreeData;
	import wwlayout.treelayout.TreeLayout;

	
	/**
	 * ...
	 * @author ww
	 */
	public class Main
	{
		
		public function Main():void 
		{

			Laya.init(1000, 900);
			Laya.stage.scaleMode = Stage.SCALE_FULL;
			//test();
			testTreeLayout();
		}
		private function testTreeLayout():void
		{
			var treeLayout:TreeLayout;
			treeLayout = new TreeLayout();
			Laya.stage.addChild(treeLayout);
			treeLayout.pos(400, 400);
			treeLayout.layoutData(TreeData.createTestTree());
			
			treeLayout = new TreeLayout();
			//Laya.stage.addChild(treeLayout);
			treeLayout.pos(100, 400);
			treeLayout.layoutData(TreeData.createTestTree(),false);
		}
		private function test():void
		{
			var sp:Sprite; 
			sp = new Sprite();
			sp.size(100, 100);
			sp.graphics.drawRect(0, 0, 100, 100, "#ff0000");
			Laya.stage.addChild(sp);
			sp.pos(100, 100);
			sp.on(Event.CLICK, this, spClick);
		}
		
		private function spClick():void
		{
			WebUtils.openPage("http://baidu.com");
		}

	}
	
}