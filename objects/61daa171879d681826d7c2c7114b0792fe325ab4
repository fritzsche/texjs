-- $Id: domaincoloring.lua 978 2024-09-02 15:27:30Z herbert $

-----------------------------------------------------------------------
--         FILE:  domaincoloring.lua
--  DESCRIPTION:  create a visual reprensation of a complex function
-- REQUIREMENTS:  
--       AUTHOR:  Herbert Voß
--      LICENSE:  LPPL 1.3
--
-----------------------------------------------------------------------

local version = 0.05

kpse.set_program_name("luatex")

require("domaincoloring-complex-numbers")

local func = io.open("domaincoloring-functions.lua","r")
if func~=nil then
  io.close(func) 
  dofile("domaincoloring-functions.lua")
end

local function HSVtoRGB(h, s, v)
--    if h == 1 then h = 0 end
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - s * f)
    local t = v * (1 - s * (1 - f))
    v = math.floor(255*v) % 256 
    p = math.floor(255*p) % 256 
    q = math.floor(255*q) % 256 
    t = math.floor(255*t) % 256 
    if i == 0 then      return v,t,p
    elseif i == 1 then  return q,v,p
    elseif i == 2 then  return p,v,t
    elseif i == 3 then  return p,q,v
    elseif i == 4 then  return t,p,v
    elseif i == 5 then  return v,p,q
    else                return v,v,v
    end
end

--[[
local function HSVtoRGB(h, s, v)
    h = math.floor(h * 360)
    local k1 = v*(1-s)
    local k2 = v - k1
    local r = math.min (math.max (3*math.abs (((h      )/180)%2-1)-1, 0), 1)
    local g = math.min (math.max (3*math.abs (((h  -120)/180)%2-1)-1, 0), 1)
    local b = math.min (math.max (3*math.abs (((h  +120)/180)%2-1)-1, 0), 1)
    return k1 + k2 * r * 255, k1 + k2 * g * 255, k1 + k2 * b * 255
end
]]


function my_color_scheme(z,hsvrgb)
  r, phi = cmath.polar(z)
--  print(r,tostring(phi))
-- phi is in -pi,+pi; change it to [0;2pi] and normalize it to [0;1]
  phi = (phi+pi)/(2*pi) 
--  phi = (phi+pi)*180/pi 
  h_str,s_str,v_str = hsvrgb:match("([^,]+),([^,]+),([^,]+)")
  --print(h_str,s_str,v_str)
--  print(load("return "..h_str)(),load("return "..s_str)(),load("return "..v_str)())
  R,G,B = HSVtoRGB(load("return "..h_str)(),load("return "..s_str)(),load("return "..v_str)())   --    h,s,v)     -- (phi+3.14,1,r)
--  print(R,G,B)
  return {math.floor(R+0.5),math.floor(G+0.5),math.floor(B+0.5)}
end


--[[
A raster of Height rows, in order from top to bottom. 
Each row consists of Width pixels, in order from left to 
right. Each pixel is a triplet of red, green, and blue samples, 
in that order. Each sample is represented in pure binary by 
either 1 or 2 bytes. If the Maxval is less than 256, it is 
1 byte. Otherwise, it is 2 bytes. The most significant byte is first.
A row of an image is horizontal. A column is vertical. 
The pixels in the image are square and contiguous.
]]  

function write_eps_data(name,data,domain,res,grid)
  print("Lua: writing data file "..name.." ...")
