% Script para obtener gráfica polar, a partir de un fichero log con un 
% ángulo y respectiva su distanica
function [res] = calibrateScan(rads_1, rads_2, pos_2)
% IN: 
%   filename - log filename [char]
% OUT: 
%   nothing
% EXAMPLE:
%   PlotEnvironment('log_file.txt')

    fileSize = size(rads_1);
    fileSize = fileSize(1);
    ang_step_size = 360 / fileSize;
    
    res = rads_1;

    for i = 1:fileSize
        ang = i * ang_step_size;
        pos_1 = [rads_2(i) * cos(ang) rads_2(i) * sin(ang)];
        pos_0 = [pos_1(1) pos_2(2)];

        new_ang = atan2(abs(det([pos_2-pos_1;pos_0-pos_1])),dot(pos_2-pos_1,pos_0-pos_1));
        new_ang = 360 - (new_ang * 180/pi);
        new_rad = sqrt((pos_1(1) - pos_2(1))^2 + (pos_1(2) - pos_2(2))^2);

        ang_index = round(new_ang / ang_step_size);
        error = ((rads_2(ang_index) + new_rad) / 2) / new_rad;

        if error <= 1.2 && error >= 0.8
            res(i) = error * res(i);
%         elseif new_rad < res(i)
%             res(i) = new_rad;
        end

    end
    
end