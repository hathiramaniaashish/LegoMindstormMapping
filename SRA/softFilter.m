% Script para suavizar medidas de un array, pasandolo por un 
% filtro (kernel)
function [rads] = softFilter(rads)
% IN: 
%   rads - log de escaneo con medidas de radios
% OUT: 
%   rads - medidas de radios suavizados
% EXAMPLE:
%   softFilter(calib_scan);

    fileSize = size(rads);
    fileSize = fileSize(1);
    
    res = rads;

    kernel = [1 4 8 4 1];
    k_size = size(kernel);
    k_size = k_size(2);
    hf_k_size = round((k_size + 1)/2);
    
    for i = hf_k_size:(fileSize - hf_k_size + 1)
        accum = 0;
        for j = 1:k_size
            accum = accum + (rads(i - hf_k_size + j) * kernel(j));

        end
        res(i) = accum / sum(kernel, "all");
    end

    rads = res;
    extreme_error = rads(fileSize - hf_k_size) - rads(hf_k_size);
    for k = 1:hf_k_size
        update_level = (k / k_size);
        rads(hf_k_size - k + 1) = rads(hf_k_size) + (update_level * extreme_error);
        rads(fileSize - hf_k_size + k) = rads(hf_k_size) + ((1 - update_level) * extreme_error);
    end

end