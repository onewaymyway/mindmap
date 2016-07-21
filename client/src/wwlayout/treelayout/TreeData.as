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
		//public var childsRec:Rectangle = new Rectangle();
		public var totalRec:Rectangle = new Rectangle();
		public var isOpen:Boolean = true;
		public var tarPos:Point = new Point();
		public var parent:TreeData;
		public var side:int = 0;
		public static const Left:int = 1;
		public static const Right:int = 0;
		public static const Both:int = 2;
		
		public var pos:Point = new Point();
		public function getChildsBySide(side:int):void
		{
			switch(side)
			{
				case Left:
					return childsL;
					break;
				case Right:
					return childsR;
					break;	
			}
			return null;
		}
		public function addChild(child:TreeData, side:int):void
		{
			var childs:Array;
			childs = getChildsBySide(side);
			if (childs)
			{
				child.parent = this;
				child.side = side;
				childs.push(child);
			}else
			{
				trace("Fail to addChild:",side,child,this);
			}
		}
		public function removeChild(child:TreeData):void
		{
			var tArr:Array;
			var index:int;
			tArr = childsL;
			index = tArr.indexOf(child);
			if (index >= 0)
			{
				tArr.splice(index, 1);
			}
			tArr = childsR;
			index = tArr.indexOf(child);
			if (index >= 0)
			{
				tArr.splice(index, 1);
			}
		}
		public function removeSelf():void
		{
			if (parent)
			{
				parent.removeChild(this);
				this.parent = null;
			}
		}
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
		public static function adptTree(tree:TreeData, parent:TreeData = null,side:int=Both):void
		{
			tree.parent = parent;
			tree.side = side;
			var childs:Array;	
			var i:int, len:int;
			childs = tree.childsR;
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				adptTree(childs[i],tree,Right);
			}
			childs = tree.childsL;
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				adptTree(childs[i],tree,Left);
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