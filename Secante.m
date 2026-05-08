clear all; clc;
pkg load symbolic;

% 1. Entradas via Teclado
f_input = input('Digite a função (ou Enter para 3-x^3): ', 's');
if isempty(f_input); f_input = '3 - x^3'; end

x0 = input('Digite o primeiro chute inicial (x0, ex: 1): ');
x1 = input('Digite o segundo chute inicial (x1, ex: 2): ');
tol = input('Digite a tolerância (ex: 1e-10, ou Enter para padrão): ');
if isempty(tol); tol = 1e-10; end

% 2. Definição da Função
syms x;
f_sym = sym(f_input);
f_anon = function_handle(f_sym);

disp('--- Resolução de Equações: Método da Secante ---');

% 3. Parâmetros de Execução
imax = 50;

% 4. Tabela Formatada
largura = 85;
div = repmat('-', 1, largura);
fprintf('\n%s\n', div);
fprintf('%5s | %18s | %18s | %18s | %15s\n', 'Iter', 'xi-1', 'xi', 'xi+1', '|ER|');
fprintf('%s\n', div);

% 5. Loop da Secante
for i = 1:imax
    try
        f_x0 = f_anon(x0);
        f_x1 = f_anon(x1);

        % Proteção contra divisão por zero (se f(x0) == f(x1))
        if abs(f_x1 - f_x0) < 1e-12
            fprintf('Erro: Divisão por zero (f(xi) = f(xi-1)) em i = %d\n', i);
            break;
        end

        % Fórmula da Secante
        xi_mais_1 = x1 - (f_x1 * (x1 - x0)) / (f_x1 - f_x0);

        % Cálculo do Erro Relativo
        ER = abs((xi_mais_1 - x1) / xi_mais_1);

        % Impressão dos resultados
        fprintf('%5d | %18.10f | %18.10f | %18.10f | %15.2e\n', i, x0, x1, xi_mais_1, ER);

        % Critério de Parada
        if ER < tol || abs(f_anon(xi_mais_1)) < 1e-14
            fprintf('%s\n', div);
            fprintf('>> Convergência atingida! Raiz aproximada: %.15f\n', xi_mais_1);
            break;
        end

        % Atualização dos pontos para a próxima iteração
        x0 = x1;
        x1 = xi_mais_1;

    catch ME
        fprintf('\n>> Erro no cálculo: %s\n', ME.message);
        break;
    end

    if i == imax
        fprintf('\n>> Aviso: Limite de iterações atingido.\n');
    end
end
