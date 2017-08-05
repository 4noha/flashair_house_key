local WAIT_TIME = 100;

local lock = function()
    local totalwait = 0;
    local ok, data = fa.pio( 0x06, 0x02 );
    if ok then
        --[[
            Lua 5.2.1
            Lock: 10
            Release: 26
            Unlock: 18
            while ( data ~= ( 80 ) ) and totalwait < 5000 do
        ]]
        while ( data ~= ( 10 ) ) and totalwait < 5000 do
            sleep( 100 );
            totalwait = totalwait + WAIT_TIME;
            ok, data = fa.pio( 0x06, 0x02 );
        end
        
        if data then
            fa.pio( 0x06, 0x00 );
            --print( 'HTTP/1.1 200 OK Content-Type: application/json' );
            print( '{"error":"","data":' .. data .. '}' );
            return;
        end
    end

    ok, indata = fa.pio( 0x06, 0x00 );
    print( 'HTTP/1.1 500 OK Content-Type: application/json' );
    print( '{"error":"I/O error.","data":' .. data .. '}' );
end

lock();