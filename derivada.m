% Define a função
x = -5:0.1:5;
f = sin(x);

% Define o valor de h
h = 0.1;

% Calcula a derivada
df = zeros(size(f));
for i = 2:length(f)-1
    df(i) = (f(i+1) - f(i-1)) / (2*h);
end

% Plota a função e sua derivada
subplot(2,1,1)
plot(x, f)
title('Função Original')
xlabel('x')
ylabel('f(x)')
subplot(2,1,2)
plot(x, df)
title('Derivada da Função')
xlabel('x')
ylabel('df(x)/dx')

function plot_derivada(x, f, h)
% Calcula a derivada
df = zeros(size(f));
for i = 2:length(f)-1
    df(i) = (f(i+1) - f(i-1)) / (2*h);
end

% Plota a função e sua derivada
subplot(2,1,1)
plot(x, f)
title('Função Original')
xlabel('x')
ylabel('f(x)')
subplot(2,1,2)
plot(x, df)
title('Derivada da Função')
xlabel('x')
ylabel('df(x)/dx')
end
