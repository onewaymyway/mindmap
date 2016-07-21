package wwlayout.treelayout
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TreeLayout extends Sprite
	{
		public static const StatuChange:String = "StatuChange";
		public function TreeLayout()
		{
		
		}
		public var offX:int = 20;
		public var offY:int = 10;
		public var root:TreeData;
		
		public function layout():void
		{
			cleanNodes();
			
			
			g = this.graphics;
			g.clear();
			var side:Boolean;
			side = false;
			measureRec(root,side);
			renderData(root, 0, 0, side);
			side = true;
			measureRec(root,side);
			renderData(root, 0, 0,side);
		}
		public function cleanNodes():void
		{
			this.removeChildren();
		}
		public function layoutData(data:TreeData,autoBalance:Boolean=true):void
		{
			root = data;
			if (autoBalance)
			{
				var totalList:Array;
				totalList = [];
				var i:int, len:int;
				var tArr:Array;
				tArr = data.childsR;
				len = tArr.length;
				for (i = 0; i < len; i++)
				{
					totalList.push(tArr[i]);
				}
				tArr = data.childsL;
				len = tArr.length;
				for (i = 0; i < len; i++)
				{
					totalList.push(tArr[i]);
				}
				tArr = totalList;
				len = tArr.length;
				var half:int;
				half = len / 2;
				//half = 1;
				data.childsL.length = 0;
				data.childsR.length = 0;
				for (i = 0; i < len; i++)
				{
					if (i > half)
					{
						data.childsR.push(tArr[i]);
					}else
					{
						data.childsL.push(tArr[i]);
						walkTree(tArr[i], TreeData.changeSide, null);
					}
				}
			}
			fresh();

		}
		public function fresh():void
		{
			walkTree(root, createTreeRender, this);
			layout();
		}
		public var g:Graphics;
		public static var TPoint:Point = new Point();
		public function renderData(data:TreeData,x:Number,y:Number,isRight:Boolean=true):void
		{
			if (data != root)
			{
				y += data.totalRec.y;
			}
			
		    var dis:Sprite;
			dis = data.displayItem;
			var tarPoint:Point = data.tarPos;
			if (isRight||data==root)
			{
				tarPoint.x = x + data.pos.x;
			}else
			{
				tarPoint.x = x - data.displayItem.width+data.pos.x;
			}
			
			tarPoint.y = y + data.pos.y+dis.height*0.5;
			Tween.to(dis,{x:tarPoint.x,y:tarPoint.y}, 100);
			this.addChild(dis);
			
			if (!data.isOpen) return;
			var i:int, len:int;
			var dataChilds:Array;
			dataChilds = isRight?data.childsR:data.childsL;
			len = dataChilds.length;
			var tarDis:Sprite;
			for (i = 0; i < len; i++)
			{
				
				renderData(dataChilds[i], tarPoint.x, tarPoint.y,isRight);
				
				tarDis = dataChilds[i].displayItem;
				if (isRight)
				{
					g.drawLine(tarPoint.x+dis.width, tarPoint.y, dataChilds[i].tarPos.x,  dataChilds[i].tarPos.y, "#00ff00");
				}else
				{
					g.drawLine(tarPoint.x, tarPoint.y, dataChilds[i].tarPos.x+dataChilds[i].displayItem.width,  dataChilds[i].tarPos.y, "#00ff00");
				}
				
			}
		}
		
		public function measureRec(data:TreeData,isRight:Boolean=true):Rectangle
		{
			data.rec.setTo(0, 0, data.displayItem.width, data.displayItem.height);
			data.childsRec.setTo(0, 0, 0, 0);
			var i:int, len:int;
			var dataChilds:Array;
			dataChilds =  isRight?data.childsR:data.childsL;
			len = dataChilds.length;
			var sumHeight:int;
			var maxWidth:int;
			var tRec:Rectangle;
			var tData:TreeData;
			
			if (len > 0&&data.isOpen)
			{
				sumHeight = 0;
				maxWidth = 0;
				for (i = 0; i < len; i++)
				{
					tRec = measureRec(dataChilds[i],isRight);
					sumHeight += tRec.height;
					if (tRec.width > maxWidth)
					{
						maxWidth = tRec.width;
					}
				}
				sumHeight += offY * (len - 1);
				var preY:Number;
				preY = - 0.5 * sumHeight;
				//if (len == 1) preY = 0;
				var preX:Number;
				if (isRight)
				{
					preX = data.rec.width + offX;
				}else
				{
					preX = -offX;
				}
				
				for (i = 0; i < len; i++)
				{
					tData = dataChilds[i];
					tData.pos.y = preY;
					tData.pos.x = preX;
					tRec = tData.totalRec;
					preY += tRec.height+offY;
				}
				data.totalRec.setTo(0, 0.5*sumHeight-data.displayItem.height*0.5, data.rec.width + offX + maxWidth, sumHeight);
			}
			else
			{
				data.totalRec.copyFrom(data.rec);
			}
			
			return data.totalRec;
		}
		
		public function createTreeRender(data:TreeData):void
		{
			var render:TreeRender;
			if (!data.displayItem)
			{
				data.displayItem = new TreeRender();
			}
			render = data.displayItem;
			render.data = data;
			render.layout = this;
			//addChild(data.displayItem);
		}
		
		public static function walkTree(tree:TreeData, fun:Function, _this:Object):void
		{
			fun.call(_this, tree);
			var childs:Array;	
			var i:int, len:int;
			childs = tree.childsR;
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				walkTree(childs[i], fun, _this);
			}
			childs = tree.childsL;
			len = childs.length;
			for (i = 0; i < len; i++)
			{
				walkTree(childs[i], fun, _this);
			}
		}
	
	}

}