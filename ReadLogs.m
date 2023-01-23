% [theta, rho] = readFile('logs/log-caja1_59x39.txt');
% polarplot(thetaMerge, rhoMerge);
%[theta, rho] = deleteCornerPoints(theta, rho);
%polarscatter(theta, rho)

% [theta1, rho1] = readFile('logs/mapa1/log_sensor1_mapa1(101x105)_sin_obstaculos.txt');
% [theta2, rho2] = readFile('logs/mapa1/log_sensor2_mapa1(101x105)_sin_obstaculos.txt');
% [theta3, rho3] = readFile('logs/mapa1/log_sensor3_mapa1(101x105)_sin_obstaculos.txt');
% 
% [x1, y1] = pol2cart(theta1, rho1);
% [x2, y2] = pol2cart(theta2 + pi/2, rho2);
% [x3, y3] = pol2cart(theta3 + 3*pi/2, rho3);
% 
% xMerge = cat(1, x1, x2-30, x3+40);
% yMerge = cat(1, y1, y2+35, y3-26);
% 
% [thetaMerge, rhoMerge] = cart2pol(xMerge, yMerge);
% [thetaMerge, sortIdx] = sort(thetaMerge);
% rhoMerge = rhoMerge(sortIdx);
% [thetaMerge, rhoMerge] = deleteCornerPoints(thetaMerge, rhoMerge);
% polarscatter(thetaMerge, rhoMerge);
%plotLines(thetaMerge, rhoMerge);

% [theta1, rho1] = readFile('logs/mapa2/log_sensor1.txt');
% [theta2, rho2] = readFile('logs/mapa2/log_sensor2.txt');
% [theta3, rho3] = readFile('logs/mapa2/log_sensor3.txt');
% [theta4, rho4] = readFile('logs/mapa2/log_sensor4.txt');
% 
% [x1, y1] = pol2cart(theta1 + pi/2, rho1);
% [x2, y2] = pol2cart(theta2 + pi/2, rho2);
% [x3, y3] = pol2cart(theta3 + pi/2, rho3);
% [x4, y4] = pol2cart(theta4 + pi/2, rho4);
% 
% xMerge = cat(1, x1-40, x2-40, x3+40, x4+40);
% yMerge = cat(1, y1-40, y2+40, y3+40, y4-40);
% 
% scatter(xMerge, yMerge);
% 
% [thetaMerge, rhoMerge] = cart2pol(xMerge, yMerge);
% 
% polarscatter(thetaMerge, rhoMerge);
% 
% [thetaMerge, sortIdx] = sort(thetaMerge);
% rhoMerge = rhoMerge(sortIdx);
% [thetaMerge, rhoMerge] = deleteSomePoints(thetaMerge, rhoMerge);
% polarscatter(thetaMerge, rhoMerge);

function [] = plotLines(theta, rho)
    while (length(theta) > 3)
        [thetaL, rhoL, theta, rho] = getLine(theta, rho);
        polarplot(thetaL, rhoL);
        hold on;
    end
    hold off;
end

function [thetaA, rhoA, theta, rho] = getLine(theta, rho)
    th = threshold(theta, rho);
    dist = 0;
    thetaA = [];
    rhoA = [];
    while (dist <= th)
        thetaA = [thetaA, theta(1)];
        rhoA = [rhoA, rho(1)];

        dists = getDistRespectAPoint(theta, rho, 1);

        theta(1) = [];
        rho(1) = [];

        [dists, sortIdx] = sort(dists);
        theta = theta(sortIdx);
        rho = rho(sortIdx);

        if isempty(dists)
            break
        end
        dist = dists(1);
    end
end


function [theta, rho] = readFile(fileName)
    delimiterIn = ':';
    data = importdata(fileName, delimiterIn);
    theta = data(:,3) * pi/180;
    rho = data(:,2);
end

function [theta, rho] = deleteSomePoints(theta, rho)
    th = threshold(theta, rho);
    auxTheta = [theta(1)];
    auxRho = [rho(1)];
    for i = 1:length(rho)-1
        x1 = i;
        x2 = i+1;
        dist = getDist(theta(x1),theta(x2),rho(x1),rho(x2));
        if dist <= th
            auxRho = [auxRho, rho(x2)];
            auxTheta = [auxTheta, theta(x2)];
        end
    end
    theta = auxTheta;
    rho = auxRho;
end

function [] = saveImages(theta, rho, name)
    saveas(polarscatter(theta, rho), "puntosPolares" + name + ".png");
    saveas(polarplot(theta, rho), "mapeado" + name + ".png");
end

function[dist] = getDist(theta1, theta2, rho1, rho2)
    dist = sqrt(rho1^2 + rho2^2 - 2*rho1*rho2*cos(theta2-theta1));
end

function [dists] = getDists(theta, rho)
    dists = [];
    for i = 1:length(rho)-1
        x1 = i;
        x2 = i+1;
        dist = getDist(theta(x1),theta(x2),rho(x1),rho(x2));
        dists = [dists, dist];
    end
end

function [dists] = getDistRespectAPoint(theta, rho, x1)
    dists = [];
    for i = 1:length(rho)
        x2 = i;
        if x2 == x1
            continue;
        end
        dist = getDist(theta(x1),theta(x2),rho(x1),rho(x2));
        dists = [dists, dist];
    end
end

function [th] = threshold(theta, rho)
    dists = getDists(theta, rho);
    th = median(dists);
end