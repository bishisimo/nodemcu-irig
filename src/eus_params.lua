enduser_setup.start(
  function()
    print("Connected to WiFi as:" .. wifi.sta.getip())
    sntp.sync("ntp1.aliyun.com", 
    function()
        print("Time ...ok!")
        dofile('job.lua')
    end, nil, 1)
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end,
  print -- Lua print function can serve as the debug callback
)
