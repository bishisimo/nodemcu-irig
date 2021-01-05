drive={}
drive.ms=1000
drive.sec=1000*drive.ms
drive.zero_time=2*drive.ms
drive.one_time=5*drive.ms
drive.p_time=8*drive.ms
drive.pu_time=10*drive.ms
drive.division_point=0

function drive.unit(n)
    gpio.write(0,gpio.HIGH)
    tmr.delay(n)
    gpio.write(0,gpio.LOW)
end

function drive.zero()
    drive.unit(drive.zero_time)
end

function drive.one()
    drive.unit(drive.one_time)
end

function drive.p_unit()
    drive.unit(drive.p_time)
end

function drive.divide()
    drive.zero()
end

function drive.vacancy()
    drive.zero()
    drive.zero()
    drive.zero()
    drive.zero()
end

function drive.one_bit(b)
    if b==1
    then drive.one()
    else drive.zero()
    end
end

return drive