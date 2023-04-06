function integracaoDefinicao()
  N = 2, 6, 7;
  tol = 10e-6;
endfunction

function simpson()
  h = (b - a) / n;
  if n == 1
    soma = trapz(h,funcao(n-1),funcao(n));
  else
    m = n;
    impar = n/2 - round(n/2);
    if impar > 0 & n > 1
      soma = soma + simp38(h, funcao(n-3), funcao(n-2), funcao(n-1), funcao(n))
      m = n - 3;
    endif
    if m > 1
      soma = soma + simp13(h,m,f);
    endif
    simpson = soma;
  endif
endfunction

function s = simp38()
  s = 3 * h * (f0+3*(f1+f2)+f3) / 8;
endfunction

function s = simp13()
  soma = funcao(0);
  for i=1 n-2:2
    soma = soma + 4 * funcao(i) + 2 * funcao(i + 1);
  endfor
  soma = soma + 4  * funcao(n-1) + funcao(n);
  s = h * soma / 3;
endfunction

function y = funcao(x)
  y = x^3 - 3*x^2 + 2;
endfunction
