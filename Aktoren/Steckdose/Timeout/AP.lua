-- set device into AP mode
wifi.setmode(wifi.STATIONAP)
cfg={}
cfg.ssid="Dunst"
cfg.pwd="DerGeraet"
wifi.ap.config(cfg)
pin=3
function stopp()
     print("stop")
          gpio.write(pin, gpio.LOW)
end

-- create a server
sv=net.createServer(net.TCP, 3)    -- 30s time out for a inactive client
-- server listen on 80, if data received, print data to console, and send "AKC" to remote.

print("server start")
sv:listen(80,function(c)
           
           c:on("receive", function(c, pl) 
                              tmr.stop(0)
                              print("an")
                              gpio.write(pin, gpio.HIGH)
                              tmr.alarm(0, 305000, 0, stopp) 
                              c:send("AKC") 
                           end ) 

          
      end)
