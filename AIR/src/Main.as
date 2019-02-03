package
{
import com.doitflash.consts.Direction;
import com.doitflash.consts.Orientation;
import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
import com.doitflash.starling.utils.list.List;
import com.doitflash.text.modules.MySprite;

import com.luaye.console.C;

import flash.desktop.NativeApplication;
import flash.desktop.SystemIdleMode;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Keyboard;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

import com.myflashlab.air.extensions.sharedPreferences.*;
import com.myflashlab.air.extensions.dependency.OverrideAir;


/**
 * ...
 * @author Hadi Tavakoli - 7/24/2016 11:25 AM
 */
public class Main extends Sprite
{
	private const BTN_WIDTH:Number = 150;
	private const BTN_HEIGHT:Number = 60;
	private const BTN_SPACE:Number = 2;
	private var _txt:TextField;
	private var _body:Sprite;
	private var _list:List;
	private var _numRows:int = 1;
	
	public function Main():void
	{
		Multitouch.inputMode = MultitouchInputMode.GESTURE;
		NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
		NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
		NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
		
		stage.addEventListener(Event.RESIZE, onResize);
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		C.startOnStage(this, "`");
		C.commandLine = false;
		C.commandLineAllowed = false;
		C.x = 20;
		C.width = 250;
		C.height = 150;
		C.strongRef = true;
		C.visible = true;
		C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
		
		_txt = new TextField();
		_txt.autoSize = TextFieldAutoSize.LEFT;
		_txt.antiAliasType = AntiAliasType.ADVANCED;
		_txt.multiline = true;
		_txt.wordWrap = true;
		_txt.embedFonts = false;
		_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Shared Preferences ANE V" + SharedPreferences.VERSION + "</font>";
		_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
		this.addChild(_txt);
		
		_body = new Sprite();
		this.addChild(_body);
		
		_list = new List();
		_list.holder = _body;
		_list.itemsHolder = new Sprite();
		_list.orientation = Orientation.VERTICAL;
		_list.hDirection = Direction.LEFT_TO_RIGHT;
		_list.vDirection = Direction.TOP_TO_BOTTOM;
		_list.space = BTN_SPACE;
		
		init();
		onResize();
	}
	
	private function onInvoke(e:InvokeEvent):void
	{
		NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
	}
	
	private function handleActivate(e:Event):void
	{
		NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
	}
	
	private function handleDeactivate(e:Event):void
	{
		NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
	}
	
	private function handleKeys(e:KeyboardEvent):void
	{
		if(e.keyCode == Keyboard.BACK)
		{
			e.preventDefault();
			NativeApplication.nativeApplication.exit();
		}
	}
	
	private function onResize(e:* = null):void
	{
		if(_txt)
		{
			_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			
			C.x = 0;
			C.y = _txt.y + _txt.height + 0;
			C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
			C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
		}
		
		if(_list)
		{
			_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
			_list.row = _numRows;
			_list.itemArrange();
		}
		
		if(_body)
		{
			_body.y = stage.stageHeight - _body.height;
		}
	}
	
	private function init():void
	{
		// Remove OverrideAir debugger in production builds
		OverrideAir.enableDebugger(function ($ane:String, $class:String, $msg:String):void
		{
			trace($ane+" ("+$class+") "+$msg);
		});
		
		SharedPreferences.init();
		
		//----------------------------------------------------------------------
		
		var btn1:MySprite = createBtn("getAll");
		btn1.addEventListener(MouseEvent.CLICK, getAll);
		_list.add(btn1);
		
		function getAll(e:MouseEvent):void
		{
			trace("getAll: "+ JSON.stringify(SharedPreferences.getAll()));
		}
		
		//---------------------------------------------------------------------
		
		var btn2:MySprite = createBtn("getKeys");
		btn2.addEventListener(MouseEvent.CLICK, getKeys);
		_list.add(btn2);
		
		function getKeys(e:MouseEvent):void
		{
			trace("getAll: "+ JSON.stringify(SharedPreferences.getKeys()));
		}
		
		//---------------------------------------------------------------------
		
		var btn3:MySprite = createBtn("setValue");
		btn3.addEventListener(MouseEvent.CLICK, setValue);
		_list.add(btn3);
		
		function setValue(e:MouseEvent):void
		{
			SharedPreferences.setString("myStringKey1", "my String Value 1");
			SharedPreferences.setString("myStringKey2", "my String Value 2");
			SharedPreferences.setBool("myBooleanKey1", true);
			SharedPreferences.setBool("myBooleanKey2", false);
			SharedPreferences.setInt("myIntKey", 0);
			SharedPreferences.setNumber("myNumberKey", 0.1);
			SharedPreferences.setStringArray("myStringArrayKey", ["str 1", "str 2"]);
		}
		
		//---------------------------------------------------------------------
		
		var btn4:MySprite = createBtn("getValue");
		btn4.addEventListener(MouseEvent.CLICK, getValue);
		_list.add(btn4);
		
		function getValue(e:MouseEvent):void
		{
			trace("getString for key: myStringKey1 = " + SharedPreferences.getString("myStringKey1"));
			trace("getString for key: undefinedKey = " + SharedPreferences.getString("undefinedKey"));
			trace("getBool for key: myBooleanKey1 = " + SharedPreferences.getBool("myBooleanKey1"));
		}
		
		//---------------------------------------------------------------------
		
		var btn5:MySprite = createBtn("removeValue");
		btn5.addEventListener(MouseEvent.CLICK, removeValue);
		_list.add(btn5);
		
		function removeValue(e:MouseEvent):void
		{
			SharedPreferences.remove("myStringKey1");
			SharedPreferences.remove("myStringArrayKey");
			SharedPreferences.remove("myIntKey");
			
			SharedPreferences.setString("myStringKey2", null);
		}
		
		//---------------------------------------------------------------------
		
		var btn6:MySprite = createBtn("clear");
		btn6.addEventListener(MouseEvent.CLICK, clear);
		_list.add(btn6);
		
		function clear(e:MouseEvent):void
		{
			SharedPreferences.clear();
		}
		
		//---------------------------------------------------------------------
		
		var btn7:MySprite = createBtn("refresh Cache");
		btn7.addEventListener(MouseEvent.CLICK, refreshCache);
		_list.add(btn7);
		
		function refreshCache(e:MouseEvent):void
		{
			SharedPreferences.refreshCache();
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private function createBtn($str:String):MySprite
	{
		var sp:MySprite = new MySprite();
		sp.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		sp.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		sp.addEventListener(MouseEvent.CLICK, onOut);
		sp.bgAlpha = 1;
		sp.bgColor = 0xDFE4FF;
		sp.drawBg();
		sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
		sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
		
		function onOver(e:MouseEvent):void
		{
			sp.bgAlpha = 1;
			sp.bgColor = 0xFFDB48;
			sp.drawBg();
		}
		
		function onOut(e:MouseEvent):void
		{
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
		}
		
		var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
		
		var txt:TextField = new TextField();
		txt.autoSize = TextFieldAutoSize.LEFT;
		txt.antiAliasType = AntiAliasType.ADVANCED;
		txt.mouseEnabled = false;
		txt.multiline = true;
		txt.wordWrap = true;
		txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
		txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
		txt.defaultTextFormat = format;
		txt.text = $str;
		
		txt.y = sp.height - txt.height >> 1;
		sp.addChild(txt);
		
		return sp;
	}
}
	
}