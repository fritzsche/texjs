-- $Id: domaincoloring-functions.lua 978 2024-09-02 15:27:30Z herbert $

kpse.set_program_name("luatex")

function f0(z)
   return cmath.sin(1/z)*cmath.cos(1/z)/z^3+1/z
end

function f1(z)
    return cmath.cos(z)/cmath.sin(z^4-1)
end

function f2(z)
  local c = complex(1,-1)
  local d = complex(0,0.28)
  return cmath.cos(c^2*z^2)/cmath.cos(c*(z-d))
end

function f3(z)
  return z*(z+i)^2/(z-i)^2
end

function f4(z)
  if abs(z) < 0.1 then 
    return complex(0.001,0.001)  
  else 
    return cmath.sin(1/(z*z))
  end
end

function f5(z)
  return cmath.sqrt(1-1/(z*z)+z^3)
end

function f9(z)
  local c = complex(1,-1)
  local d = complex(1,1)
  return z^2*c^2*(z*c-1-i)/(z*c-2*d)
end

function f10(z)
  local sum = complex(0,0)
  for n=1,20 do
      sum = sum + z^n/(1-z^n)
  end
  return sum
end

function f11(z)   
  local iterateNo = 3
  for n=1,iterateNo do
    z = z^2 
  end
  return z
end

function f12(z)   -- julia
  local iterateNo = 15
  for n=1,iterateNo do
    z = z^2 + complex(0.25,-0.5)
  end
  return z
end

function f13(z)   -- mandelbrot
  local iterateNo = 15
  local c = z
  z = complex(0,0)
  for n=1,iterateNo do
    z = z^2 + c
  end
  return z
end

function f14(z)   
  local iterateNo = 5
--  local c = z
--  z = complex(0,0)
  for n=1,iterateNo do
    z = cmath.sin(z)*cmath.sin(0.8*z) -- + c
  end
  return z
end

function f15(z)
  local alpha = 4
  local C0 = complex(1,0)
  local C1 = 2 * alpha * z
  for n = 2,20 do
    C = (2*z*(n+alpha-1)*C1 - (n+2*alpha-2)*C0)/n
    C0 = C1
    C1 = C
  end
  return C
end

function f16(z)
   local A = z^2 - z -2
   local B = z^2 + complex(1,1)
   return A/B
end

function f17(z)
  return e^(z^cmath.sin(z^cmath.tan(z^cmath.cos(z))))
end

function f18(z)
  return (z+0.5)*(z-0.5)/z
end

