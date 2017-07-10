local ok, data = fa.pio( 0x06, 0x00 );
print [[
    HTTP/1.1 200 OK
    Content-Type: application/json
]]
print( '{"error":"","data":' .. data .. '}' );