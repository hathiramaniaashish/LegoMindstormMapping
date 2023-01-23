% Script para calibrar medidas polares, en base a un log principal, 
% un log secundario, y la posición real de escaneo del segundo log
% respecto a la posición del log principal
function [res] = calibrateScan(rads_1, rads_2, pos_2)
% IN: 
%   rads_1 - log de escaneo principal con medidas de radios
%   rads_2 - log de escaneo secundario con medidas de radios
%   pos_2 - posición real de escaneo del segundo log respecto a la
%   posición del log principal
% OUT: 
%   res - medidas calibradas
% EXAMPLE:
%   calibrateScan(raw_scan_1, raw_scan_2, [30 30]);

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
        end

    end
    
end