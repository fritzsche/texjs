-- The luafractions module
-- Authors: Chetan Shirore and Ajit Kumar
-- version 1.3, Date=23-Aug-2023
-- Licensed under LaTeX Project Public License v1.3c or later. The complete license text is available at http://www.latex-project.org/lppl.txt.

M = {}       -- the module
frac_mt = {} -- the metatable
function M.new (n, d, mode)
   mode = mode or 'fracs'
   if mode == 'nofracs' then
      return (n/d)
   end
   if mode == 'fracs' then
      if n~=math.floor(n) or d~=math.floor(d) then
         error('Only integers are expected.')
      end
      if  d == 0 then
         error('Invalid fraction')
      end
      local fr = {}
      local g = M.lgcd(n,d)
      fr = {n=n/g, d=d/g}
      return setmetatable(fr,frac_mt)
   end
end
lfrac = M.new

function M.lgcd (a, b)
   local r
   while (b ~= 0) do
      r = a % b
      a = b
      b = r
   end
   return a
end

function M.simp (num)
   local cf = gcd(num[1], num[2])
   return M.new(num[1] / cf, num2[2] / cf)
end

function M.toFnumber(c)
if getmetatable( c ) == frac_mt then
   return c.n / c.d
end
return c
end

function M.toFrac(x)
   if type(x) == "number" then
      if x==math.floor(x) then
         return M.new(math.floor(x),1)
      else
         return x
      end
   end
   return x
end


function addFracs (c1, c2)
   return M.new(c1.n * c2.d + c1.d * c2.n, c1.d*c2.d)
end

function subFracs (c1, c2)
   return M.new(c1.n * c2.d - c1.d * c2.n, c1.d*c2.d)
end

function mulFracs (c1, c2)
   return M.new(c1.n * c2.n, c1.d*c2.d)
end

function divFracs (c1, c2)
   return M.new(c1.n * c2.d, c1.d*c2.n)
end

function minusFracs (c1)
   return M.new(-c1.n,c1.d)
end

function powerFracs (c1,m)
   return M.new((c1.n)^m,(c1.d)^m)
end


function M.add(a, b)
   if type(a) == "number" then
      if a==math.floor(a) then
         return addFracs(M.new(a,1),b)
      else
         return a + M.toFnumber(b)
      end
   end

   if type(b) == "number" then
      if b==math.floor(b) then
         return addFracs(a,M.new(b,1))
      else
         return M.toFnumber(a) + b
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( a ) == frac_mt and getmetatable( b ) == complex_meta then
         return setmetatable( { a+b[1], b[2] }, complex_meta )
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( b ) == frac_mt and getmetatable( a ) == complex_meta then
         return setmetatable( { b+a[1], a[2] }, complex_meta )
      end
   end
   return addFracs(a, b)
end


function M.sub(a, b)
   if type(a) == "number" then
      if a==math.floor(a) then
         return subFracs(M.new(a,1),b)
      else
         return a - M.toFnumber(b)
      end
   end

   if type(b) == "number" then
      if b==math.floor(b) then
         return subFracs(a,M.new(b,1))
      else
         return M.toFnumber(a) - b
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( a ) == frac_mt and getmetatable( b ) == complex_meta then
         return setmetatable( { a-b[1], -b[2] }, complex_meta )
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( b ) == frac_mt and getmetatable( a ) == complex_meta then
         return setmetatable( { a[1]-b, a[2] }, complex_meta )
      end
   end
   return subFracs(a, b)
end


function M.mul(a, b)
   if type(a) == "number" then
      if a==math.floor(a) then
         return mulFracs(M.new(a,1),b)
      else
         return a * M.toFnumber(b)
      end
   end

   if type(b) == "number" then
      if b==math.floor(b) then
         return mulFracs(a,M.new(b,1))
      else
         return M.toFnumber(a) * b
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( a ) == frac_mt and getmetatable( b ) == complex_meta then
         return setmetatable( { a*b[1], a*b[2] }, complex_meta )
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( b ) == frac_mt and getmetatable( a ) == complex_meta then
         return setmetatable( { b*a[1], b*a[2] }, complex_meta )
      end
   end
   return mulFracs(a, b)
end


function M.div(a, b)
   if type(a) == "number" then
      if a==math.floor(a) then
         return divFracs(M.new(a,1),b)
      else
         return a / M.toFnumber(b)
      end
   end

   if type(b) == "number" then
      if b==math.floor(b) then
         return divFracs(a,M.new(b,1))
      else
         return M.toFnumber(a) / b
      end
   end

   if type( a ) == "table" and type(b) =="table" then
      if getmetatable( a ) == frac_mt and getmetatable( b ) == complex_meta then
         b= setmetatable( { M.toFrac(b[1]),  M.toFrac(b[2]) }, complex_meta )
         return a*(1/b)
      end
   end
   return divFracs(a, b)
end

function M.tostring (c)
   if c.n == 0  then
      return  string.format("%g",0)
   end
   if c.d == 1  then
      return  string.format("%g",c.n)
   end
   if c.d == -1  then
      return  string.format("%g",-c.n)
   end
   return string.format("\\frac{%g}{%g}", c.n, c.d)
end


function lnumChqEql(x, y) 
   
   if type(x) == "number" and type(y) == "number" then 
		return (x == y)
   end
   
   if getmetatable( x ) == frac_mt and getmetatable( y ) == frac_mt then 
		return (M.toFnumber(x) == M.toFnumber(y))
   end
   
   if type(x) == "number" and getmetatable( y ) == frac_mt then 
		return (M.toFnumber(y) == x)
   end
   
   if getmetatable( x ) == frac_mt and type(y) == "number" then 
		return (M.toFnumber(x) == y)
   end
  
   if getmetatable( x ) == complex_meta and getmetatable( y ) == complex_meta then 
		return M.toFnumber(x[1]) == M.toFnumber(y[1]) and M.toFnumber(x[2]) == M.toFnumber(y[2])
   end
   
   if type(x) == "number" and getmetatable( y ) == complex_meta then 
		return (M.toFnumber(y[1]) == x  and M.toFnumber(y[2]) == 0)
   end
   
   if getmetatable(x) == complex_meta and type( y ) == "number" then 
		return (M.toFnumber(x[1]) == y and M.toFnumber(x[2]) == 0)
   end
  
   if getmetatable( x ) == frac_mt and getmetatable( y ) == complex_meta then 
		return (M.toFnumber(x)==M.toFnumber(y[1]) and M.toFnumber(y[2]) == 0)
   end
   
   if getmetatable( x ) == complex_meta and getmetatable( y ) ==  frac_mt then 
		return (M.toFnumber(y)==M.toFnumber(x[1]) and M.toFnumber(x[2]) == 0)
   end
   
   return false
end

--Setting Metatable operations.
frac_mt.__add = M.add
frac_mt.__sub = M.sub
frac_mt.__mul = M.mul
frac_mt.__div = M.div
frac_mt.__unm = minusFracs
frac_mt.__pow = powerFracs
frac_mt.__tostring = M.tostring
frac_mt.__eq = lnumChqEql

return M