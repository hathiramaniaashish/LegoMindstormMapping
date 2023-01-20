% Script para obtener gráfica polar, a partir de un fichero log con un 
% ángulo y respectiva su distanica
function [] = PlotEnvironment(filePath)
% IN: 
%   filename - log filename [char]
% OUT: 
%   nothing
% EXAMPLE:
%   PlotEnvironment('log_file.txt')

    fileArray = readlines(filePath);
    fileSize = size(fileArray);
    fileSize = fileSize(1);
    
    rads = zeros(fileSize, 1);
    angs = zeros(fileSize, 1);
    res = zeros(fileSize, 1);

    for i = 1:fileSize
        line = split(fileArray(i), ":");
        
        rad = str2double(line(2));
        ang = str2double(line(3));

        % Se suma al radio la distancia del sensor al centro de rotación
        % del robot
        rad = rad + 8;

        rads(i) = rad;
        angs(i) = ang;
    end

    figure(1)
    subplot(3,2,1) % 2 rows, 1 column, first position
    polarplot(rads);
    subplot(3,2,2)
    plot(rads)

    kernel = [1 4 8 4 1];
    k_size = size(kernel);
    k_size = k_size(2);
    for i = 3:(fileSize - 2)
        accum = 0;
        for j = 1:k_size
            accum = accum + (rads(i - round(k_size / 2, 0) + j) * kernel(j));
%             accum = accum + rads(i + j + 1) - rads(i + j);

        end
        res(i) = accum / 18;
    end

    rads = res + abs(min(res));
    for k = 1:3
        rads(k) = rads(3);
        rads(fileSize - 3 + k) = rads(fileSize - 2);
    end

    subplot(3,2,3)
    polarplot(rads);
    subplot(3,2,4)
    plot(rads)

%     kernel = [-6 -4 -4 1 1 4 4 6];
%     k_size = size(kernel);
%     k_size = k_size(2);
%     for i = 4:(fileSize - 4)
%         accum = 0;
%         for j = 1:k_size
%             accum = accum + (rads(i - round(k_size / 2, 0) + j) * kernel(j));
% %             accum = accum + rads(i + j + 1) - rads(i + j);
% 
%         end
%         res(i) = accum / 15;
%     end
% 
%     rads = res;
%     
%     subplot(3,2,5)
%     polarplot(rads);
%     subplot(3,2,6)
%     plot(rads)

end