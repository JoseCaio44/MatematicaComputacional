function [x] = gauss_jordan_pivotamento(A, b)
    [m, n] = size(A);
    if m ~= n
        error('A matriz A deve ser quadrada');
    end

    % Concatenar matriz A com vetor b
    Ab = [A, b];

    % Eliminação progressiva com pivotamento parcial
    for i = 1:n
        % Encontrar o pivô máximo na coluna atual
        [max_val, max_row] = max(abs(Ab(i:end, i)));
        max_row = max_row + i - 1;

        % Trocar as linhas para mover o pivô para a posição atual
        Ab([i, max_row], :) = Ab([max_row, i], :);

        % Pivoteamento
        pivot = Ab(i, i);
        Ab(i, :) = Ab(i, :) / pivot;

        % Eliminação
        for j = 1:n
            if j ~= i
                factor = Ab(j, i);
                Ab(j, :) = Ab(j, :) - factor * Ab(i, :);
            end
        end
    end

    % Extrair a solução
    x = Ab(:, end);
end

% Definir a matriz A e o vetor b do sistema de equações
A = [-1 1 -3; 3 -2 8; 2 -2 5];
b = [-4; 14; 7];

% Chamar a função para encontrar as raízes
x = gauss_jordan_pivotamento(A, b);

% Exibir as raízes
disp('As raízes do sistema são:');
disp(x);
