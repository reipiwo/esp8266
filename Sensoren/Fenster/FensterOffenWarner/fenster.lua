password = ""	-- AP Password
ssid = ""		-- AP SSID
PBdevId = "" -- PushingBox Device Id

-- power up the wifi module and log into the AP
wifi.setmode(wifi.STATIONAP)
wifi.sta.config(ssid, password)
wifi.sta.connect()

-- Poll the PushingBox API
-- devid: Device ID given by PushingBox
-- cb: callback function when received OK
function pollPushingBox(devid, cb)
	conn = net.createConnection(net.TCP, 0)
	conn:on("receive", function(conn,payload)
		-- TODO: check if "Status: 200 OK"" or something like that to confirm poll
		cb()
	end)
	conn:dns('api.pushingbox.com',function(conn,ip) ipaddr=ip; 
	   conn:connect(80,ipaddr) 
	   conn:send("GET /pushingbox?devid="..devid.." HTTP/1.1\r\nHost:api.pushingbox.com\r\n"
	   .."Connection: close\r\nAccept: */*\r\n\r\n")
	  
	end)

end

-- Go to deep sleep and never wake up
function goSleep()
	node.dsleep(0,4)
end

-- wait until we have an IP from the AP
tmr.alarm(0, 1000, 1, function()
     if wifi.sta.getip() == nil then
		-- do nothing
     else
          tmr.stop(0)
		  pollPushingBox(PBdevId, goSleep)
     end
end)
