% Define a função
x = -5:0.1:5;
f = sin(x);

% Calcula a integral
integral = trapz(x, f);

% Mostra o resultado
fprintf('A integral da função sin(x) é: %f\n', integral)
