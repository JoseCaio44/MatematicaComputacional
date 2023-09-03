% Função auxiliar para calcular a frequência dos caracteres no texto
function frequencia = calcularFrequencia(texto)
    % Inicializar um vetor de frequência vazio
    frequencia = zeros(1, 256); % Supomos caracteres ASCII

    % Contar a frequência de cada caractere no texto
    for i = 1:length(texto)
        charCode = uint8(texto(i));
        frequencia(charCode) = frequencia(charCode) + 1;
    end
end

% Função auxiliar para construir a árvore de Huffman
function arvore = construirArvoreHuffman(frequencia)
    % Inicializar uma fila de prioridade com os nós de frequência
    filaPrioridade = criarFilaPrioridade(frequencia);

    % Construir a árvore de Huffman
    while length(filaPrioridade) > 1
        % Remove os dois nós de menor frequência
        nodo1 = filaPrioridade(1);
        filaPrioridade(1) = [];
        nodo2 = filaPrioridade(1);
        filaPrioridade(1) = [];

        % Cria um novo nodo com frequência acumulada
        novoNodo = struct('caractere', [], 'frequencia', nodo1.frequencia + nodo2.frequencia, 'esquerda', nodo1, 'direita', nodo2);

        % Insere o novo nodo na fila de prioridade
        filaPrioridade = inserirNaFilaPrioridade(filaPrioridade, novoNodo);
    end

    % O último nodo na fila de prioridade é a raiz da árvore de Huffman
    arvore = filaPrioridade(1);
end

% Função auxiliar para gerar a tabela de codificação de Huffman
function tabela = gerarTabelaHuffman(arvore)
    % Inicializar a tabela de codificação vazia
    tabela = containers.Map('KeyType', 'char', 'ValueType', 'char');

    % Chamar uma função recursiva para gerar a tabela
    gerarTabelaRecursiva(arvore, '', tabela);
end

% Função auxiliar recursiva para gerar a tabela de codificação de Huffman
function gerarTabelaRecursiva(nodo, codigo, tabela)
    if isempty(nodo.caractere)
        % No interno: desça na árvore
        gerarTabelaRecursiva(nodo.esquerda, [codigo '0'], tabela);
        gerarTabelaRecursiva(nodo.direita, [codigo '1'], tabela);
    else
        % No folha: atribua o código ao caractere
        tabela(nodo.caractere) = codigo;
    end
end

% Função auxiliar para codificar o texto usando a tabela de Huffman
function textoCodificado = codificarHuffman(texto, tabela)
    textoCodificado = '';
    for i = 1:length(texto)
        caractere = texto(i);
        codigo = tabela(caractere);
        textoCodificado = [textoCodificado codigo];
    end
end

% Função auxiliar para decodificar o texto usando a tabela de Huffman
function textoDecodificado = decodificarHuffman(textoCodificado, arvore)
    textoDecodificado = '';
    nodo = arvore;
    for i = 1:length(textoCodificado)
        bit = textoCodificado(i);
        if bit == '0'
            nodo = nodo.esquerda;
        else
            nodo = nodo.direita;
        end
        if isempty(nodo.caractere)
            continue;
        else
            textoDecodificado = [textoDecodificado nodo.caractere];
            nodo = arvore; % Reiniciar a busca na raiz da árvore
        end
    end
end

% Função auxiliar para criar uma fila de prioridade
function fila = criarFilaPrioridade(frequencia)
    fila = [];
    for i = 1:256
        if frequencia(i) > 0
            nodo = struct('caractere', char(i-1), 'frequencia', frequencia(i), 'esquerda', [], 'direita', []);
            fila = inserirNaFilaPrioridade(fila, nodo);
        end
    end
end

% Função auxiliar para inserir um nodo em uma fila de prioridade
function fila = inserirNaFilaPrioridade(fila, nodo)
    if isempty(fila)
        fila = nodo;
        return;
    end

    % Encontrar a posição correta para inserir o nodo
    for i = 1:length(fila)
        if nodo.frequencia < fila(i).frequencia
            fila = [fila(1:i-1) nodo fila(i:end)];
            return;
        end
    end

    % Se o nodo tem a maior frequência, insira no final
    fila = [fila nodo];
end

