package;

import haxe.ds.HashMap;
import kha.audio1.Audio;
import kha.network.HttpMethod;
import haxe.format.JsonParser;
import haxe.Json;
import haxe.Http;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.Color;
import kha.System;
import kha.Font;
import kha.network.Http;
import zui.Zui;
import zui.Id;


class CryptoCurrency {
	var price : String;
	var symbol: String;
}
class Main {
	static var called = false;
	static var obj = null;
	static var btc : Dynamic = null;
	static var ltc : Dynamic = null;
	static var xrp : Dynamic = null;
	static var doge : Dynamic = null;
	static var eth : Dynamic = null;


	static function lookForCoin(object : Dynamic, string : String) : Null<Int>
	{
		for (i in 1...50000) {
			var x =  Reflect.getProperty(object.data,""+i);
			if(x == null ){
				continue;
			}
			var str : String = x.symbol;
			trace(str,i);
			if(StringTools.endsWith(str.toLowerCase(),string.toLowerCase())){
				trace("found: i " + i);
				return i;
			}
		}
		return null;
	}
	static function callback(errors: Int,status: Int, res: String ){
		trace(errors,status,res);
		if(res == null || status != 200) {
			trace(res, status, "Stopping System: ",System.stop());
			return;
		}
		obj = Json.parse(res);
		btc = Reflect.getProperty(obj.data, '1');
		ltc = Reflect.getProperty(obj.data, '2');
		doge = Reflect.getProperty(obj.data,'74');
		eth = Reflect.getProperty(obj.data,'1027');
		
	
		
		trace(btc.symbol);
		trace(ltc.symbol);
		trace(ltc.quotes.USD.price);
		//obj = Json.parse(res);
		// trace(obj.data[2].symbol,obj.data[2].quotes.USD.price);
		// btc = obj.data[1];
		// ltc = obj.data[2];

	
		trace("changed object");
	}
	static function update(): Void {
		//var str = Http.requestUrl("https://raw.githubusercontent.com/LucasMW/Headache/master/add.ha");
		if(!called){
			//var res = haxe.Http.requestUrl("https://api.alternative.me/v2/ticker/");
			var map = new Map<String, String>();
			Http.request("api.alternative.me/v2/ticker","",null,80,true,HttpMethod.Get,map,callback);
			//obj = JsonParser.parse(res);
			called = true; // fire only once;
			Scheduler.addTimeTask(function () {called = false; trace("called");}, 1,1,1);
			
		}
		if(obj != null){
			
			
			//trace(this.response);
		}
	}

	static function render(frames: Array<Framebuffer>): Void {
		var frame = frames[0];
		frame.g2.begin();
		frame.g2.drawRect(32,32,64,32,6);
		frame.g2.color = Color.Pink;
		frame.g2.fillRect(100,100,10,10);
		if(obj != null){
			frame.g2.font = Assets.fonts.SFNSDisplay;
        	frame.g2.fontSize = 32;
        	frame.g2.color = Color.White;
			var display = "BTC: \t" + Json.stringify(btc.quotes.USD.price).substring(0,7) + " USD";
			frame.g2.drawString(display,200,200);
			var display = "LTC: \t" + Json.stringify(ltc.quotes.USD.price).substring(0,7) + " USD";
			frame.g2.drawString(display,200,250);
			var display = "ETH: \t" + Json.stringify(eth.quotes.USD.price).substring(0,7) + " USD";
			frame.g2.drawString(display,200,300);
			var display = "DOGE: \t" + Json.stringify(doge.quotes.USD.price).substring(0,7) + " USD";
			frame.g2.drawString(display,200,350);
		} else {
			frame.g2.font = Assets.fonts.SFNSDisplay;
        	frame.g2.fontSize = 32;
        	frame.g2.color = Color.White;
			var display = "Loading...";
			frame.g2.drawString(display,200,200);
		}
		//trace(Assets);
		
		
		frame.g2.end();
		
	}

	public static function main() {
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });
				
			});
		});
		trace("loading");
		
	}
}
