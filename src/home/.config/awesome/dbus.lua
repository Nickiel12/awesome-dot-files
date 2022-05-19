local dbus = require 'lua-dbus'


local function on_signal (...)
    -- react on signal here
end

local signal_opts = {
    bus = 'session',
    interface = 'org.awesomewm.galaxymenu', -- or something appropriate ;)
}
-- add signal handler
dbus.on('Signal', on_signal, signal_opts)