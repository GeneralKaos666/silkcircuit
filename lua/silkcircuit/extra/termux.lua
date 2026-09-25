-- Termux's colors.properties has no dedicated cursor key, so terminals that
-- read it draw the cursor in the foreground color. The 16 ANSI slots are the
-- same terminal_* contract every other terminal target reads, so this stays
-- in lockstep with kitty, alacritty, and the rest without a second mapping to
-- maintain.

local M = {}

local TEMPLATE = [[
background=${bg}
foreground=${fg}
cursor=${cyan}

color0=${terminal_black}
color1=${terminal_red}
color2=${terminal_green}
color3=${terminal_yellow}
color4=${terminal_blue}
color5=${terminal_magenta}
color6=${terminal_cyan}
color7=${terminal_white}
color8=${terminal_bright_black}
color9=${terminal_bright_red}
color10=${terminal_bright_green}
color11=${terminal_bright_yellow}
color12=${terminal_bright_blue}
color13=${terminal_bright_magenta}
color14=${terminal_bright_cyan}
color15=${terminal_bright_white}
]]

function M.generate(colors)
  return require("silkcircuit.extra").template(TEMPLATE, colors)
end

return M
