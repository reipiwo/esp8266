-- This file runs first and will start the program.
--
-- It waits for 10 Minutes in Idle until it polls 
-- PushingBox and fires an alarm. After that it will 
-- go to infinite deep sleep. If there is a power down
-- during the 10 Minutes nothign will happen
print("Fensterwächter V1.0 (www.kurzschluss-blog.de)")

tmr.alarm(2, 600000, 0, function() -- wait 10 Minutes then load the fenster.lua script
  dofile('fenster.lua')
end)

 