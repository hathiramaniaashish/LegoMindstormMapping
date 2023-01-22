% Script para obtener gráfica polar, a partir de un fichero log con un 
% ángulo y respectiva su distanica
function [rads] = softFilter(rads)
% IN: 
%   filename - log filename [char]
% OUT: 
%   nothing
% EXAMPLE:
%   PlotEnvironment('log_file.txt')

    fileSize = size(rads);
    fileSize = fileSize(1);
    
    res = rads;

%     figure(1)
%     subplot(3,2,1) % 2 rows, 1 column, first position
%     polarplot(rads);
%     subplot(3,2,2)
%     plot(rads)

    kernel = [1 4 8 4 1];
    k_size = size(kernel);
    k_size = k_size(2);
    hf_k_size = round((k_size + 1)/2);
    
    for i = hf_k_size:(fileSize - hf_k_size + 1)
        accum = 0;
        for j = 1:k_size
            accum = accum + (rads(i - hf_k_size + j) * kernel(j));
%             accum = accum + rads(i + j + 1) - rads(i + j);

        end
        res(i) = accum / sum(kernel, "all");
    end

%     abs(min(res))
    rads = res; % + abs(min(res));
    extreme_error = rads(fileSize - hf_k_size) - rads(hf_k_size);
    for k = 1:hf_k_size
        update_level = (k / k_size);
        rads(hf_k_size - k + 1) = rads(hf_k_size) + (update_level * extreme_error);
        rads(fileSize - hf_k_size + k) = rads(hf_k_size) + ((1 - update_level) * extreme_error);
    end

end