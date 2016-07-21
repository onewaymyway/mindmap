package wwlayout.treelayout 
{
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	/**
	 * ...
	 * @author ww
	 */
	public class TreeData 
	{
		
		public function TreeData() 
		{
			
		}
		public var data:Object={};
		public var childsR:Array = [];
		public var childsL:Array = [];
		public var displayItem:TreeRender;
		public var rec:Rectangle = new Rectangle();
		public var childsRec:Rectangle = new Rectangle();
		public var totalRec:Rectangle = new Rectangle();
		public var isOpen:Boolean = true;
		public var tarPos:Point = new Point();
		
		public var pos:Point = new Point();
		
		public static function changeSide(tree:TreeData):void
		{
			var tArr:Array;
			tArr = tree.childsR;
			tree.childsR = tree.childsL;
			tree.childsL = tArr;
		}
		public static function toSide(tree:TreeData,isRight:Boolean):void
		{
			if (isRight)
			{
				tree.childsR.concat(tree.childsL);
			}else
			{
				tree.childsL.concat(tree.childsR);
			}
		}
		
		public static function createTestTree():TreeData
		{
			var rst:TreeData;
			rst = getATreeData();
			var childs:Array;
			childs = rst.childsR;
			var tArr:Array;
			tArr=addChilds(rst,5);
			addChilds(tArr[2], 4);
			tArr = addChilds(tArr[4], 5);
			addChilds(tArr[0], 4);
			addChilds(tArr[2], 4);
			
			return rst;
		}
		public static const TestTreeO:Object = 
		{
			childsR:
				[
				  {},
				  {
					  childsR:
						  [
						    
						  ]
				   },
				  {},
				  {},
				  {},
				  {}
				]
		};
		public static function getATreeData():TreeData
		{
			return new TreeData();
		}
		public static function addChilds(treeData:TreeData, count:int = 3):Array
		{
			var childs:Array;
			childs = treeData.childsR;
			var i:int, len:int;
			len = count;
			for (i = 0; i < len; i++)
			{
				childs.push(getATreeData());
			}
			return childs;
		}
	}

}