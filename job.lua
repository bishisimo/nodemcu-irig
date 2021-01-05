require("drive")
print("IRIG-B Running...")
if not tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
    local ts, _, _ = rtctime.get()
    task(ts)
end)
then
  print("whoopsie")
end


function task(ts)
    local tds=ts-1609430400
    local day=tds/(3600*24)
    local hour=(tds/3600)%24
    local min=(tds/60)%60
    local sec=tds%60
    irig(day,hour,min,sec)
end

function irig(day,hour,min,sec)
    local sbs=hour*3600+min*60+sec
    drive.p_unit()
    drive.p_unit()--start
    send_sec(sec)--P0
    send_min(min)--P1
    send_hour(hour)--P2
    send_day(day)--P3,P4
    send_year(2021)--P5
    send_control()--P6,P7
    send_sbs(sbs)--P8
end

function bcd(dec)
    result={0,0,0,0}
    for i=1,4 do
        result[i]=bit.band(dec,1)
        dec=bit.arshift(dec,1)
    end
    return result
end

function send_bits(bits)
    for i,b in ipairs(bits) do
        drive.one_bit(b)
        if i%8==4 then
            drive.divide()
        elseif i>0 and i%8==0 then
            drive.p_unit()
        end
    end
end

function send_unit(data)
    bits={}
    local low=bcd(data%10)
    for i,v in ipairs(low)do
        table.insert(bits,v)
    end
    local high=bcd((data%100)/10)
    for i,v in ipairs(high)do
        table.insert(bits,v)
    end
    send_bits(bits)
end

function send_sec(sec)
    send_unit(sec)
end

function send_min(min)
    send_unit(min)
end

function send_hour(hour)
    send_unit(hour)
end

function send_day(day)
    send_unit(day)
    send_bits(bcd(day/100))
    drive.vacancy()
    drive.p_unit()
end

function send_year(year)
    send_unit(year%100)
end

function send_control()
    drive.vacancy()
    drive.divide()
    drive.vacancy()
    drive.p_unit()
    drive.vacancy()
    drive.divide()
    drive.vacancy()
    drive.p_unit()
end

function send_sbs(num)
    bits={}
    for _=1,16 do
        b=num%2
        table.insert(bits,b)
        num=bit.arshift(num,1)
    end
    send_bits(bits)
end