--  print(data)
  outFile = io.open(name,"w+") -- Dateiname
  outFile:write([[
%!PS-Adobe-3.0 EPSF-3.0
%%Creator: (Herbert Voss)
%%Title: (domain.eps)
%%CreationDate: (]])
  outFile:write(os.date("%Y-%m-%d-%H.%M.%S")..")\n")
  outFile:write("%%BoundingBox: -0 -0 "..res[1].." "..res[2].."\n")
  outFile:write("%%HiResBoundingBox: 0 0 "..res[1].." "..res[2].."\n")
  outFile:write([[
%%DocumentData: Clean7Bit
%%LanguageLevel: 2
%%Pages: 1
%%EndComments
%%BeginDefaults
%%EndDefaults
%%BeginProlog
/DirectClassPacket {
  currentfile color_packet readhexstring pop pop
  /number_pixels 3 def
  0 3 number_pixels 1 sub { pixels exch color_packet putinterval } for
  pixels 0 number_pixels getinterval
} bind def
/DirectClassImage{
    columns rows 8 [ columns 0 0 rows neg 0 rows ]
    { DirectClassPacket } false 3 colorimage 
} bind def
/DisplayImage {
  gsave
  /buffer 512 string def
  /byte 1 string def
  /color_packet 3 string def
  /pixels 768 string def
  currentfile buffer readline pop
  token pop /x exch def
  token pop /y exch def pop
  x y translate
  currentfile buffer readline pop
  token pop /x exch def
  token pop /y exch def pop
  currentfile buffer readline pop
  token pop /pointsize exch def pop
  x y scale
  currentfile buffer readline pop
  token pop /columns exch def
  token pop /rows exch def pop
  currentfile buffer readline pop
  token pop /class exch def pop
  currentfile buffer readline pop
  token pop /compression exch def pop
  DirectClassImage
  grestore
} bind def
%%EndProlog
%%Page:  1 1
]])
  outFile:write("%%PageBoundingBox: 0 0 "..res[1].." "..res[2].."\n")
  outFile:write([[userdict begin
DisplayImage
0 0
]])
  outFile:write(res[1].." "..res[2].."\n")
  outFile:write("12\n")
  outFile:write(res[1].." "..res[2].."\n")
  outFile:write([[0
0
]])
  local i = 0
  for row = 1, res[2] do                -- alle Zeilen
    for col = 1, res[1] do              -- alle Spalten
      for k = 1,3 do
        if data[row][col][k] ~= data[row][col][k] then -- check for nan
          outFile:write("FF")
        else
          num = data[row][col][k]
          if num < 16 then
            hex = string.format("0%X", num)
          else
            hex = string.format("%X", num)
          end
          outFile:write(hex)
        end
        i = i + 1
        if i == 39 then
          outFile:write("\n")        -- neue Zeile 
          i = 0
        end
      end
    end
  end
  outFile:write("\n")        -- neue Zeile 
  if grid == "true" then
    outFile:write("gsave \n /xMin "..domain[1].." def\n")
    outFile:write("/xMax "..domain[2].." def\n")
    outFile:write("/yMin "..domain[3].." def\n")
    outFile:write("/yMax "..domain[4].." def\n")
    outFile:write(res[1].." xMax xMin sub div dup /xScale exch def \n")
    outFile:write(res[2].." yMax yMin sub div dup /yScale exch def \n")
    outFile:write("scale\n")
    outFile:write([[
xMin neg yMin neg translate % the new origin\n"
gsave
xMin floor 0.5 yScale div sub
  0.5 xMax 0.5 add round { % loop variable on stack\n"
  dup yMin moveto yMax lineto
} for
2 ]])
    outFile:write(res[2]) 
    outFile:write([[  div  setlinewidth 0.4 setgray [5 5 ] { ]])
    outFile:write(res[2]..[[ div } forall 2 array astore 0 setdash
stroke
grestore
gsave
yMin floor 0.5 yScale div add          % startValue 
  % with shift 0.5 to be in the middle of the pixel
  0.5   % step
  yMax 0.5 add round { % loop variable on stack
  dup xMin exch moveto xMax exch lineto
} for
2 ]])
    outFile:write(res[1]) 
    outFile:write([[  div  setlinewidth 0.4 setgray [5 5 ] { ]])
    outFile:write(res[1]..[[ div } forall 2 array astore 0 setdash
stroke
grestore 
gsave
xMin floor 0.5 yScale div sub
  1 xMax 0.5 add round { % loop variable on stack\n"
  dup yMin moveto yMax lineto
} for
2 ]])
    outFile:write(res[2]) 
    outFile:write([[ div  setlinewidth 0.3 setgray stroke
grestore
gsave
yMin floor 0.5 yScale div add
  1 yMax 0.5 add round { % loop variable on stack
  dup xMin exch moveto xMax exch lineto
} for 
2 ]])
    outFile:write(res[1]) 
    outFile:write([[ div  setlinewidth 0.3 setgray stroke
grestore
]])
  end
  outFile:write([[
end % of userdict
%%PageTrailer
%%Trailer
%%EOF
    ]])
  outFile:close() -- Datei schließen 
  --os.execute("pnmtopng apfel.ppm >"..fileName..".png") -- ppm -> png Format 
end

function write_data(name,data,domain,res)  -- only valid for writing ppm files
  print("Lua: writing data to file "..name.." ...")
--  print(data)
  outFile = io.open(name,"w+") -- Dateiname
  outFile:write("P3 ")                -- Grafictype R G B
  outFile:write(res[1].." "..res[2].." ") -- Anzahl Pixel: Breite x Höhe (cols x rows) 
  outFile:write("255\n")           -- Höchster Zahlenwert (0..255) 
  for row = 1, res[2] do                -- alle Zeilen
    for col = 1, res[1] do              -- alle Spalten
      for k = 1,3 do
        if data[row][col][k] ~= data[row][col][k] then -- check for nan
          outFile:write("255 ")
        else
          outFile:write(data[row][col][k].." " )
        end
      end
    end
    outFile:write("\n")        -- neue Zeile 
  end
  outFile:close() -- Datei schließen 
  --os.execute("pnmtopng apfel.ppm >"..fileName..".png") -- ppm -> png Format 
end

function plot(fString, domain, res, maxR, funcName, hsvrgb, bgColor, invers)
  print("\nLua: calculating data with "..tostring(fString).." ... ")
  local colorBGsum = bgColor[1]    -- {-30, 255, 255}
  if colorBGsum < 0 then           -- color[1]+... < 30 will be {255,255,255}
    for i=1,3 do
      bgColor[i] = bgColor[2]
    end
  end
  local left = domain[1]
  local right = domain[2]
  local bottom = domain[3]
  local top = domain[4]
  local dx = (right-left)/res[1]
  local dy = (top-bottom)/res[2]
  local img = {}      -- mxn-Matrix  (rows x colums) img[row][col]
  for row = 1,res[2] do
    img[row] = {}
    for col = 1,res[1] do
      img[row][col] = 0 
    end
  end
  for row = 1, res[2] do 
    y = top-dy*row
    for col = 1,res[1] do 
--      print(j,i)
      x = left+dx*col
      z = complex(x, y)
      if funcName then
        fz = fString(z)   -- use func number from external file
      else
        fz = load("return "..fString)() -- for example: cmath.cos(z)/cmath.sin(z^4-1)
      end    
--      if fz == complex(nan,nani) then
--        color = { 0, 0, 0}
--        print("Complex division by zero!!")
--      else    
        color = my_color_scheme(fz,hsvrgb)
--      end
      if maxR > 0 and cmath.abs(z) > maxR then color = { 0, 0, 0 } end
      if invers == "true" then
        for c=1,#color do
          color[c] = math.abs(color[c]-255)
        end
      end
      local colorSum = color[1]+color[2]+color[3]
      if color == {0, 0, 0} then color = bgColor end     -- only one color
      if colorBGsum < 0 and colorSum < math.abs(colorBGsum) then color = {255,255,255} end
      img[row][col] = color
    end
  end
  return img
end

--[[
  f: function as string if funcName is False
     as funcName from external file if funcName is TRUE
  Domain:  xMin,xMax,yMin,yMax
  Resolution: (points per Interval) xRes,yRes
  funcName: true/false (see f)    
]]

function createData(jobname,f,funcName,Domain,Resolution,maxR,hsvrgb,bgColor,invers,grid)
    print("Lua:createData: ",jobname,f,funcName,Domain,Resolution,maxR,hsvrgb,bgColor,invers,grid)
    if funcName == "" then
      img = plot(f,Domain,Resolution,maxR,false,hsvrgb,bgColor,invers)
    else
      img = plot(load("return "..funcName)(),Domain,Resolution,maxR,true,hsvrgb,bgColor,invers)
    end
--  write_data("domain.ppm",img,Resolution)
    write_eps_data(jobname.."-domain.eps",img,Domain,Resolution,grid)
end

