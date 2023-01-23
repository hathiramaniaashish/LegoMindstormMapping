% Script para cargar los datos de un log de escaneado en un array
function [rads] = getDataFromFile(filePath)
% IN: 
%   filePath - ruta al log de escaneo
% OUT: 
%   rads - log de escaneo con medidas de radios del log indicado
% EXAMPLE:
%   getDataFromFile('log_file.txt')

    fileArray = readlines(filePath);
    fileSize = size(fileArray);
    fileSize = fileSize(1);
    
    rads = zeros(fileSize, 1);

    for i = 1:fileSize
        line = split(fileArray(i), ":");
        
        rad = str2double(line(2));

        % Se suma al radio la distancia del sensor al centro de rotación
        % del robot
        rad = rad + 8;

        rads(i) = rad;
    end
end