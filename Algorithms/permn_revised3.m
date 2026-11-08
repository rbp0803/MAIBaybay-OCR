% ---------------------------------------------------------------------------------------%
% Generates an array of valid vectors from transliterated Baybayin words.                %                           
% Programmed by Rodney Pino at University of the Philippines - Diliman                   %
% Programming dates: August 2025 to October 2025                                         % 
% ---------------------------------------------------------------------------------------%

function A = permn_revised3(C, k)
    N = numel(k);
    vals = cell(1, N);
    for j = 1:N
        vals{j} = C(C <= k(j));   % allowed values for column j
    end
    [grids{1:N}] = ndgrid(vals{:});
    A = cell2mat(cellfun(@(x)x(:), grids, 'UniformOutput', false));
end