% Definindo a função objetivo
fun = @(x) (x(1) - x(2))^2 + (x(2) - x(3))^4;

% Definindo o ponto inicial
x0 = [3 0];

% Definindo o número máximo de iterações
maxIter = 1000;

% Definindo a tolerância
tol = 1e-3;

% Método do Gradiente
options = optimoptions('fminunc','Algorithm','quasi-newton', 'MaxIterations', maxIter, 'OptimalityTolerance', tol);
[x,fval,exitflag,output] = fminunc(fun,x0,options);

% Método de Newton
options = optimoptions('fminunc','Algorithm','trust-region', 'SpecifyObjectiveGradient',true, 'MaxIterations', maxIter, 'OptimalityTolerance', tol);
[x,fval,exitflag,output] = fminunc(fun,x0,options);
