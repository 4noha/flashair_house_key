local unlock = function()
    local ok, data = fa.pio( 0x06, 0x04 );
    if ok then
        while data ~= ( 0x08 ) do
            sleep( 100 );
            ok, data = fa.pio( 0x06, 0x04 );
        end
        
        if data then
            fa.pio( 0x06, 0x00 );
            
            print [[
                HTTP/1.1 200 OK
                Content-Type: application/json
            ]]
            print( '{"error":"","data":' .. data .. '}' );
            return;
        end
    end

    ok, indata = fa.pio( 0x06, 0x00 );
    print [[
        HTTP/1.1 500 OK
        Content-Type: application/json
    ]]
    print( '{"error":"I/O error.","data":' .. data .. '}' );
end

unlock();